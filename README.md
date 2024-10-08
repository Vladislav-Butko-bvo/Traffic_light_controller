# Traffic light controller
Digital circuits, FPGA, Xilinx, Verilog HDL, RTL level

**PREAMBLE** 

Is investigated practical sense of going down the level of abstraction in Verilog HDL. Particularly, are compared highest and RTL levels. 

Weaknesses of the research methodology: 
- project can don't meet functional requirements while timing and post-implementation simulations;
- the accuracy of the study is low becouse few FPGA resources are used. 

To do testing of sources in Vivado need to apart synthesizable modules from testbench module.

The sourses "Traffic_light_controller_RTL_..." is better commented comparing with the source "Traffic_light_controller_HIGH". Because this sources are functionally equivalent, the lack of comments for last source can be compensated by comments from first sources.  

**1. ABOUT SOURCES**

**1.1. The sourses "Traffic_light_controller_RTL_..."**

Are describing traffic light controller on RTL level and contains follow synthesible modules:
1) not gate; 
2) counter;
3) two comparators;
4) sum circuit;
5) moore machine;
6) ALU (data path).
1-4 modules are part of PWM generator.
 
Submodules interconnections diagram of "Traffic_light_controller_RTL_..." sources:

![Submodules interconnections diagram of "Traffic_light_controller_RTL_..." sources](https://github.com/user-attachments/assets/be9ea7eb-935d-4b9f-b66e-452712a6958d)

**1.1.1. The source "Traffic_light_controller_RTL_for_testing"**

IS NOT intended for implementation becouse contain additional top module outputs need for testing using waveforms.

Behavioral simulation before implementation and synthesis:

![RTL description (for testing) behavioral simulation before implementation and synthesis](https://github.com/user-attachments/assets/9cb02b07-31c9-4fab-8aa9-f4082107d8c0)

**1.1.2 The source "Traffic_light_controller_RTL_for_implementation"**

IS intended for implementation becouse test outputs was removed.

Behavioral simulation before implementation and synthesis:

![RTL description (for implementation) behavioral simulation before implementation and synthesis](https://github.com/user-attachments/assets/17a38aa5-199d-49e1-a8fa-f4d53cb2914a)


**1.2. The source "Traffic_light_controller_HIGH"**

Is describing traffic light controller with highest level Verilog constructions.
For example, 1-4 modules of RTL description were described using one always block.

This source can be used both for testing and for implementation.

Behavioral simulation before implementation and synthesis:

![High level description behavioral simulation before implementation and synthesis](https://github.com/user-attachments/assets/de25708e-30f1-4132-b3db-55a08c1cd255)

**2. RESULTS OF IMPLEMENTATIONS**

For implementation was used virtual Xilinx device xc7k70tfbv676-1 (family Kintex-7). "Traffic_light_controller_RTL_for_implementation" and "Traffic_light_controller_HIGH" sources was implemented.  

Diargam includes FPGA resource used for each description level and time in hours for developing: 

![Diargam is including FPGA resource used for each description level and time in hours for developing](https://github.com/user-attachments/assets/05b016f0-a715-4085-852a-737e9d70f4fc)

Comparison of methods relative to RTL:
- FDRE is slightly better (less FPGA resource used);
- OBUF is slightly better;
- IBUF is slightly worse (more FPGA resource used);
- BUFG is same (same amount of FPGA resource used);
- LUTs is slightly worse or the same;
- time in hours for developing much worse (spent 5 times more time).

**CONCLUSIONS**

The RTL description uses both smaller and larger amounts of FPGA resources, depending on the resource class. Therefore, it cannot be said that the RTL description will always use fewer resources. Moreover, the difference in the time spent on the development of descriptions is much greater than the difference in the resources used in favor of a high-level description.




