
module mealy_pattern_fsm(
    input wire in,
    input wire clk,
    input wire reset,
    output reg z

    );
    
    parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;
    reg [1:0] state,next_state;
    
    always@(posedge clk,posedge reset)
    begin
        if (reset==1)
            state<=s0;
        else
            state<=next_state;           
    end
    
    
     always@(state,in)
    begin
        case(state)
        s0:
        begin
        if(in==1)
            next_state=s1;
        else
            next_state=s0;
        
        end
        
        s1:
        begin
        if(in==0)
            next_state=s2;
        else
            next_state=s1;
        
        end 
        
        s2:
        begin
        if(in==0)
            next_state=s3;
        else
            next_state=s1;
               
        end 
        
        s3:
        begin
        if(in==1)
            next_state=s1;
        else
            next_state=s0;
               
        end 
                
        default:next_state=s0;   
        endcase
   end  
   
   always@(posedge clk)
   begin
        case(state)
        s0:z=0;
        s1:z=0;
        s2:z=0;
        s3:
        begin
            if (in==1)
            z=1;
            else
            z=0;
        end
        endcase
   end 
   
endmodule

