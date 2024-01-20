`timescale 1ns/1ps
`include "PC.v"

module PC_tb;

reg clk,rst;

reg [31:0] PC_Nxt;
wire [31:0] PC;

Prog_Count dut(clk,rst,PC,PC_Nxt);
reg [31:0]i;
parameter max_clks=200;
initial begin

    $dumpfile("PC_tb.vcd");
    $dumpvars(0,PC_tb);

    clk = 0;
    rst = 0;
    PC_Nxt = 2;
     for(i = 0; i<max_clks;i=i+1) begin
        #10
        clk = ~ clk;
     end
    #10
    rst = 1;

    #10
    rst = 1;

    #10
    PC_Nxt = 3;

    #10
    rst =0;

    $display("EOT");
end

endmodule