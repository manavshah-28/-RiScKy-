`include "Instruction_memory.v"


module Imeme_tb();
reg clk = 0, rst;
reg [31:0] A;
wire [31:0] RD;
Instruction_memory Instr_mem(.rst(rst),
                             .A(A),
                             .RD(RD));

                             
initial begin
    $dumpfile("instr_mem.vcd");
    $dumpvars(0);
end

initial begin
    rst = 1'b0;
    #150;

    rst = 1'b1;
    A= 32'h00000000;
    #10;
    A= 32'h00000004;
    #10;
    A= 32'h00000008;
    #500;
    $display("End of Test");
    $finish;
end
endmodule