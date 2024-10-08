`timescale 1ns / 1ps
module Traffic_lighter_controller_RTL(
                            
    input [2:0] num,        //cycle count of periodical low signal of PWM
                            
    input [2:0] duty_cycle, //cycle count of periodical high signal of PWM
                            //or
                            //cycle count of green/red signal = duty_cycle + 1
                                                     
    input [2:0] initNum,    //num for counter initialization
    input load,             //enable signal for enabling of loading initNum to counter on which is based PWM 
    input clk,  
    
                            //lighter signals
    output red,     
    output yellow,
    output green
    );
    
    wire clk_inversed; 
    wire pwm_out;                       //pwm signal what corresponds comparator output (compare operation: counter_out > num)
    wire [3:0] counter_out;             //pwm counter output 
    wire [3:0] sum_num_dutyCycle_out;   //summator output, addition operation: num + duty_cycle
    wire counter_eq_sum_out;            //comparator output, compare operation: counter_out == sum_num_dutyCycle_out
    wire [1:0] state;                   //Moore machine state
                     
    //5 modules form a group that generates PWM signal:
    //my_not1
    //counter1
    //counter_bigger_num
    //sum
    //counter_eq_sum
    
    my_not my_not1(                         //inversion operation: ~clk
        clk,
        clk_inversed
        );
    
    counter counter1(
        clk_inversed,                       //shiffting pwm sigal in side of start on half clk cycle 
                                            //to prevent change of Moore machine state on 2nd cycle of clk signal.
                                            //Becouse pwm signal by posedge clk changes with some very little delay,  
                                            //than, without pwm sigal shiffting, would ocurre two posedge clk 
                                            //(see always block in Moore machine module)
        
        counter_eq_sum_out,                 //is connected to counter.reset
        initNum,
        load,
        counter_out
        );
        
    comparator_bigger counter_bigger_num(   //operation: counter_out > num
        counter_out,
        {1'b0,num},                         //zero complement to 3 bits wide
        pwm_out
        );
        
     sum sum_num_dutyCycle(                  //operation: num + duty_cycle
        num,
        duty_cycle,
        sum_num_dutyCycle_out
        );
    
    comparator_eq counter_eq_sum(           //operation: counter_out == sum_num_dutyCycle_out
        counter_out,
        sum_num_dutyCycle_out,
        counter_eq_sum_out
        );
    
   Moore_machine Moore_machine1(
        clk,
        pwm_out,
        state
        );
        
    data_path data_path1(
        state,
        green,
        yellow,
        red
        );
        
endmodule   

module my_not(
    input clk,
    output reg clk_inversed
    );
    
    always@(clk)
        if(clk == 1) begin
            clk_inversed <= 0;
        end
        else begin
            clk_inversed <= 1;
        end

endmodule

module counter(
    input clk,
    input reset,
    input [2:0] initNum,
    input load,
    output reg [3:0] out
    );
    
    always@(posedge clk)
        if (load == 1 || reset == 1)
        begin 
            if(load == 1) begin
                out <= initNum;
            end
            if(reset == 1) begin 
                out <= 1;
            end
        end  
        else begin
            out <= out + 1;
        end
            
endmodule

module comparator_eq(
    input [3:0] num1,
    input [3:0] num2,
    output reg out
    );
    
    always@(num1, num2)
        if(num1 == num2) begin
            out <= 1;
        end
        else begin
            out <= 0;
        end
            
endmodule

module comparator_bigger(
    input [3:0] num1,
    input [3:0] num2,
    output reg out
    );
    
    always@(num1,num2)
        if(num1 > num2) begin
            out <= 1;               
        end
        else begin
            out <= 0;
        end
            
endmodule 

module sum( 
    input [2:0] num1,
    input [2:0] num2,
    output reg [3:0] sum
    );

    always@(num1, num2) begin
        sum = num1 + num2;
    end
        
endmodule

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
module Moore_machine(
    input clk,
    input pwm,  
    output reg [1:0] state
    );

    always@(posedge clk)
    begin
        if(!pwm)                    //state transition carries out if pwm signal is low
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
                default: begin 
                    state = 0;
                   end
            endcase 
    end

endmodule

//----------------------------------------------
//Lighting certain lighter in correspond state
//----------------------------------------------
module data_path(
    input [1:0] state,
    output reg green,
    output reg yellow,
    output reg red
    );
    
    always@(state)
    case(state)
        0: begin    //s0: to light the green lighter
            green = 1;
            yellow = 0;
            red = 0;
           end
        1: begin    //s1: to light the yellow lighter 
            green = 0;
            yellow = 1;
            red = 0;
            end
        2: begin    //s2: to light the red lighter
            green = 0;
            yellow = 0;
            red = 1;
            end
        3: begin    //s3: to light the yellow lighter 
            green = 0;
            yellow = 1;
            red = 0;
            end
    endcase
    
 endmodule

`timescale 1ns / 1ps
module tb_Traffic_lighter_controller_RTL;
                        
reg [2:0] num;                        
reg [2:0] duty_cycle;                        
reg [2:0] initNum;      
reg load;               
reg clk;         

                        //lighter signals
wire red;
wire yellow;
wire green;

Traffic_lighter_controller_RTL Traffic_lighter_controller_RTL_1(
    num,
    duty_cycle,
    initNum,
    load,
    clk,  
    red,
    yellow,
    green);

initial
begin
         //cycle count of periodical low signal of PWM
    num = 2;             
        //cycle count of periodical high signal of PWM
        //or
        //cycle count of green/red signal = duty_cycle + 1
    duty_cycle = 3; 
        //PWM example with parameters: num = 2, duty_cycle = 3
        //             high      low       high      low       high
        //        |<--------->|<----->|<--------->|<----->|<--------->|
        //==============================================================
        //clk: _|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_|^|_ 
        //PWM: X__|^^^^^^^^^^^|_______|^^^^^^^^^^^|_______|^^^^^^^^^^^|_ 
        //============================================================== 
        
    clk = 0;
    load = 1;       //enable signal for enabling of loading initNum to counter on which is based PWM 
    initNum = 2;    //num for counter initialization
    #20 load = 0;
end

always #10 clk = ~clk;

endmodule
