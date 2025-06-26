//******************************************************************************
// file:    wishbone_classic_1553.v
//
// author:  JAY CONVERTINO
//
// date:    2024/10/17
//
// about:   Brief
// wishbone classic to uP core for 1553 comms.
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
 * Module: wishbone_standard_1553
 *
 * Wishbone Stanard based 1553 communications device.
 *
 * Parameters:
 *
 *   ADDRESS_WIDTH   - Width of the address bus in bits, max 32 bit.
 *   BUS_WIDTH       - Width of the data bus in bytes.
 *   CLOCK_SPEED     - This is the aclk frequency in Hz
 *
 * Ports:
 *
 *   clk            - Clock for all devices in the core
 *   rst            - Positive reset
 *   s_wb_cyc       - Bus Cycle in process
 *   s_wb_stb       - Valid data transfer cycle
 *   s_wb_we        - Active High write, low read
 *   s_wb_addr      - Bus address
 *   s_wb_data_i    - Input data
 *   s_wb_sel       - Device Select
 *   s_wb_ack       - Bus transaction terminated
 *   s_wb_data_o    - Output data
 *   s_wb_err       - Active high when a bus error is present
 *   rx_diff        - Input differential signal for 1553 bus
 *   tx_diff        - Output differential signal for 1553 bus
 *   tx_active      - Enable output of differential signal (for signal switching on 1553 module)
 *   irq            - Interrupt when data is received
 */
module wishbone_standard_1553 #(
    parameter ADDRESS_WIDTH     = 32,
    parameter BUS_WIDTH         = 4,
    parameter CLOCK_SPEED       = 100000000
  )
  (
    input           clk,
    input           rst,
    input                       s_wb_cyc,
    input                       s_wb_stb,
    input                       s_wb_we,
    input   [ADDRESS_WIDTH-1:0] s_wb_addr,
    input   [BUS_WIDTH*8-1:0]   s_wb_data_i,
    input   [BUS_WIDTH-1:0]     s_wb_sel,
    output                      s_wb_ack,
    output  [BUS_WIDTH*8-1:0]   s_wb_data_o,
    output                      s_wb_err,
    input   [1:0]               rx_diff,
    output  [1:0]               tx_diff,
    output                      tx_active,
    output                      irq
  );

  // var: up_rreq
  // uP read bus request
  wire                      up_rreq;
  // var: up_rack
  // uP read bus acknowledge
  wire                      up_rack;
  // var: up_raddr
  // uP read bus address
  wire  [ADDRESS_WIDTH-(BUS_WIDTH/2)-1:0] up_raddr;
  // var: up_rdata
  // uP read bus request
  wire  [31:0]              up_rdata;

  // var: up_wreq
  // uP write bus request
  wire                      up_wreq;
  // var: up_wack
  // uP write bus acknowledge
  wire                      up_wack;
  // var: up_waddr
  // uP write bus address
  wire  [ADDRESS_WIDTH-(BUS_WIDTH/2)-1:0] up_waddr;
  // var: up_wdata
  // uP write bus data
  wire  [31:0]              up_wdata;

  //Group: Instantianted Modules

  // Module: inst_up_wishbone_standard
  //
  // Module instance of up_wishbone_standard for the Wishbone Classic Standard bus to the uP bus.
  up_wishbone_standard #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .BUS_WIDTH(BUS_WIDTH)
  ) inst_up_wishbone_classic (
    .clk(clk),
    .rst(rst),
    .s_wb_cyc(s_wb_cyc),
    .s_wb_stb(s_wb_stb),
    .s_wb_we(s_wb_we),
    .s_wb_addr(s_wb_addr),
    .s_wb_data_i(s_wb_data_i),
    .s_wb_sel(s_wb_sel),
    .s_wb_ack(s_wb_ack),
    .s_wb_data_o(s_wb_data_o),
    .s_wb_err(s_wb_err),
    .up_rreq(up_rreq),
    .up_rack(up_rack),
    .up_raddr(up_raddr),
    .up_rdata(up_rdata),
    .up_wreq(up_wreq),
    .up_wack(up_wack),
    .up_waddr(up_waddr),
    .up_wdata(up_wdata)
  );

  // Module: inst_up_1553
  //
  // Module instance of up_1553 creating a Logic wrapper for 1553 bus cores to interface with uP bus.
  up_1553 #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .BUS_WIDTH(BUS_WIDTH),
    .CLOCK_SPEED(CLOCK_SPEED)
  ) inst_up_1553 (
    .clk(clk),
    .rstn(~rst),
    .up_rreq(up_rreq),
    .up_rack(up_rack),
    .up_raddr(up_raddr),
    .up_rdata(up_rdata),
    .up_wreq(up_wreq),
    .up_wack(up_wack),
    .up_waddr(up_waddr),
    .up_wdata(up_wdata),
    .rx_diff(rx_diff),
    .tx_diff(tx_diff),
    .tx_active(tx_active),
    .irq(irq)
  );

endmodule
