# Traffic_light_controller
Digital circuits, FPGA, Xilinx, Verilog HDL, RTL level

**PREAMBLE** 

Is investigated practical sense of going down the level of abstraction in Verilog HDL. Particularly, are compared higest and RTL levels. 

To do testing of sources in Vivado need to apart synthesizable modules from testbench module.

The sourses "Traffic_light_controller_RTL_..." is better commented comparing with the source "Traffic_light_controller_HIGH". Because this sources are functionally equivalent, the lack of comments for last source can be compensated by comments in first sources.  

**1. ABOUT SOURCES"**

**1.1. The sourses "Traffic_light_controller_RTL_..."**

The source codes "Traffic_light_controller_RTL_..." are describing traffic light controller on RTL level and consists of:
1) not gate; 
2) counter;
3) two comparators;
4) sum circuit;
5) moore machine;
6) ALU (data path).
1-4 modules are part of PWM generator.
 
Submodules interconnections diagram of "Traffic_light_controller_RTL_..." module:

![Submodules interconnections diagram of "Traffic_light_controller_RTL_..." module](https://github.com/user-attachments/assets/be9ea7eb-935d-4b9f-b66e-452712a6958d)

**1.1.1. The source "Traffic_light_controller_RTL_for_testing"**

The source code "Traffic_light_controller_RTL_for_testing" IS NOT intended for implementation becouse contain additional top module outputs are intended for top module testing by Waveforms.

RTL description (for testing) testing:

![RTL description (for testing) testing](https://github.com/user-attachments/assets/9cb02b07-31c9-4fab-8aa9-f4082107d8c0)

**1.1.2 The source "Traffic_light_controller_RTL_for_implementation"**

The source code "Traffic_light_controller_RTL_for_implementation" IS intended for implementation becouse test outputs was removed.

RTL description (for implementation) testing:

![RTL description (for implementation) testing](https://github.com/user-attachments/assets/17a38aa5-199d-49e1-a8fa-f4d53cb2914a)


**1.2. The source "Traffic_light_controller_HIGH"**

The source code "Traffic_light_controller_HIGH" is describing traffic light controller with highest level Verilog constructions.
For example, 1-4 modules of RTL description were described using one always block.

This source can be used both for testing and for implementation.

High level description testing:

![High level description testing](https://github.com/user-attachments/assets/de25708e-30f1-4132-b3db-55a08c1cd255)

**2. RESULTS OF IMPLEMENTATIONS**

For implementation was used virtual Xilinx device xc7k70tfbv676-1 (family Kintex-7). Was implemented "Traffic_light_controller_RTL_for_implementation" and "Traffic_light_controller_HIGH" sources.  

Diargam includes FPGA resource used for each description level and time in hours for developing: 
![Diargam is including FPGA resource used for each description level and time in hours for developing](https://github.com/user-attachments/assets/05b016f0-a715-4085-852a-737e9d70f4fc)

Comparison of methods relative to RTL:
- FDRE is slightly better (less used);
- OBUF is slightly better (less used);
- IBUF is slightly worse (more used);
- BUFG is same (same amount used);
- LUT is slightly worse or the same;
- dev. time (hr.) much worse (spent 5 times more time).

Ten hours were spent to describe controller on RTL level. Two hours were spent to describe controller on high level. 




