`define width 3

module priority_arbiter_tb();

reg [`width-1:0] req;
reg  clk,reset;
wire [`width-1:0] grant;

priority_arbiter DUT (req,clk,reset,grant);

///////////// insert task /////////////////////
task insert(input [2:0] a);                              
begin
@(negedge clk) req=a;
end
endtask
///////////// reset task ///////////////////
task rst();                                               
begin
@(negedge clk)reset=1'b1;
@(negedge clk)reset=1'b0;
end
endtask
///////////// clock init //////////////////
initial begin
    clk=1'b1;
    forever #10 clk=~clk;
end
///////////// stimulus ///////////////////
initial
begin 
rst();
repeat(15) insert({$random});
rst();




@(negedge clk) $finish;
end
endmodule
