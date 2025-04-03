﻿NDSummary.OnToolTipsLoaded("File2:tb_cocotb_up.v",{100:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Test bench wrapper for cocotb</div></div>",101:"<div class=\"NDToolTip TInformation LSystemVerilog\"><div class=\"TTSummary\">Copyright 2025 Jay Convertino</div></div>",102:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype102\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"6\" data-NarrowColumnCount=\"5\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/8/2\" data-NarrowGridArea=\"1/1/2/6\" style=\"grid-area:1/1/8/2\"><span class=\"SHKeyword\">module</span> tb_cocotb #(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"2/4/3/5\" style=\"grid-area:1/5/2/6\"><span class=\"SHNumber\">32</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"2/4/3/5\" data-NarrowGridArea=\"3/3/4/4\" style=\"grid-area:2/4/3/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"2/5/3/6\" data-NarrowGridArea=\"3/4/4/5\" style=\"grid-area:2/5/3/6\"><span class=\"SHNumber\">4</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">CLOCK_SPEED</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"3/4/4/5\" data-NarrowGridArea=\"4/3/5/4\" style=\"grid-area:3/4/4/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"3/5/4/6\" data-NarrowGridArea=\"4/4/5/5\" style=\"grid-area:3/5/4/6\"><span class=\"SHNumber\">100000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">SAMPLE_RATE</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"4/4/5/5\" data-NarrowGridArea=\"5/3/6/4\" style=\"grid-area:4/4/5/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"4/5/5/6\" data-NarrowGridArea=\"5/4/6/5\" style=\"grid-area:4/5/5/6\"><span class=\"SHNumber\">2000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">BIT_SLICE_OFFSET</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"5/4/6/5\" data-NarrowGridArea=\"6/3/7/4\" style=\"grid-area:5/4/6/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"5/5/6/6\" data-NarrowGridArea=\"6/4/7/5\" style=\"grid-area:5/5/6/6\"><span class=\"SHNumber\">0</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">INVERT_DATA</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"6/4/7/5\" data-NarrowGridArea=\"7/3/8/4\" style=\"grid-area:6/4/7/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"6/5/7/6\" data-NarrowGridArea=\"7/4/8/5\" style=\"grid-area:6/5/7/6\"><span class=\"SHNumber\">0</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">SAMPLE_SELECT</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"7/4/8/5\" data-NarrowGridArea=\"8/3/9/4\" style=\"grid-area:7/4/8/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"7/5/8/6\" data-NarrowGridArea=\"8/4/9/5\" style=\"grid-area:7/5/8/6\"><span class=\"SHNumber\">0</span></div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"7/6/8/7\" data-NarrowGridArea=\"9/1/10/6\" style=\"grid-area:7/6/8/7\">) ( <span class=\"SHKeyword\">input</span> clk, <span class=\"SHKeyword\">input</span> rstn, <span class=\"SHKeyword\">input</span> up_rreq, <span class=\"SHKeyword\">output</span> up_rack, <span class=\"SHKeyword\">input</span> [ADDRESS_WIDTH-(BUS_WIDTH/<span class=\"SHNumber\">2</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_raddr, <span class=\"SHKeyword\">output</span> [(BUS_WIDTH*<span class=\"SHNumber\">8</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_rdata, <span class=\"SHKeyword\">input</span> up_wreq, <span class=\"SHKeyword\">output</span> up_wack, <span class=\"SHKeyword\">input</span> [ADDRESS_WIDTH-(BUS_WIDTH/<span class=\"SHNumber\">2</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_waddr, <span class=\"SHKeyword\">input</span> [(BUS_WIDTH*<span class=\"SHNumber\">8</span>)<span class=\"SHNumber\">-1</span>:<span class=\"SHNumber\">0</span>] up_wdata, <span class=\"SHKeyword\">input</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] i_diff, <span class=\"SHKeyword\">output</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] o_diff, <span class=\"SHKeyword\">output</span> en_o_diff, <span class=\"SHKeyword\">output</span> irq )</div></div></div></div><div class=\"TTSummary\">uP 1553 testbench</div></div>",104:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype104\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"4\" data-NarrowColumnCount=\"3\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/8/2\" data-NarrowGridArea=\"1/1/2/4\" style=\"grid-area:1/1/8/2\">up_1553 #(</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH(ADDRESS_WIDTH),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH(BUS_WIDTH),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">CLOCK_SPEED(CLOCK_SPEED),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">SAMPLE_RATE(SAMPLE_RATE),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">BIT_SLICE_OFFSET(BIT_SLICE_OFFSET),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">INVERT_DATA(INVERT_DATA),</div><div class=\"PSymbols InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\">.</div><div class=\"PName InLastParameterColumn\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">SAMPLE_SELECT(SAMPLE_SELECT)</div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"7/4/8/5\" data-NarrowGridArea=\"9/1/10/4\" style=\"grid-area:7/4/8/5\">) dut ( .clk(clk), .rstn(rstn), .up_rreq(up_rreq), .up_rack(up_rack), .up_raddr(up_raddr), .up_rdata(up_rdata), .up_wreq(up_wreq), .up_wack(up_wack), .up_waddr(up_waddr), .up_wdata(up_wdata), .i_diff(i_diff), .o_diff(o_diff), .en_o_diff(en_o_diff), .irq(irq) )</div></div></div></div><div class=\"TTSummary\">Device under test, up_1553</div></div>"});