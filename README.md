# BUS 1553
### 1553 TO BUS (WISHBONE CLASSIC, AXI_LITE)

![image](docs/manual/img/AFRL.png)

---

   author: Jay Convertino   
   
   date: 2024.10.17
   
   details: Interface 1553 data to a AXI LITE or Wishbone interface bus.
   
   license: MIT   
   
---

### VERSION
#### Current
  - pre-Alpha

#### Previous
  - none

### DOCUMENTATION
  For detailed usage information, please navigate to one of the following sources. They are the same, just in a different format.

  - [bus_1553.pdf](docs/manual/bus_1553.pdf)
  - [github page](https://johnathan-convertino-afrl.github.io/bus_1553/)

### DEPENDENCIES
#### Build

  - AFRL:utility:helper:1.0.0
  - AFRL:device_converter:axis_1553_encoder:1.0.0
  - AFRL:device_converter:axis_1553_dencoder:1.0.0
  - AFRL:buffer:fifo
  - AFRL:bus:up_wishbone_classic:1.0.0 (FOR WISHBONE)
  - AD:common:up_axi:1.0.0 (FOR AXI LITE)
  
#### Simulation

  - AFRL:simulation:axis_stimulator

### PARAMETERS

  *   ADDRESS_WIDTH   - Width of the axi address bus
  *   CLOCK_SPEED     - This is the aclk frequency in Hz
  *   SAMPLE_RATE     - Rate of in which to sample the 1553 bus. Must be 2 MHz or more and less than aclk. This is in Hz.
  *   BIT_SLICE_OFFSET- Adjust where the sample is taken from the input.
  *   INVERT_DATA     - Invert all 1553 bits coming in and out.
  *   SAMPLE_SELECT   - Adjust where in the array of samples to select a bit.

### REGISTERS

  - 0x0 = RX_FIFO (R)
    * 32 bit register, 23 downto 16 hold Packet info, 15 downto 0 hold 1553 data.
  - 0x4 = TX FIFO (W)
    * 32 bit register, 23 downto 16 hold Packet info, 15 downto 0 hold 1553 data.
  - 0x8 = STATUS REGISTER (R)
    * 32 bit register with the following bits: 7 = Parity Error, 6 = Invert Data, 5 = 4us Delay, 4 = Interupt Enabled, 3 = TX FIFO Full, 2 = TX FIFO Empty, 1 = RX FIFO Full, 0 = RX FIFO Data Valid.
  - 0xC = CONTROL_REGISTER (W)
    * 32 bit register with the following bits: 4 = Enable INTR, 1 = RST_RX_FIFO, 0 = RST_TX_FIFO.

### COMPONENTS
#### SRC

* up_1553.v
* wishbone_classic_1553.v
* axi_lite_1553.v
  
#### TB

* tb_up_1553.v
* tb_wishbone_1553.v
  
### FUSESOC

* fusesoc_info.core created.
* Simulation uses icarus to run data through the core.

#### Targets

* RUN WITH: (fusesoc run --target=sim VENDER:CORE:NAME:VERSION)
  - default (for IP integration builds)
  - sim
