﻿NDSummary.OnToolTipsLoaded("SystemVerilogModule:wishbone_classic_1553",{62:"<div class=\"NDToolTip TModule LSystemVerilog\"><div id=\"NDPrototype62\" class=\"NDPrototype WideForm\"><div class=\"PSection PParameterSection CStyle\"><div class=\"PParameterCells\" data-WideColumnCount=\"6\" data-NarrowColumnCount=\"5\"><div class=\"PBeforeParameters\" data-WideGridArea=\"1/1/8/2\" data-NarrowGridArea=\"1/1/2/6\" style=\"grid-area:1/1/8/2\"><span class=\"SHKeyword\">module</span> wishbone_classic_1553 #(</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"1/2/2/3\" data-NarrowGridArea=\"2/1/3/2\" style=\"grid-area:1/2/2/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"1/3/2/4\" data-NarrowGridArea=\"2/2/3/3\" style=\"grid-area:1/3/2/4\">ADDRESS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"1/4/2/5\" data-NarrowGridArea=\"2/3/3/4\" style=\"grid-area:1/4/2/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"1/5/2/6\" data-NarrowGridArea=\"2/4/3/5\" style=\"grid-area:1/5/2/6\"><span class=\"SHNumber\">32</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"2/2/3/3\" data-NarrowGridArea=\"3/1/4/2\" style=\"grid-area:2/2/3/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"2/3/3/4\" data-NarrowGridArea=\"3/2/4/3\" style=\"grid-area:2/3/3/4\">BUS_WIDTH</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"2/4/3/5\" data-NarrowGridArea=\"3/3/4/4\" style=\"grid-area:2/4/3/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"2/5/3/6\" data-NarrowGridArea=\"3/4/4/5\" style=\"grid-area:2/5/3/6\"><span class=\"SHNumber\">4</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"3/2/4/3\" data-NarrowGridArea=\"4/1/5/2\" style=\"grid-area:3/2/4/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"3/3/4/4\" data-NarrowGridArea=\"4/2/5/3\" style=\"grid-area:3/3/4/4\">CLOCK_SPEED</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"3/4/4/5\" data-NarrowGridArea=\"4/3/5/4\" style=\"grid-area:3/4/4/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"3/5/4/6\" data-NarrowGridArea=\"4/4/5/5\" style=\"grid-area:3/5/4/6\"><span class=\"SHNumber\">100000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"4/2/5/3\" data-NarrowGridArea=\"5/1/6/2\" style=\"grid-area:4/2/5/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"4/3/5/4\" data-NarrowGridArea=\"5/2/6/3\" style=\"grid-area:4/3/5/4\">SAMPLE_RATE</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"4/4/5/5\" data-NarrowGridArea=\"5/3/6/4\" style=\"grid-area:4/4/5/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"4/5/5/6\" data-NarrowGridArea=\"5/4/6/5\" style=\"grid-area:4/5/5/6\"><span class=\"SHNumber\">2000000</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"5/2/6/3\" data-NarrowGridArea=\"6/1/7/2\" style=\"grid-area:5/2/6/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"5/3/6/4\" data-NarrowGridArea=\"6/2/7/3\" style=\"grid-area:5/3/6/4\">BIT_SLICE_OFFSET</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"5/4/6/5\" data-NarrowGridArea=\"6/3/7/4\" style=\"grid-area:5/4/6/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"5/5/6/6\" data-NarrowGridArea=\"6/4/7/5\" style=\"grid-area:5/5/6/6\"><span class=\"SHNumber\">0</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"6/2/7/3\" data-NarrowGridArea=\"7/1/8/2\" style=\"grid-area:6/2/7/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"6/3/7/4\" data-NarrowGridArea=\"7/2/8/3\" style=\"grid-area:6/3/7/4\">INVERT_DATA</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"6/4/7/5\" data-NarrowGridArea=\"7/3/8/4\" style=\"grid-area:6/4/7/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"6/5/7/6\" data-NarrowGridArea=\"7/4/8/5\" style=\"grid-area:6/5/7/6\"><span class=\"SHNumber\">0</span>,</div><div class=\"PType InFirstParameterColumn\" data-WideGridArea=\"7/2/8/3\" data-NarrowGridArea=\"8/1/9/2\" style=\"grid-area:7/2/8/3\"><span class=\"SHKeyword\">parameter</span>&nbsp;</div><div class=\"PName\" data-WideGridArea=\"7/3/8/4\" data-NarrowGridArea=\"8/2/9/3\" style=\"grid-area:7/3/8/4\">SAMPLE_SELECT</div><div class=\"PDefaultValueSeparator\" data-WideGridArea=\"7/4/8/5\" data-NarrowGridArea=\"8/3/9/4\" style=\"grid-area:7/4/8/5\">&nbsp=&nbsp;</div><div class=\"PDefaultValue InLastParameterColumn\" data-WideGridArea=\"7/5/8/6\" data-NarrowGridArea=\"8/4/9/5\" style=\"grid-area:7/5/8/6\"><span class=\"SHNumber\">0</span></div><div class=\"PAfterParameters NegativeLeftSpaceOnWide\" data-WideGridArea=\"7/6/8/7\" data-NarrowGridArea=\"9/1/10/6\" style=\"grid-area:7/6/8/7\">) ( <span class=\"SHKeyword\">input</span> clk, <span class=\"SHKeyword\">input</span> rst, <span class=\"SHKeyword\">input</span> s_wb_cyc, <span class=\"SHKeyword\">input</span> s_wb_stb, <span class=\"SHKeyword\">input</span> s_wb_we, <span class=\"SHKeyword\">input</span> [ADDRESS_WIDTH-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_wb_addr, <span class=\"SHKeyword\">input</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_wb_data_i, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">3</span>:<span class=\"SHNumber\">0</span>] s_wb_sel, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_wb_bte, <span class=\"SHKeyword\">input</span> [ <span class=\"SHNumber\">2</span>:<span class=\"SHNumber\">0</span>] s_wb_cti, <span class=\"SHKeyword\">output</span> s_wb_ack, <span class=\"SHKeyword\">output</span> [BUS_WIDTH*<span class=\"SHNumber\">8</span>-<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] s_wb_data_o, <span class=\"SHKeyword\">output</span> s_wb_err, <span class=\"SHKeyword\">input</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] i_diff, <span class=\"SHKeyword\">output</span> [<span class=\"SHNumber\">1</span>:<span class=\"SHNumber\">0</span>] o_diff, <span class=\"SHKeyword\">output</span> en_o_diff, <span class=\"SHKeyword\">output</span> irq )</div></div></div></div><div class=\"TTSummary\">Wishbone Calssic based 1553 communications device.</div></div>",63:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype63\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_rreq</div></div><div class=\"TTSummary\">uP read bus request</div></div>",64:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype64\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_rack</div></div><div class=\"TTSummary\">uP read bus acknowledge</div></div>",65:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype65\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> [ADDRESS_WIDTH-<span class=\"SHNumber\">3</span>:<span class=\"SHNumber\">0</span>] up_raddr</div></div><div class=\"TTSummary\">uP read bus address</div></div>",66:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype66\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> [<span class=\"SHNumber\">31</span>:<span class=\"SHNumber\">0</span>] up_rdata</div></div><div class=\"TTSummary\">uP read bus request</div></div>",67:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype67\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_wreq</div></div><div class=\"TTSummary\">uP write bus request</div></div>",68:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype68\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> up_wack</div></div><div class=\"TTSummary\">uP write bus acknowledge</div></div>",69:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype69\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> [ADDRESS_WIDTH-<span class=\"SHNumber\">3</span>:<span class=\"SHNumber\">0</span>] up_waddr</div></div><div class=\"TTSummary\">uP write bus address</div></div>",70:"<div class=\"NDToolTip TVariable LSystemVerilog\"><div id=\"NDPrototype70\" class=\"NDPrototype\"><div class=\"PSection PPlainSection\"><span class=\"SHKeyword\">wire</span> [<span class=\"SHNumber\">31</span>:<span class=\"SHNumber\">0</span>] up_wdata</div></div><div class=\"TTSummary\">uP write bus data</div></div>"});