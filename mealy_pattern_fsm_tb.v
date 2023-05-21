
module mealy_pattern_fsm_tb();
reg in,clk,reset;
wire z;

mealy_pattern_fsm dut(in,clk,reset,z);

parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11;

///////////// insert task /////////////////////
task insert(input a);                              
begin
@(negedge clk) in=a;
end
endtask
///////////// reset task ///////////////////
task rst();                                               
begin
@(negedge clk) 
reset=1'b1;
@(negedge clk)reset=1'b0;
end
endtask
///////////// clock init //////////////////
initial begin
    clk=1'b1;
    forever #5 clk=~clk;
end
/////////////// correct pattern task ///
task correct_pattern();
begin
insert(1);
insert(0);
insert(0);
insert(1);

@(negedge clk)
if (z==1)
    $display("Correct pattern detected ");
else
    $display("Wrong output");
end
endtask
/////////////// overlapping pattern task ///
task overlapping_pattern();
begin
insert(1);
insert(0);
insert(0);
insert(1);
insert(0);
insert(0);
insert(1);

@(negedge clk)
if (z==1)
    $display("Correct overlapping pattern detected ");
else
    $display("Wrong output");
end
endtask
/////////////// stimulus ///////////////
initial begin
rst();
correct_pattern();
rst();
overlapping_pattern();
/////// random pattern ///
repeat(2) insert(1);
insert (0);
repeat(2) insert(1);
@(negedge clk) $finish;
end

endmodule
