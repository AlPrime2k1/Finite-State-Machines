module vending_mac_alt();
reg clk,rst;
reg [1:0] in;
wire product,change;

vending_machine dut(in,clk,rst,product,change);

parameter IDLE=3'b000,RS1=3'b001,RS2=3'b011,PRODUCT=3'b101, CHANGE=3'b111;
 
reg exp_prod,exp_change;

/////////////task for inserting coin //////////////////////
task insert(input [1:0] coin);                              
begin
@(negedge clk) in=coin;
end
endtask

//////////////////////task for reset////////////////////
task reset();                                               
begin
@(negedge clk)rst=1'b1;
@(negedge clk)rst=1'b0;
end
endtask

initial 
begin

if($test$plusargs("IDLEtoRS2toCHANGE"))
begin

insert(2);
insert(2);

end

if($test$plusargs("IDLEtoRS2toPRODUCT"))
begin

insert(2);
insert(1);

end

if($test$plusargs("IDLEtoRS1toPRODUCT"))
begin

insert(1);
insert(2);

end

if($test$plusargs("IDLEtoRS1toRS2toPRODUCT"))
begin

repeat(3) insert(1);
end

if($test$plusargs("IDLEtoRS1toRS2toCHANGE"))
begin

repeat(2) insert(1);
insert(2);

end

if($test$plusargs("TIMEOUTRS1"))
begin

insert(1);
insert(0);
repeat(20)begin @(negedge clk); end                     
insert(2);

end

if($test$plusargs("TIMEOUTRS2"))
begin

insert(2);
insert(0);
repeat(20)begin @(negedge clk); end                     
insert(2);

end

end

//////////////clock /////////////////////
initial begin
    clk=1'b1;
    forever #5 clk=~clk;
end
///////////////stimulus//////////////////
initial begin
reset();
//
insert(1); insert(2);


reset();

insert(2); insert(2);


reset();

insert(1);

reset();

insert(1);insert(1);reset(); insert(2); insert(2);


insert(1);
insert(0);
repeat(14)begin @(negedge clk); end                     
insert(2);

reset();
insert(2);
insert(0);
repeat(14)begin @(negedge clk); end                     
insert(2);

insert(1);
insert(1);
//

#20 $finish; 
end

endmodule

