module Controller(instr,opcode,rs1,rs2,rd,funct3,funct7,RegWE,ALU_control);

input [31:0]instr;
input [6:0] opcode;
input [4:0] rs1,rs2,rd;
input [2:0] funct3;
input [6:0] funct7;

output reg RegWE = 1;
output ALU_control; // made this 2 bits to give subtraction ability

assign ALU_control = (instr[30] == 1'b1) ? 1'b1 : 1'b0;

endmodule
