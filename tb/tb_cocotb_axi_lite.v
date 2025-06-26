//******************************************************************************
// file:    tb_cocotb_axi_lite.v
//
// author:  JAY CONVERTINO
//
// date:    2025/04/01
//
// about:   Brief
// Test bench wrapper for cocotb
//
// license: License MIT
// Copyright 2025 Jay Convertino
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
// IN THE SOFTWARE.BUS_WIDTH
//
//******************************************************************************

`timescale 1ns/100ps

/*
 * Module: tb_cocotb
 *
 * AXI Lite slave to AXI Lite 1553 DUT
 *
 * Parameters:
 *
 *   ADDRESS_WIDTH   - Width of the axi address bus, max 32 bit.
 *   BUS_WIDTH       - Width in bytes of the data bus.
 *   CLOCK_SPEED     - This is the aclk frequency in Hz
 *
 * Ports:
 *
 *   aclk           - Clock for all devices in the core
 *   arstn          - Negative reset
 *   s_axi_awvalid  - Axi Lite aw valid
 *   s_axi_awaddr   - Axi Lite aw addr
 *   s_axi_awprot   - Axi Lite aw prot
 *   s_axi_awready  - Axi Lite aw ready
 *   s_axi_wvalid   - Axi Lite w valid
 *   s_axi_wdata    - Axi Lite w data
 *   s_axi_wstrb    - Axi Lite w strb
 *   s_axi_wready   - Axi Lite w ready
 *   s_axi_bvalid   - Axi Lite b valid
 *   s_axi_bresp    - Axi Lite b resp
 *   s_axi_bready   - Axi Lite b ready
 *   s_axi_arvalid  - Axi Lite ar valid
 *   s_axi_araddr   - Axi Lite ar addr
 *   s_axi_arprot   - Axi Lite ar prot
 *   s_axi_arready  - Axi Lite ar ready
 *   s_axi_rvalid   - Axi Lite r valid
 *   s_axi_rdata    - Axi Lite r data
 *   s_axi_rresp    - Axi Lite r resp
 *   s_axi_rready   - Axi Lite r ready
 *   rx_diff        - Input differential signal for 1553 bus
 *   tx_diff        - Output differential signal for 1553 bus
 *   tx_active      - Enable output of differential signal (for signal switching on 1553 module)
 *   irq            - Interrupt when data is received
 */
module tb_cocotb #(
    parameter ADDRESS_WIDTH     = 32,
    parameter BUS_WIDTH         = 4,
    parameter CLOCK_SPEED       = 100000000
  )
  (
    input                       aclk,
    input                       arstn,
    input                       s_axi_awvalid,
    input   [ADDRESS_WIDTH-1:0] s_axi_awaddr,
    input   [ 2:0]              s_axi_awprot,
    output                      s_axi_awready,
    input                       s_axi_wvalid,
    input   [BUS_WIDTH*8-1:0]   s_axi_wdata,
    input   [ 3:0]              s_axi_wstrb,
    output                      s_axi_wready,
    output                      s_axi_bvalid,
    output  [ 1:0]              s_axi_bresp,
    input                       s_axi_bready,
    input                       s_axi_arvalid,
    input   [ADDRESS_WIDTH-1:0] s_axi_araddr,
    input   [ 2:0]              s_axi_arprot,
    output                      s_axi_arready,
    output                      s_axi_rvalid,
    output  [BUS_WIDTH*8-1:0]   s_axi_rdata,
    output  [ 1:0]              s_axi_rresp,
    input                       s_axi_rready,
    input   [1:0]               rx_diff,
    output  [1:0]               tx_diff,
    output                      tx_active,
    output                      irq
  );
  // fst dump command
  initial begin
    $dumpfile ("tb_cocotb.fst");
    $dumpvars (0, tb_cocotb);
    #1;
  end
  
  //Group: Instantiated Modules

  /*
   * Module: dut
   *
   * Device under test, axi_lite_1553
   */
  axi_lite_1553 #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .BUS_WIDTH(BUS_WIDTH),
    .CLOCK_SPEED(CLOCK_SPEED)
  ) dut (
    .aclk(aclk),
    .arstn(arstn),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awprot(s_axi_awprot),
    .s_axi_awready(s_axi_awready),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wready(s_axi_wready),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bready(s_axi_bready),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arready(s_axi_arready),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rready(s_axi_rready),
    .rx_diff(rx_diff),
    .tx_diff(tx_diff),
    .tx_active(tx_active),
    .irq(irq)
  );
  
endmodule

