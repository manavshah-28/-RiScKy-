`timescale 1ps/1ps
`include "alu.v"

module ALU_tb;

reg [31:0] A,B;
reg [2:0] ALUControl;

wire [31:0] Result;
wire Z,N,V,C;

ALU alu_RISCV(.A(A),.B(B),.ALUControl(ALUControl), .Result(Result),.V(V),.C(C),.Z(Z),.N(N));

initial begin
A = 10;
B = 20;
ALUControl = 3'b000;

#5;
ALUControl = 3'b001;
#5;
ALUControl = 3'b010;
#5;
ALUControl = 3'b011;
#5;
ALUControl = 3'b100;
#5;
ALUControl = 3'b101;
#10
$finish;
end

initial begin
  $dumpfile("ALU_tb.vcd");
  $dumpvars(0,ALU_tb);

  $display("### EOT ###");
end

endmodule