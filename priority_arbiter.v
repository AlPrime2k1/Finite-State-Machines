`define width 3

module priority_arbiter(
    input  [`width-1:0] req,
    input  clk,
    input  reset,
    output reg [`width-1:0] grant
    );
    parameter IDLE=2'b00,G1=2'b01,G2=2'b10,G3=2'b11;
    reg [1:0] state,next_state;
    
    always@(posedge clk)
    begin
        if (reset==1)
            state<=IDLE;
        else
            state<=next_state;           
    end
    
    always@(*)
    begin
        case(state)
        IDLE:
        begin
        if(req[2]==1)
            next_state<=G1;
        else if (req[2:1]==2'b01 )         //req==3'd3 || req==3'd2
            next_state<=G2;
        else if (req==3'b001)
            next_state<=G3;
        else
            next_state<=IDLE;
        grant<=0;
        end
        
        G1:
        begin
        if(req[2]==1)
            next_state<=G1;
        else
            next_state<=IDLE;   
        grant<=3'b100;
        end 
        
        G2:
        begin
        if(req[1]==1)
            next_state<=G2;
        else
            next_state<=IDLE;
        grant<=3'b010;        
        end 
        
        G3:
        begin
        if(req[0]==1)
            next_state<=G3;
        else
            next_state<=IDLE;
        grant<=3'b001;
        end 
        
        default:next_state<=IDLE;   
        endcase
        end
      
endmodule

