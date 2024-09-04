# Traffic_light_controller
Digital circuit, Verilog, RTL level

**PREAMBLE** 

To do testing of sources in need   

The sourses "Traffic_light_controller_RTL_..." is better commented comparing with the source "Traffic_light_controller_HIGH". Because this sources are functionally equivalent, the lack of comments for last source can be compensated by comments in first sources.  

**1. The sourses "Traffic_light_controller_RTL_..."**

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

Ten hours were spent to describe controller on RTL level. 

**1.1. The source "Traffic_light_controller_RTL_for_testing"**

The source code "Traffic_light_controller_RTL_for_testing" IS NOT intended for implementation becouse contain additional top module outputs are intended for top module testing by Waveforms.

RTL description (for testing) testing:

![RTL description (for testing) testing](https://github.com/user-attachments/assets/9cb02b07-31c9-4fab-8aa9-f4082107d8c0)

**1.2. The source "Traffic_light_controller_RTL_for_implementation"**

The source code "Traffic_light_controller_RTL_for_implementation" IS intended for implementation becouse test outputs was removed.

RTL description (for implementation) testing:

![RTL description (for implementation) testing](https://github.com/user-attachments/assets/17a38aa5-199d-49e1-a8fa-f4d53cb2914a)


**2. The source "Traffic_light_controller_HIGH"**

The source code "Traffic_light_controller_HIGH" is describing traffic light controller with highest level Verilog constructions.
For example, 1-4 modules of RTL description were described using one always block.

This source can be used both for testing and for implementation.

High level description testing:

![High level description testing](https://github.com/user-attachments/assets/de25708e-30f1-4132-b3db-55a08c1cd255)

Two hours were spent to describe controller on high level. 





