`include "Single_cycle_TOP.v"
module single_cycle_tb();


reg clk=0,rst;

Single_Cycle_TOP single_cycle(.clk(clk),
                 .rst(rst));

always begin
clk = ~clk;
#50;
end

initial begin
    $dumpfile("sincgle_cycle.vcd");
    $dumpvars(0,single_cycle_tb);

    $display("###EOT###");
end

initial begin
 rst = 1'b0;
 #150;

 rst = 1'b1;
 #500;
 $finish;
end
endmodule