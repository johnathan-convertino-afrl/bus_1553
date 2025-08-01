//******************************************************************************
// file:    up_1553.v
//
// author:  JAY CONVERTINO
//
// date:    2024/10/17
//
// about:   Brief
// uP Core for interfacing with simple 1553 communications.
//
// license: License MIT
// Copyright 2024 Jay Convertino
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//
//******************************************************************************

`timescale 1ns/100ps

/*
 * Module: up_1553
 *
 * uP based 1553 communications device.
 *
 * Parameters:
 *
 *   ADDRESS_WIDTH   - Width of the uP address port, max 32 bit.
 *   BUS_WIDTH       - Width of the uP bus data port.
 *   CLOCK_SPEED     - This is the aclk frequency in Hz
 *
 * Ports:
 *
 *   clk            - Clock for all devices in the core
 *   rstn           - Negative reset
 *   up_rreq        - uP bus read request
 *   up_rack        - uP bus read ack
 *   up_raddr       - uP bus read address
 *   up_rdata       - uP bus read data
 *   up_wreq        - uP bus write request
 *   up_wack        - uP bus write ack
 *   up_waddr       - uP bus write address
 *   up_wdata       - uP bus write data
 *   rx_diff        - Input differential signal for 1553 bus
 *   tx_diff        - Output differential signal for 1553 bus
 *   tx_active      - Enable output of differential signal as this indicates tx is active (for signal switching on 1553 module)
 *   irq            - Interrupt when data is received
 */
module up_1553 #(
    parameter ADDRESS_WIDTH = 32,
    parameter BUS_WIDTH     = 4,
    parameter CLOCK_SPEED   = 100000000
  ) 
  (
    input                                           clk,
    input                                           rstn,
    input                                           up_rreq,
    output                                          up_rack,
    input   [ADDRESS_WIDTH-(BUS_WIDTH/2)-1:0]       up_raddr,
    output  [(BUS_WIDTH*8)-1:0]                     up_rdata,
    input                                           up_wreq,
    output                                          up_wack,
    input   [ADDRESS_WIDTH-(BUS_WIDTH/2)-1:0]       up_waddr,
    input   [(BUS_WIDTH*8)-1:0]                     up_wdata,
    input   [1:0]                                   rx_diff,
    output  [1:0]                                   tx_diff,
    output                                          tx_active,
    output                                          irq
  );
  // var: DIVISOR
  // Divide the address register default location for 1 byte access to multi byte access. (register offsets are byte offsets).
  localparam DIVISOR = BUS_WIDTH/2;

  // var: FIFO_DEPTH
  // Depth of the fifo, matches UART LITE (xilinx), so I kept this just cause
  localparam FIFO_DEPTH = 16;

  // var: DATA_BITS
  // Number of bits in RX/TX FIFO that are valid.
  localparam DATA_BITS = 21;

  // Group: Register Information
  // Core has 4 registers at the offsets that follow.
  //
  //  <RX_FIFO_REG> - h0
  //  <TX_FIFO_REG> - h4
  //  <STATUS_REG>  - h8
  //  <CONTROL_REG> - hC

  // Register Address: RX_FIFO_REG
  // Defines the address offset for RX FIFO
  // (see diagrams/reg_RX_FIFO.png)
  // Valid bits are from 20:0. Bits 20:16 are status bits information about the data.  Bit 15:0 are data.
  //
  // Status Bits:
  // {S:1,D:1,TY:3}
  //
  // TY - Type is 3 bits, 000 NA, 001 = REG, 010 = DATA, 100 = CMD/STATUS
  // D  - Delay Enabled is 1 bit, 1 is there was be a delay of 4 us or more, or 0 no delay.
  // S  - Sync only when 1, normal is 0
  localparam RX_FIFO_REG = 4'h0 >> DIVISOR;
  // Register Address: TX_FIFO_REG
  // Defines the address offset to write the TX FIFO.
  // (see diagrams/reg_TX_FIFO.png)
  // Valid bits are from 20:0. Bits 20:16 are status bits information about the data.  Bit 15:0 are data.
  //
  // Status Bits:
  // {S:1,D:1,TY:3}
  //
  // TY - Type is 3 bits, 000 NA, 001 = REG, 010 = DATA, 100 = CMD/STATUS
  // D  - Delay Enabled is 1 bit, 1 is there must be a delay of 4 us or more, or 0 no delay.
  // S  - Sync only when 1, normal is 0
  localparam TX_FIFO_REG = 4'h4 >> DIVISOR;
  // Register Address: STATUS_REG
  // Defines the address offset to read the status bits.
  // (see diagrams/reg_STATUS.png)
  localparam STATUS_REG  = 4'h8 >> DIVISOR;
  /* Register Bits: Status Register Bits
   *
   * parity_err - 7, When 1 an error in the RX parity check has occured
   * frame_err  - 6, When 1 an error in the RX frame has occured (manchester data 2'b11 or 2'b00).
   * rx_hold_en - 5, When 1 the RX HOLD is enable by <CONTROL_REG>
   * irq_en     - 4, When 1 the IRQ is enabled by <CONTROL_REG>
   * tx_full    - 3, When 1 the tx fifo is full.
   * tx_empty   - 2, When 1 the tx fifo is empty.
   * rx_full    - 1, When 1 the rx fifo is full.
   * rx_valid   - 0, When 1 the rx fifo contains valid data.
   */
  // Register Address: CONTROL_REG
  // Defines the address offset to set the control bits.
  // (see diagrams/reg_CONTROL.png)
  // See Also: <ENABLE_INTR_BIT>, <RESET_RX_BIT>, <RESET_TX_BIT>
  localparam CONTROL_REG = 4'hC;
  /* Register Bits: Control Register Bits
   *
   * ENABLE_INTR_BIT    - 4, Control Register offset bit for enabling the interrupt.
   * ENABLE_RX_HOLD_BIT - 3, Control that RX will hold its clock on non diffs for a moment.
   * RESET_RX_BIT       - 1, Control Register offset bit for resetting the RX FIFO.
   * RESET_TX_BIT       - 0, Control Register offset bit for resetting the TX FIFO.
   */
  localparam ENABLE_INTR_BIT    = 4;
  localparam ENABLE_RX_HOLD_BIT = 3;
  localparam RESET_RX_BIT       = 1;
  localparam RESET_TX_BIT       = 0;


  // Register for reset delay once RESET_RX_BIT is set.
  reg  [FIFO_DEPTH-1:0]     r_rstn_rx_delay;
  // Register for reset delay once RESET_TX_BIT is set.
  reg  [FIFO_DEPTH-1:0]     r_rstn_tx_delay;

  //uart tx
  wire [(BUS_WIDTH*8)-1:0]  tx_rdata;
  wire                      tx_valid;
  wire                      s_axis_tready;
  wire                      tx_full;
  wire                      tx_empty;
  reg  [(BUS_WIDTH*8)-1:0]  r_tx_wdata;
  reg                       r_tx_wen;

  //uart rx
  wire [(BUS_WIDTH*8)-1:0]  m_axis_tdata;
  wire                      m_axis_tvalid;
  wire                      rx_full;
  wire [(BUS_WIDTH*8)-1:0]  rx_rdata;
  wire                      rx_valid;
  wire                      rx_empty;
  wire                      s_rx_ren;
  wire                      s_parity_err;
  wire                      s_frame_err;

  //up registers
  reg                       r_up_rack;
  reg  [(BUS_WIDTH*8)-1:0]  r_up_rdata;
  reg                       r_up_wack;

  //control register
  reg  [(BUS_WIDTH*8)-1:0]  r_control_reg;
  reg                       r_irq_en;
  reg                       r_rx_hold_en;

  //interrupt
  reg                       r_irq;

  //output signals assigned to registers.
  assign up_rack  = r_up_rack;
  assign up_wack  = r_up_wack;
  assign up_rdata = r_up_rdata;
  assign irq      = r_irq;

  assign s_rx_ren = (up_raddr[3:0] == RX_FIFO_REG) && up_rreq;

  //up registers decoder
  always @(posedge clk)
  begin
    if(rstn == 1'b0)
    begin
      r_up_rack   <= 1'b0;
      r_up_wack   <= 1'b0;
      r_up_rdata  <= 0;

      r_control_reg <= 0;
    end else begin
      r_up_rack   <= 1'b0;
      r_up_wack   <= 1'b0;
      r_tx_wen    <= 1'b0;
      r_up_rdata  <= r_up_rdata;
      //clear reset bits
      r_control_reg[RESET_RX_BIT] <= 1'b0;
      r_control_reg[RESET_TX_BIT] <= 1'b0;

      r_up_rack <= up_rreq;

      if(up_rreq == 1'b1) begin
        case(up_raddr[3:0])
          /// @REG RX_FIFO_REG
          RX_FIFO_REG: begin
            r_up_rdata <= {{(BUS_WIDTH*8-DATA_BITS){1'b0}}, rx_rdata[DATA_BITS-1:0]};
          end
          STATUS_REG: begin                         //parity err  //frame err 
            r_up_rdata <= {{(BUS_WIDTH*8-8){1'b0}}, rx_rdata[22], rx_rdata[21], r_rx_hold_en, r_irq_en, tx_full, tx_empty, rx_full, rx_valid};
          end
          default:begin
            r_up_rdata <= 0;
          end
        endcase
      end

      r_up_wack <= up_wreq;

      if(up_wreq == 1'b1) begin
        case(up_waddr[3:0])
          TX_FIFO_REG: begin
            r_tx_wdata  <= up_wdata;
            r_tx_wen    <= 1'b1;
          end
          CONTROL_REG: begin
            r_control_reg <= up_wdata;
          end
          default:begin
          end
        endcase
      end
    end
  end

  //up control register processing and fifo reset
  always @(posedge clk)
  begin
    if(rstn == 1'b0)
    begin
      r_rstn_rx_delay <= ~0;
      r_rstn_tx_delay <= ~0;
      r_rx_hold_en <= 1'b0;
      r_irq_en <= 1'b0;
    end else begin
      r_rstn_rx_delay <= {1'b1, r_rstn_rx_delay[FIFO_DEPTH-1:1]};
      r_rstn_tx_delay <= {1'b1, r_rstn_rx_delay[FIFO_DEPTH-1:1]};

      r_rx_hold_en <= r_control_reg[ENABLE_RX_HOLD_BIT];
      
      r_irq_en <= r_control_reg[ENABLE_INTR_BIT];
      
      if(r_control_reg[RESET_RX_BIT])
      begin
        r_rstn_rx_delay <= {FIFO_DEPTH{1'b0}};
      end

      if(r_control_reg[RESET_TX_BIT])
      begin
        r_rstn_tx_delay <= {FIFO_DEPTH{1'b0}};
      end
    end
  end

  //irq generator
  always @(posedge clk)
  begin
    if(rstn == 1'b0)
    begin
      r_irq <= 1'b0;
    end else if(r_irq_en == 1'b1)
    begin
      r_irq <= 1'b0;

      if(tx_empty || ~rx_empty)
      begin
        r_irq <= 1'b1;
      end
    end
  end
  
  /*
   * Module: inst_axis_1553
   *
   * Decode/Encode differential 1553 data stream to AXIS data format.
   */
  axis_1553 #(
    .CLOCK_SPEED(CLOCK_SPEED),
    .RX_BAUD_DELAY(0),
    .TX_BAUD_DELAY(0)
  ) inst_axis_1553 (
    .aclk(aclk),
    .arstn(rstn & r_rstn_rx_delay[0]),
    .parity_err(m_axis_tdata[22]),
    .frame_err(m_axis_tdata[21]),
    .rx_hold_en(r_rx_hold_en),
    .s_axis_tdata(tx_rdata[15:0]),
    .s_axis_tuser(tx_rdata[20:16]),
    .s_axis_tvalid(tx_valid),
    .s_axis_tready(s_axis_tready),
    .m_axis_tdata(m_axis_tdata[15:0]),
    .m_axis_tuser(m_axis_tdata[20:16]),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tready(~rx_full),
    .tx_active(tx_active),
    .tx_diff(tx_diff),
    .rx_diff(rx_diff)
  );
  
  assign m_axis_tdata[31:23] = 0;

  /*
   * Module: inst_rx_fifo
   *
   * Buffer up to 16 items output from the axis_1553_encoder.
   */
  fifo #(
    .FIFO_DEPTH(FIFO_DEPTH),
    .BYTE_WIDTH(BUS_WIDTH),
    .COUNT_WIDTH(8),
    .FWFT(1),
    .RD_SYNC_DEPTH(0),
    .WR_SYNC_DEPTH(0),
    .DC_SYNC_DEPTH(0),
    .COUNT_DELAY(0),
    .COUNT_ENA(0),
    .DATA_ZERO(0),
    .ACK_ENA(0),
    .RAM_TYPE("block")
  ) inst_rx_fifo (
    .rd_clk(clk),
    .rd_rstn(rstn & r_rstn_rx_delay[0]),
    .rd_en(s_rx_ren),
    .rd_valid(rx_valid),
    .rd_data(rx_rdata),
    .rd_empty(rx_empty),
    .wr_clk(clk),
    .wr_rstn(rstn & r_rstn_rx_delay[0]),
    .wr_en(m_axis_tvalid),
    .wr_ack(),
    .wr_data(m_axis_tdata),
    .wr_full(rx_full),
    .data_count_clk(clk),
    .data_count_rstn(rstn & r_rstn_rx_delay[0]),
    .data_count()
  );

  /*
   * Module: inst_tx_fifo
   *
   * Buffer up to 16 items to input to the axis_1553_decoder.
   */
  fifo #(
    .FIFO_DEPTH(FIFO_DEPTH),
    .BYTE_WIDTH(BUS_WIDTH),
    .COUNT_WIDTH(8),
    .FWFT(1),
    .RD_SYNC_DEPTH(0),
    .WR_SYNC_DEPTH(0),
    .DC_SYNC_DEPTH(0),
    .COUNT_DELAY(0),
    .COUNT_ENA(0),
    .DATA_ZERO(0),
    .ACK_ENA(0),
    .RAM_TYPE("block")
  ) inst_tx_fifo (
    .rd_clk(clk),
    .rd_rstn(rstn & r_rstn_tx_delay[0]),
    .rd_en(s_axis_tready),
    .rd_valid(tx_valid),
    .rd_data(tx_rdata),
    .rd_empty(tx_empty),
    .wr_clk(clk),
    .wr_rstn(rstn & r_rstn_tx_delay[0]),
    .wr_en(r_tx_wen),
    .wr_ack(),
    .wr_data(r_tx_wdata),
    .wr_full(tx_full),
    .data_count_clk(clk),
    .data_count_rstn(rstn & r_rstn_tx_delay[0]),
    .data_count()
  );
  
endmodule
