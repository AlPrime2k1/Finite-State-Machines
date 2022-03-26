`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date: 22.02.2022 16:37:42
// Design Name: PATTERN DETECTOR USING MEALY MACHINE
// Module Name: FSM_pattern_mealy

// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// TO DETECT 1011 IN SERIES
//////////////////////////////////////////////////////////////////////////////////


module FSM_pattern_mealy(
    input wire din,
    input wire clk,
    input wire reset,
    output reg z
    );
    parameter sin=2'b00,s1=2'b01,s10=2'b10,s101=2'b11;
    reg [1:0] state,next_state;
    
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
        
        end
        
        s1:
        begin
        if(din==0)
            next_state=s10;
        else
            next_state=s1;
        
        end 
        
        s10:
        begin
        if(din==1)
            next_state=s101;
        else
            next_state=sin;
               
        end 
        
        s101:
        begin
        if(din==1)
            next_state=s1;
        else
            next_state=s10;
               
        end 
                
        default:next_state=sin;   
        endcase
   end  
   
   always@(state,din)
   begin
        case(state)
        sin:z=0;
        s1:z=0;
        s10:z=0;
        s101:
        begin
            if (din==1)
            z=1;
            else
            z=0;
        end
        endcase
   end 
   
endmodule
