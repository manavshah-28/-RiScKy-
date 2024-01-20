module Controller(instr,opcode,rs1,rs2,rd,funct3,funct7,RegWE);

input [31:0]instr;
input [6:0] opcode;
input [4:0] rs1,rs2,rd;
input [2:0] funct3;
input [6:0] funct7;

output RegWE;
output ALU_control;



endmodule
