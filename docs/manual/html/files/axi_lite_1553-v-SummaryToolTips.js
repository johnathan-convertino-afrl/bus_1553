﻿NDSummary.OnToolTipsLoaded("File:axi_lite_1553.v",{10:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">AXI Lite 1553 is a core for interfacing with 1553 devices over the AXI lite bus.</div></div>",11:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Copyright 2024 Jay Convertino</div></div>",73:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype73\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"6\" data-NarrowColumnCount=\"5\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/8/2\" data-NarrowGridArea=\"1/1/2/6\" style=\"grid-area:1/1/8/2\"><span class=\"SHKeyword\">module</span> axi_lite_1553 #(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"2/4/3/5\" style=\"grid-area:1/5/2/6\"><span class=\"SHNumber\">32</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"2/4/3/5\" data-NarrowGridArea=\"3/3/4/4\" style=\"grid-area:2/4/3/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"2/5/3/6\" data-NarrowGridArea=\"3/4/4/5\" style=\"grid-area:2/5/3/6\"><span class=\"SHNumber\">4</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">CLOCK_SPEED</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"3/4/4/5\" data-NarrowGridArea=\"4/3/5/4\" style=\"grid-area:3/4/4/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"3/5/4/6\" data-NarrowGridArea=\"4/4/5/5\" style=\"grid-area:3/5/4/6\"><span class=\"SHNumber\">100000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">SAMPLE_RATE</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"4/4/5/5\" data-NarrowGridArea=\"5/3/6/4\" style=\"grid-area:4/4/5/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"4/5/5/6\" data-NarrowGridArea=\"5/4/6/5\" style=\"grid-area:4/5/5/6\"><span class=\"SHNumber\">2000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">BIT_SLICE_OFFSET</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"5/4/6/5\" data-NarrowGridArea=\"6/3/7/4\" style=\"grid-area:5/4/6/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"5/5/6/6\" data-NarrowGridArea=\"6/4/7/5\" style=\"grid-area:5/5/6/6\"><span class=\"SHNumber\">0</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">INVERT_DATA</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"6/4/7/5\" data-NarrowGridArea=\"7/3/8/4\" style=\"grid-area:6/4/7/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"6/5/7/6\" data-NarrowGridArea=\"7/4/8/5\" style=\"grid-area:6/5/7/6\"><span class=\"SHNumber\">0</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">SAMPLE_SELECT</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"7/4/8/5\" data-NarrowGridArea=\"8/3/9/4\" style=\"grid-area:7/4/8/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"7/5/8/6\" data-NarrowGridArea=\"8/4/9/5\" style=\"grid-area:7/5/8/6\"><span class=\"SHNumber\">0</span></div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"7/6/8/7\" data-NarrowGridArea=\"9/1/10/6\" style=\"grid-area:7/6/8/7\">) ( <span class=\"SHKeyword\">input</span> aclk, <span class=\"SHKeyword\">input</span> arstn, <span class=\"SHKeyword\">input</span> s_axi_awvalid, <span class=\"SHKeyword\">input</span> [ADDRESS_WIDTH-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_axi_awaddr, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">2</span>:<span class=\"SHNumber\">0</span>] s_axi_awprot, <span class=\"SHKeyword\">output</span> s_axi_awready, <span class=\"SHKeyword\">input</span> s_axi_wvalid, <span class=\"SHKeyword\">input</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_axi_wdata, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">3</span>:<span class=\"SHNumber\">0</span>] s_axi_wstrb, <span class=\"SHKeyword\">output</span> s_axi_wready, <span class=\"SHKeyword\">output</span> s_axi_bvalid, <span class=\"SHKeyword\">output</span> [ <span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_axi_bresp, <span class=\"SHKeyword\">input</span> s_axi_bready, <span class=\"SHKeyword\">input</span> s_axi_arvalid, <span class=\"SHKeyword\">input</span> [ADDRESS_WIDTH-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_axi_araddr, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">2</span>:<span class=\"SHNumber\">0</span>] s_axi_arprot, <span class=\"SHKeyword\">output</span> s_axi_arready, <span class=\"SHKeyword\">output</span> s_axi_rvalid, <span class=\"SHKeyword\">output</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_axi_rdata, <span class=\"SHKeyword\">output</span> [ <span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_axi_rresp, <span class=\"SHKeyword\">input</span> s_axi_rready, <span class=\"SHKeyword\">input</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] i_diff, <span class=\"SHKeyword\">output</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] o_diff, <span class=\"SHKeyword\">output</span> en_o_diff, <span class=\"SHKeyword\">output</span> irq )</div></div></div></div><div class=\"TTSummary\">AXI Lite based 1553 communications device.</div></div>",13:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype13\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_rreq</div></div><div class=\"TTSummary\">uP read bus request</div></div>",14:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype14\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_rack</div></div><div class=\"TTSummary\">uP read bus acknowledge</div></div>",70:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype70\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"5\" data-NarrowColumnCount=\"4\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/2/2\" data-NarrowGridArea=\"1/1/2/5\" style=\"grid-area:1/1/2/2\"><span class=\"SHKeyword\">wire</span> [ADDRESS_WIDTH-(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">BUS_WIDTH</div><div class=\"PSymbols\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">/</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\"><span class=\"SHNumber\">2</span></div><div class=\"PAfterParameters\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"3/1/4/5\" style=\"grid-area:1/5/2/6\">)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_raddr</div></div></div></div><div class=\"TTSummary\">uP read bus address</div></div>",17:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype17\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> [<span class=\"SHNumber\">31</span>:<span class=\"SHNumber\">0</span>] up_rdata</div></div><div class=\"TTSummary\">uP read bus request</div></div>",18:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype18\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_wreq</div></div><div class=\"TTSummary\">uP write bus request</div></div>",19:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype19\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_wack</div></div><div class=\"TTSummary\">uP write bus acknowledge</div></div>",71:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype71\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"5\" data-NarrowColumnCount=\"4\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/2/2\" data-NarrowGridArea=\"1/1/2/5\" style=\"grid-area:1/1/2/2\"><span class=\"SHKeyword\">wire</span> [ADDRESS_WIDTH-(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">BUS_WIDTH</div><div class=\"PSymbols\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">/</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\"><span class=\"SHNumber\">2</span></div><div class=\"PAfterParameters\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"3/1/4/5\" style=\"grid-area:1/5/2/6\">)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_waddr</div></div></div></div><div class=\"TTSummary\">uP write bus address</div></div>",21:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype21\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> [<span class=\"SHNumber\">31</span>:<span class=\"SHNumber\">0</span>] up_wdata</div></div><div class=\"TTSummary\">uP write bus data</div></div>",12:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype12\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/2/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/2/2\">up_axi #(</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">AXI_ADDRESS_WIDTH(ADDRESS_WIDTH)</div><div class=\"PAfterParameters\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"3/1/4/4\" style=\"grid-area:1/4/2/5\">) inst_up_axi ( .up_rstn (arstn), .up_clk (aclk), .up_axi_awvalid(s_axi_awvalid), .up_axi_awaddr(s_axi_awaddr), .up_axi_awready(s_axi_awready), .up_axi_wvalid(s_axi_wvalid), .up_axi_wdata(s_axi_wdata), .up_axi_wstrb(s_axi_wstrb), .up_axi_wready(s_axi_wready), .up_axi_bvalid(s_axi_bvalid), .up_axi_bresp(s_axi_bresp), .up_axi_bready(s_axi_bready), .up_axi_arvalid(s_axi_arvalid), .up_axi_araddr(s_axi_araddr), .up_axi_arready(s_axi_arready), .up_axi_rvalid(s_axi_rvalid), .up_axi_rresp(s_axi_rresp), .up_axi_rdata(s_axi_rdata), .up_axi_rready(s_axi_rready), .up_wreq(up_wreq), .up_waddr(up_waddr), .up_wdata(up_wdata), .up_wack(up_wack), .up_rreq(up_rreq), .up_raddr(up_raddr), .up_rdata(up_rdata), .up_rack(up_rack) )</div></div></div></div><div class=\"TTSummary\">Module instance of up_axi for the AXI Lite bus to the uP bus.</div></div>",75:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype75\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/8/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/8/2\">up_1553 #(</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH(ADDRESS_WIDTH),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH(BUS_WIDTH),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">CLOCK_SPEED(CLOCK_SPEED),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">SAMPLE_RATE(SAMPLE_RATE),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">BIT_SLICE_OFFSET(BIT_SLICE_OFFSET),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">INVERT_DATA(INVERT_DATA),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">SAMPLE_SELECT(SAMPLE_SELECT)</div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"7/4/8/5\" data-NarrowGridArea=\"9/1/10/4\" style=\"grid-area:7/4/8/5\">) inst_up_1553 ( .clk(aclk), .rstn(arstn), .up_rreq(up_rreq), .up_rack(up_rack), .up_raddr(up_raddr), .up_rdata(up_rdata), .up_wreq(up_wreq), .up_wack(up_wack), .up_waddr(up_waddr), .up_wdata(up_wdata), .i_diff(i_diff), .o_diff(o_diff), .en_o_diff(en_o_diff), .irq(irq) )</div></div></div></div><div class=\"TTSummary\">Module instance of up_1553 creating a Logic wrapper for 1553 bus cores to interface with uP bus.</div></div>"});