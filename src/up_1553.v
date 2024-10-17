//******************************************************************************
/// @FILE    up_1553.v
/// @AUTHOR  JAY CONVERTINO
/// @DATE    2024.10.17
/// @BRIEF   AXIS 1553
/// @DETAILS Core for interfacing with simple 1553 communications.
///
///  @LICENSE MIT
///  Copyright 2024 Jay Convertino
///
///  Permission is hereby granted, free of charge, to any person obtaining a copy
///  of this software and associated documentation files (the "Software"), to 
///  deal in the Software without restriction, including without limitation the
///  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
///  sell copies of the Software, and to permit persons to whom the Software is 
///  furnished to do so, subject to the following conditions:
///
///  The above copyright notice and this permission notice shall be included in 
///  all copies or substantial portions of the Software.
///
///  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
///  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
///  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
///  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
///  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
///  IN THE SOFTWARE.
//******************************************************************************

`timescale 1ns/100ps

//UP 1553
module up_1553 #(
    parameter ADDRESS_WIDTH = 32,
    parameter BUS_WIDTH     = 4,
    parameter CLOCK_SPEED   = 100000000,
    parameter SAMPLE_RATE   = 2000000,
    parameter BIT_SLICE_OFFSET  = 0,
    parameter INVERT_DATA       = 0,
    parameter SAMPLE_SELECT     = 0
  ) 
  (
    //clock and reset
    input           clk,
    input           rstn,
    //UP interface
    //read interface
    input                       up_rreq,
    output                      up_rack,
    input   [ADDRESS_WIDTH-1:0] up_raddr,
    output  [(BUS_WIDTH*8)-1:0] up_rdata,
    //write interface
    input                       up_wreq,
    output                      up_wack,
    input   [ADDRESS_WIDTH-1:0] up_waddr,
    input   [(BUS_WIDTH*8)-1:0] up_wdata,
    //1553 diffs
    input   [1:0]               i_diff,
    output  [1:0]               o_diff,
    output                      en_o_diff,
    output                      irq

  );

  //FIFO Depth matches UART LITE (xilinx), so I kept this just cause
  localparam FIFO_DEPTH = 16;

  //register address decoding
  localparam RX_FIFO_REG = 4'h0;
  localparam TX_FIFO_REG = 4'h4;
  localparam STATUS_REG  = 4'h8;
  localparam CONTROL_REG = 4'hC;

  localparam ENABLE_INTR_BIT  = 4;
  localparam RESET_RX_BIT     = 1;
  localparam RESET_TX_BIT     = 0;

  //fifo internal reset
  reg  [FIFO_DEPTH-1:0]     r_rstn_rx_delay;
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
  reg                       r_rx_ren;

  //up registers
  reg                       r_up_rack;
  reg  [(BUS_WIDTH*8)-1:0]  r_up_rdata;
  reg                       r_up_wack;

  //control register
  reg  [(BUS_WIDTH*8)-1:0]  r_control_reg;
  reg                       r_irq_en;

  //interrupt
  reg                       r_irq;

  //output signals assigned to registers.
  assign up_rack  = r_up_rack & up_rreq;
  assign up_wack  = r_up_wack & up_wreq;
  assign up_rdata = r_up_rdata;
  assign irq      = r_irq;

  assign s_rx_ren = ((up_raddr[3:0] == RX_FIFO_REG) && up_rreq ? r_up_rack & r_rx_ren : 0);

  //up registers decoder
  always @(posedge clk)
  begin
    if(rstn == 1'b0)
    begin
      r_up_rack   <= 1'b0;
      r_up_wack   <= 1'b0;
      r_up_rdata  <= 0;

      r_rx_ren    <= 1'b0;

      r_control_reg <= 0;
    end else begin
      r_up_rack   <= 1'b0;
      r_up_wack   <= 1'b0;
      r_tx_wen    <= 1'b0;
      r_rx_ren    <= 1'b0;
      r_up_rdata  <= r_up_rdata;
      //clear reset bits
      r_control_reg[RESET_RX_BIT] <= 1'b0;
      r_control_reg[RESET_TX_BIT] <= 1'b0;

      if(up_rreq == 1'b1)
      begin
        r_up_rack <= 1'b1;

        case(up_raddr[3:0])
          RX_FIFO_REG: begin
            r_up_rdata <= rx_rdata & {{(BUS_WIDTH*8-DATA_BITS){1'b0}}, {DATA_BITS{1'b1}}};
            r_rx_ren <= 1'b1;
          end
          STATUS_REG: begin                         //Data parity?, invert?,  4uS delay?
            r_up_rdata <= {{(BUS_WIDTH*8-8){1'b0}}, rx_rdata[16], rx_rdata[17], rx_rdata[18], r_irq_en, tx_full, tx_empty, rx_full, rx_valid};
          end
          default:begin
            r_up_rdata <= 0;
          end
        endcase
      end

      if(up_wreq == 1'b1)
      begin
        r_up_wack <= 1'b1;

        if(r_up_wack == 1'b1) begin
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
  end

  //up control register processing and fifo reset
  always @(posedge clk)
  begin
    if(rstn == 1'b0)
    begin
      r_rstn_rx_delay <= ~0;
      r_rstn_tx_delay <= ~0;
      r_irq_en <= 1'b0;
    end else begin
      r_rstn_rx_delay <= {1'b1, r_rstn_rx_delay[FIFO_DEPTH-1:1]};
      r_rstn_tx_delay <= {1'b1, r_rstn_rx_delay[FIFO_DEPTH-1:1]};

      if(r_control_reg[RESET_RX_BIT])
      begin
        r_rstn_rx_delay <= {FIFO_DEPTH{1'b0}};
      end

      if(r_control_reg[RESET_TX_BIT])
      begin
        r_rstn_tx_delay <= {FIFO_DEPTH{1'b0}};
      end

      if(r_control_reg[ENABLE_INTR_BIT] != r_irq_en)
      begin
        r_irq_en <= r_control_reg[ENABLE_INTR_BIT];
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

  axis_1553_encoder #(
    .CLOCK_SPEED(CLOCK_SPEED),
    .SAMPLE_RATE(SAMPLE_RATE)
  ) inst_axis_1553_encoder (
    //clock and reset
    .aclk(clk),
    .arstn(rstn),
    //slave input
    .s_axis_tdata(tx_rdata[15:0]),
    .s_axis_tvalid(tx_valid),
    .s_axis_tuser(tx_rdata[23:16]),
    .s_axis_tready(s_axis_tready),
    //diff output
    .diff(o_diff),
    //enable output
    .en_diff(en_o_diff)
  );

  axis_1553_decoder #(
    .CLOCK_SPEED(CLOCK_SPEED),
    .SAMPLE_RATE(SAMPLE_RATE),
    .BIT_SLICE_OFFSET(BIT_SLICE_OFFSET),
    .INVERT_DATA(INVERT_DATA),
    .SAMPLE_SELECT(SAMPLE_SELECT)
  ) inst_axis_1553_decoder (
    //clock and reset
    .aclk(clk),
    .arstn(rstn),
    //master output
    .m_axis_tdata(m_axis_tdata[15:0]),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tuser(m_axis_tdata[23:16]),
    .m_axis_tready(~rx_full),
    //diff input
    .diff(i_diff)
  );

  //fifo for data to receive via uart
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
    // read interface
    .rd_clk(clk),
    .rd_rstn(rstn & r_rstn_rx_delay[0]),
    .rd_en(s_rx_ren),
    .rd_valid(rx_valid),
    .rd_data(rx_rdata),
    .rd_empty(rx_empty),
    // write interface
    .wr_clk(clk),
    .wr_rstn(rstn & r_rstn_rx_delay[0]),
    .wr_en(m_axis_tvalid),
    .wr_ack(),
    .wr_data({{(BUS_WIDTH*8-DATA_BITS){1'b0}}, m_axis_tdata}),
    .wr_full(rx_full),
    // data count interface
    .data_count_clk(clk),
    .data_count_rstn(rstn & r_rstn_rx_delay[0]),
    .data_count()
  );

  //fifo for data to transmit via uart
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
    // read interface
    .rd_clk(clk),
    .rd_rstn(rstn & r_rstn_tx_delay[0]),
    .rd_en(s_axis_tready),
    .rd_valid(tx_valid),
    .rd_data(tx_rdata),
    .rd_empty(tx_empty),
    // write interface
    .wr_clk(clk),
    .wr_rstn(rstn & r_rstn_tx_delay[0]),
    .wr_en(r_tx_wen),
    .wr_ack(),
    .wr_data(r_tx_wdata),
    .wr_full(tx_full),
    // data count interface
    .data_count_clk(clk),
    .data_count_rstn(rstn & r_rstn_tx_delay[0]),
    .data_count()
  );
endmodule
