

module vending_machine_tb();
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
@(negedge clk) 
rst=1'b1;
exp_prod=0;
exp_change=0;
in=2'bxx;
@(negedge clk)rst=1'b0;
end
endtask

/////task to check product state correct values ///////////

task product_check();                                       
begin
exp_prod=1;
exp_change=0;

@(negedge clk)
if (product==1 && change==0)
    $display("Product state is verified\n Product=%d\t Change=%d\t",product,change);
else
    $display("False product state\n Product=%d\t Change=%d\t",product,change);
end
endtask

/////////task to check change state correct values ///////
task change_check();                                        
begin
exp_change=1; 
exp_prod=1;

@(negedge clk)
if ((product==exp_prod) && (change==exp_change))
    $display("Change state is verified\n Product=%d\t Change=%d\t",product,change);
else
    $display("False change state\n Product=%d\t Change=%d\t",product,change);
end
endtask

//////////////clock /////////////////////
initial begin
    clk=1'b1;
    forever #5 clk=~clk;
end
///////////////stimulus//////////////////
initial begin
reset();

insert(1); insert(2);
product_check;

reset();

insert(2); insert(2);
change_check();

reset();

insert(1);
change_check();
product_check();
reset();

insert(1);insert(1);reset(); insert(2); insert(2);
change_check;

insert(1);
insert(0);
repeat(14)begin @(negedge clk); end                     
insert(2);
product_check();

reset();
insert(2);
insert(0);
repeat(14)begin @(negedge clk); end                     
insert(2);
product_check();
insert(1);
insert(1);

#20 $finish; 
end

endmodule
