# BUS 1553
### 1553 TO BUS (WISHBONE CLASSIC, AXI_LITE)
---

   author: Jay Convertino   
   
   date: 2024.10.17
   
   details: Interface 1553 data to a AXI LITE or Wishbone interface bus.
   
   license: MIT   
   
---

### Version
#### Current
  - V1.0.0 - initial release

#### Previous
  - none

### Documentation
  - Please see the doc folder for a PDF version, and the markdown version of the latex documentation.
  - This can be regerated by executing the makefile in the root of the doc directory.

### Dependencies
#### Build
  - AFRL:utility:helper:1.0.0
  - AFRL:device_converter:axis_1553_encoder:1.0.0
  - AFRL:device_converter:axis_1553_dencoder:1.0.0
  - AFRL:buffer:fifo
  - AFRL:bus:up_wishbone_classic:1.0.0 (FOR WISHBONE)
  - AD:common:up_axi:1.0.0 (FOR AXI LITE)
  
#### Simulation
  - AFRL:simulation:axis_stimulator

### IP USAGE
#### INSTRUCTIONS


#### PARAMETERS

#### REGISTERS
  - 0x0 = RX_FIFO (R)
    * 32 bit register, DATA_BITS downto 0 hold RX UART data.
  - 0x4 = TX FIFO (W)
    * 32 bit register, DATA_BITS downto 0 hold TX UART data.
  - 0x8 = STATUS REGISTER (W)
    * 32 bit register with the following bits: 4 = Enable INTR, 1 = RST_RX_FIFO, 0 = RST_TX_FIFO.
  - 0xC = CONTROL_REGISTER (R)
    * 32 bit register with the following bits: 7 = Parity Error, 6 = Frame Error, 5 = Overrun Error, 4 = Interupt Enabled, 3 = TX FIFO Full, 2 = TX FIFO Empty, 1 = RX FIFO Full, RX FIFO Data Valid.

### COMPONENTS
#### SRC

* up_1553.v
* wishbone_classic_1553.v
* axi_lite_1553.v
  
#### TB

* tb_up_1553.v
* tb_wishbone_1553.v
  
### fusesoc

* fusesoc_info.core created.
* Simulation uses icarus to run data through the core.

#### TARGETS

* RUN WITH: (fusesoc run --target=sim VENDER:CORE:NAME:VERSION)
  - default (for IP integration builds)
  - sim
