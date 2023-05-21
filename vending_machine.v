
module vending_machine(
        input wire [1:0] in,
        input wire clk,
        input wire reset,
        output reg product,
        output reg change        
                      );
    
    parameter IDLE=3'b000,RS1=3'b001,RS2=3'b011,PRODUCT=3'b101, CHANGE=3'b111, Timeout=15;
    reg [2:0] state,next_state;
    reg [4:0] count=5'd0;
    
    //PRESENT STATE LOGIC
    always@(posedge clk)
    begin
        if (reset==1)
        begin
            state<=IDLE;
            count=0;
        end
        else
        begin
            count=count+1;
            state<=next_state; 
            //count=count+1;
        end          
    end
    
    
    //NEXT STATE LOGIC
    
     always@(state,in,count)
    begin
        case(state)
        IDLE:
        begin
        product=0;
        change=0;
        
        if(in==1)
            next_state=RS1;
        else if (in==2)
            next_state=RS2;
        else
            next_state=IDLE;
        
        end
        
        RS1:
        begin
        //count=count+1;
        if(in==1)
            next_state=RS2;
        else if (in==2)
            next_state=PRODUCT;
        else
            //next_state=IDLE;
            //count=count+1;
            if (count==Timeout)          //15 cycle wait to go back to idle state
            begin
                next_state=IDLE;
                count=0;
            end
            else
                next_state=RS1;

        end 
        
        RS2:
        begin
        if(in==1)
            next_state=PRODUCT;
        else if (in==2)
            next_state=CHANGE;
        else
            //next_state=IDLE;
            if (count==Timeout)
            begin
                next_state=IDLE;
                count=0;
            end
            else
                next_state=RS2;
               
        end 
        
        PRODUCT:
        begin
        product=1;
        change=0;
        next_state=IDLE;
        /*
        if(in==1)
            next_state=s1;
        else
            next_state=s10;
             */  
        end 
        
        CHANGE:
        begin
        product=1;
        change=1;
        next_state=IDLE;
        /*
        if(in==1)
            next_state=s1;
        else
            next_state=s10;
             */  
        end 
                
        default:next_state=IDLE;   
        endcase
   end  
  
   
endmodule

