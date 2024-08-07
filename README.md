# Traffic_light_controller
Digital circuit, Verilog, RTL level

The source codes "Traffic_light_controller_**RTL_...**" are describing traffic light controller on RTL level and consists of:
1) not gate; 
2) counter;
3) two comparators;
4) sum circuit;
5) moore machine;
6) ALU (data path).
1-4 modules are part of PWM generator. 
Ten hours were spent to describe controller on RTL level.    

Submodules interconnections diagram of "Traffic_light_controller_**RTL_...**" module:
![Submodules interconnections diagram for RTL implementation](https://github.com/user-attachments/assets/be9ea7eb-935d-4b9f-b66e-452712a6958d)

The source code "Traffic_light_controller_**RTL_for_testing**" IS NOT intended for implementation becouse contain additional top module outputs are intended for top module testing by Waveforms.
Result of testing:
![RTL description testing](https://github.com/user-attachments/assets/9cb02b07-31c9-4fab-8aa9-f4082107d8c0)

The source code "Traffic_light_controller_**RTL_for_implementation**" IS intended for implementation becouse test outputs was removed.

The source code "Traffic_light_controller_**HIGH**" is describing traffic light controller with highest level Verilog constructions.
For example, 1-4 modules of RTL description were described using one always block.
Result of testing:
![High level description testing](https://github.com/user-attachments/assets/de25708e-30f1-4132-b3db-55a08c1cd255)




