`timescale 1ns / 1ps
module Traffic_lighter_controller_HIGH(clk,reset,num,duty_cycle,out,red,yellow,green);

input clk;
input reset;
input [2:0] num;        //cycle count of periodical low signal of PWM

input [2:0] duty_cycle; //cycle count of periodical high signal of PWM
                        //or
                        //cycle count of green/red signal = duty_cycle + 1
                        
output reg out;
output reg red,yellow,green;

reg [1:0] state;
reg [3:0] counter;
    
//----------------------------------------------
//PWM generator
//----------------------------------------------

always@(posedge ~clk)
begin 
    if(!reset) begin
        counter = counter + 1;
        if(counter > num)
        begin
            out = 1;
            
            if (counter == num + duty_cycle)
                counter = 0;
        end
        else
        begin
            out = 0;
        end
     end   
     else begin
        counter = 2;
	out = 0;
     end
end

//----------------------------------------------
//Moore machine
//*transition graph:
//
//               -  s0 <-
//              |        |
//             \/        |
//             s1       s3
//              |       /\
//              |        |
//               -> s2 --   
//
//s0:     to light the green lighter
//s1, s3: to light the yellow lighter 
//s2:     to light the red lighter 
//----------------------------------------------

always@(posedge clk)
begin
    if(!out)
        case(state)
            0: begin
                state = 1;
            end
            1: begin
                state = 2;
            end
            2: begin
                state = 3;
            end
            default: state = 0;
        endcase 
end

//----------------------------------------------
//Lighting certain lighter in correspond state
//----------------------------------------------

always@(state)
    case(state)
        0: begin    //s0: to light the green lighter
            green = 8'b1;
            yellow = 8'b0;
            red = 8'b0;
           end
        1: begin    //s1: to light the yellow lighter 
            green = 8'b0;
            yellow = 8'b1;
            red = 8'b0;
            end
        2: begin    //s2: to light the red lighter
            green = 8'b0;
            yellow = 8'b0;
            red = 8'b1;
            end
        3: begin    //s3: to light the yellow lighter
            green = 8'b0;
            yellow = 8'b1;
            red = 8'b0;
            end
    endcase

endmodule

module tb_Traffic_lighter_controller_HIGH;

reg clk;
reg reset;
reg [2:0] num;
reg [2:0] duty_cycle;
wire out,red,yellow,green;

Traffic_lighter_controller_HIGH Traffic_lighter_controller_HIGH_1(clk,reset,num,duty_cycle,out,red,yellow,green);

initial
begin
    clk = 0;
    reset = 1;
    num = 2;
    duty_cycle = 3; 
    #20 reset = 0;
end

always #10 clk = ~clk;
endmodule 
