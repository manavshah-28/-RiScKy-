module ALU(A,B,ALU_result);

input [31:0] A,B;
//input ALU_control;

output [31:0]ALU_result;

assign ALU_result = A + B;

endmodule