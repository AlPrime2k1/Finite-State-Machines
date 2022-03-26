`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
//
// Create Date: 22.02.2022 15:02:01
// Design Name: COUNTER USING FSM
// Module Name: FSM_counter

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FSM_counter(
    input wire clk,
    input wire din,
    input wire reset,
    output reg [1:0] z
    );
    reg [1:0] state;
    parameter s0= 2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
    
    always@(posedge clk)
    begin
        if (reset == 1)
            state<=s0;
        else
            state<=state;          
    end
    
    always@(posedge clk)
    begin
        case(state)
        
        s0:begin
        if (din==1)
        #10 state<=s1;
        else
        #10 state<=s0;
        end
       
        s1:begin
        if (din==1)
        #10 state<=s2;
        else
        #10 state<=s1;
        end
        
        
        s2:begin
        if (din==1)
        #10 state<=s3;
        else
        #10 state<=s2;
        end
        
        
        s3:begin
        if (din==1)
        #10 state<=s0;
        else
        #10 state<=s3;
        end
        endcase
    end
    
    always@(posedge clk)
    begin
        #10 assign z= state;
    end
endmodule
