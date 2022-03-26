`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 22.02.2022 15:24:55
// Design Name: PATTERN DETECTOR USING MOORE MACHINE
// Module Name: FSM_pattern_moore

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// TO DETECT 1011 IN A SERIES
//////////////////////////////////////////////////////////////////////////////////


module FSM_pattern_moore(
    input wire din,
    input wire clk,
    input wire reset,
    output reg z
    );
    parameter sin=3'b000,s1=3'b001,s10=3'b010,s101=3'b011,s1011=3'b111; //any 5 values are chosen
    reg [2:0] state,next_state;
    
    always@(posedge clk,posedge reset)
    begin
        if (reset==1)
            state<=sin;
        else
            state<=next_state;           
    end
    
    always@(state,din)
    begin
        case(state)
        sin:
        begin
        if(din==1)
            next_state=s1;
        else
            next_state=sin;
        z=0;
        end
        
        s1:
        begin
        if(din==0)
            next_state=s10;
        else
            next_state=s1;
        z=0;
        end 
        
        s10:
        begin
        if(din==1)
            next_state=s101;
        else
            next_state=sin;
        z=0;        
        end 
        
        s101:
        begin
        if(din==1)
            next_state=s1011;
        else
            next_state=s10;
        z=0;        
        end 
        
        s1011:
        begin
        if(din==0)
            next_state=s10;
        else
            next_state=s1;
        z=1;        
        end  
        
        default:next_state=sin;   
        endcase
        
    end
endmodule
