`include "RV32_top.v"

module RV32_tb();

reg clk=0,rst;

//module instantiation
RV32_top DUT(.clk(clk),
             .rst(rst));

// clocking
always begin
    clk = ~clk;
    #50;
end

initial begin
    $dumpfile("RV32_tb.vcd");
    $dumpvars(0,RV32_tb);
end

initial begin

    // give a reset signal (active low)
    rst = 1'b0;
    #150;

    rst = 1'b1;
    #500;
    $display("End Of Test");
    $finish;
end
endmodule