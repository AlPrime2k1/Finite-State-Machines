`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NIST
// Engineer: KIRTI KUMAR
// 
// Create Date:    03:15:23 11/09/2022 
// Design Name: APB PROTOCOL
// Module Name:    APB_master 
//
//////////////////////////////////////////////////////////////////////////////////
module APB_master(

input transfer,
input [7:0] readaddr,writeaddr,
input [7:0] datatowrite,
    
input PCLK,
input PRESETn,       
input [7:0] PRDATA,  //reading from slave    
input PWRITE,        //0 is READ 1 is WRITE
input PREADY,        //coming from slave
	
output reg [7:0] readint, //READ INTERMEDIATE
	
output reg [7:0] READOUT, //FINAL READOUT
output reg [7:0] writeint,//WRITE INTERMEDIATE
	
output reg PSEL,
output reg PENABLE,
output reg [7:0]PADDR,//read or write address
	//output reg PWRITE,
output reg [7:0]PWDATA //FINAL WRITE
	//output PSLVERR
    );
    
    
    reg [1:0] state, next_state;
    parameter IDLE = 2'b00, SETUP = 2'b01, ACCESS = 2'b11;
    
    always @(posedge PCLK)
    begin
        if(PRESETn)
            state <= IDLE;
	    else
		    state <= next_state;
    end
    
    always@(*)
    begin
        if (PRESETn) //reset
            next_state <= IDLE;
        else
        begin
            case(state)
            IDLE:
            begin
                PSEL=0;
                PENABLE=0;
                if(transfer)
                    next_state<= SETUP;
                else
                    next_state<=IDLE;
            end
            
            SETUP:
            begin
                PSEL=1;
                PENABLE=0;
                if (PWRITE) // WRITE OP
                begin
                    PADDR=writeaddr;
                    
                    next_state<=ACCESS;
                end
                else  // READ OP
                begin
                    PADDR=readaddr;
                    next_state<=ACCESS;                    
                end                
            end
            
            ACCESS:
            begin
                PSEL=1;
                PENABLE=1;
                if (PWRITE) //WRITE OP
                begin
                    if(PREADY) //slave ready
                    begin
                        writeint=datatowrite;
                        if (transfer) //more op after this
                            next_state<=SETUP;
                        else
                            next_state<=IDLE;
                    end
                    else //slave not ready for write
                        next_state<=ACCESS;  
                end
                else //READ OP
                begin
                    if (PREADY) //slave ready
                    begin
                        readint=PRDATA;
                        if(transfer) //more op after this
                            next_state<=SETUP;
                        else 
                            next_state<=IDLE;
                    end
                    else //slave not ready for read
                        next_state<=ACCESS;
                end
                        
            end
            
            default:next_state<=IDLE;
            endcase
        end
    end
always@(posedge PCLK)
begin
    PWDATA<=writeint;
    READOUT<=readint;
end    
endmodule

