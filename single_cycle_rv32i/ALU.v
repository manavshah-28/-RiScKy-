module ALU(A,B,control,ALU_result);

input [31:0] A,B;
input control;

output [31:0]ALU_result;

assign ALU_result = (control == 1'b0) ? (A + B) : ( A - B);

endmodule