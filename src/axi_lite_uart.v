//******************************************************************************
/// @FILE    axi_lite_uart.v
/// @AUTHOR  JAY CONVERTINO
/// @DATE    2024.02.29
/// @BRIEF   AXIS UART
/// @DETAILS
///
/// @LICENSE MIT
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

//UART
module axi_lite_uart #(
    parameter CLOCK_SPEED       = 100000000,
    parameter BAUD_RATE         = 115200,
    parameter PARITY_ENA        = 0,
    parameter PARITY_TYPE       = 0,
    parameter STOP_BITS         = 1,
    parameter DATA_BITS         = 8,
    parameter RX_DELAY          = 0,
    parameter RX_BAUD_DELAY     = 0,
    parameter TX_DELAY          = 0,
    parameter TX_BAUD_DELAY     = 0
  )
  (
    //clock and reset
    input           aclk,
    input           arstn,
    //AXI lite interface
    input           s_axi_aclk,
    input           s_axi_aresetn,
    input           s_axi_awvalid,
    input   [15:0]  s_axi_awaddr,
    input   [ 2:0]  s_axi_awprot,
    output          s_axi_awready,
    input           s_axi_wvalid,
    input   [31:0]  s_axi_wdata,
    input   [ 3:0]  s_axi_wstrb,
    output          s_axi_wready,
    output          s_axi_bvalid,
    output  [ 1:0]  s_axi_bresp,
    input           s_axi_bready,
    input           s_axi_arvalid,
    input   [15:0]  s_axi_araddr,
    input   [ 2:0]  s_axi_arprot,
    output          s_axi_arready,
    output          s_axi_rvalid,
    output  [31:0]  s_axi_rdata,
    output  [ 1:0]  s_axi_rresp,
    input           s_axi_rready,
    //irq
    output          irq,
    //UART
    output          tx,
    input           rx,
    output          rts,
    input           cts
  );

  //read interface
  wire          up_rreq;
  wire          up_rack;
  wire  [13:0]  up_raddr;
  wire  [31:0]  up_rdata;
  //write interface
  wire          up_wreq;
  wire          up_wack;
  wire  [13:0]  up_waddr;
  wire  [31:0]  up_wdata;

  up_axi inst_up_axi (
    .up_rstn (arstn),
    .up_clk (aclk),
    .up_axi_awvalid(s_axi_awvalid),
    .up_axi_awaddr(s_axi_awaddr),
    .up_axi_awready(s_axi_awready),
    .up_axi_wvalid(s_axi_wvalid),
    .up_axi_wdata(s_axi_wdata),
    .up_axi_wstrb(s_axi_wstrb),
    .up_axi_wready(s_axi_wready),
    .up_axi_bvalid(s_axi_bvalid),
    .up_axi_bresp(s_axi_bresp),
    .up_axi_bready(s_axi_bready),
    .up_axi_arvalid(s_axi_arvalid),
    .up_axi_araddr(s_axi_araddr),
    .up_axi_arready(s_axi_arready),
    .up_axi_rvalid(s_axi_rvalid),
    .up_axi_rresp(s_axi_rresp),
    .up_axi_rdata(s_axi_rdata),
    .up_axi_rready(s_axi_rready),
    .up_wreq(up_wreq),
    .up_waddr(up_waddr),
    .up_wdata(up_wdata),
    .up_wack(up_wack),
    .up_rreq(up_rreq),
    .up_raddr(up_raddr),
    .up_rdata(up_rdata),
    .up_rack(up_rack)
  );

  up_uart #(
    .CLOCK_SPEED(CLOCK_SPEED),
    .BAUD_RATE(BAUD_RATE),
    .PARITY_ENA(PARITY_ENA),
    .PARITY_TYPE(PARITY_TYPE),
    .STOP_BITS(STOP_BITS),
    .DATA_BITS(DATA_BITS),
    .RX_DELAY(RX_DELAY),
    .RX_BAUD_DELAY(RX_BAUD_DELAY),
    .TX_DELAY(TX_DELAY),
    .TX_BAUD_DELAY(TX_BAUD_DELAY)
  ) inst_up_uart (
    //axis clock and reset
    .clk(aclk),
    .rstn(arstn),
    //UP interface
    //read interface
    .up_rreq(up_rreq),
    .up_rack(up_rack),
    .up_raddr(up_raddr),
    .up_rdata(up_rdata),
    //write interface
    .up_wreq(up_wreq),
    .up_wack(up_wack),
    .up_waddr(up_waddr),
    .up_wdata(up_wdata),
    //irq
    .irq(irq),
    //UART
    .tx(tx),
    .rx(rx),
    .rts(rts),
    .cts(cts)
  );
endmodule
