//******************************************************************************
/// @FILE    wishbone_1553.v
/// @AUTHOR  JAY CONVERTINO
/// @DATE    2024.10.17
/// @BRIEF   WISHBONE 1553
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
module wishbone_classic_1553 #(
    parameter ADDRESS_WIDTH     = 32,
    parameter BUS_WIDTH         = 4,
    parameter CLOCK_SPEED       = 100000000,
    parameter SAMPLE_RATE       = 2000000,
    parameter BIT_SLICE_OFFSET  = 0,
    parameter INVERT_DATA       = 0,
    parameter SAMPLE_SELECT     = 0
  )
  (
    //clock and reset
    input           clk,
    input           rst,
    //Wishbone
    input                       s_wb_cyc,
    input                       s_wb_stb,
    input                       s_wb_we,
    input   [ADDRESS_WIDTH-1:0] s_wb_addr,
    input   [BUS_WIDTH*8-1:0]   s_wb_data_i,
    input   [ 3:0]              s_wb_sel,
    input   [ 1:0]              s_wb_bte,
    input   [ 2:0]              s_wb_cti,
    output                      s_wb_ack,
    output  [BUS_WIDTH*8-1:0]   s_wb_data_o,
    output                      s_wb_err,
    //1553 diffs
    input   [1:0]               i_diff,
    output  [1:0]               o_diff,
    output                      en_o_diff,
    output                      irq
  );

  //read interface
  wire                      up_rreq;
  wire                      up_rack;
  wire  [ADDRESS_WIDTH-1:0] up_raddr;
  wire  [BUS_WIDTH*8-1:0]   up_rdata;
  //write interface
  wire                      up_wreq;
  wire                      up_wack;
  wire  [ADDRESS_WIDTH-1:0] up_waddr;
  wire  [BUS_WIDTH*8-1:0]   up_wdata;

  up_wishbone_classic #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .BUS_WIDTH(BUS_WIDTH)
  ) inst_up_wishbone_classic (
    .clk(clk),
    .rst(rst),
    //Wishbone
    .s_wb_cyc(s_wb_cyc),
    .s_wb_stb(s_wb_stb),
    .s_wb_we(s_wb_we),
    .s_wb_addr(s_wb_addr),
    .s_wb_data_i(s_wb_data_i),
    .s_wb_sel(s_wb_sel),
    .s_wb_cti(s_wb_cti),
    .s_wb_bte(s_wb_bte),
    .s_wb_ack(s_wb_ack),
    .s_wb_data_o(s_wb_data_o),
    .s_wb_err(s_wb_err),
    //uP
    //read interface
    .up_rreq(up_rreq),
    .up_rack(up_rack),
    .up_raddr(up_raddr),
    .up_rdata(up_rdata),
    //write interface
    .up_wreq(up_wreq),
    .up_wack(up_wack),
    .up_waddr(up_waddr),
    .up_wdata(up_wdata)
  );

  up_1553 #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .BUS_WIDTH(BUS_WIDTH),
    .CLOCK_SPEED(CLOCK_SPEED),
    .SAMPLE_RATE(SAMPLE_RATE),
    .BIT_SLICE_OFFSET(BIT_SLICE_OFFSET),
    .INVERT_DATA(INVERT_DATA),
    .SAMPLE_SELECT(SAMPLE_SELECT)
  ) inst_up_1553 (
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
    //1553 diffs
    .i_diff(i_diff),
    .o_diff(o_diff),
    .en_o_diff(en_o_diff),
    .irq(i

endmodule
