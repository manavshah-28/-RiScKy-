module Decoder(instr,opcoders1,rs2,rd,funct3,funct7);

input [31:0]instr;
output [6:0]opcode;
output [4:0]rs1,rs2,rd;
output [2:0] funct3;
output [6:0] funct7;

assign opcode = instr[6:0];
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];

endmodule