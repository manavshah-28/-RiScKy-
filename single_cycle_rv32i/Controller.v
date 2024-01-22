module Controller(instr,opcode,rs1,rs2,rd,funct3,funct7,RegWE,ALU_control,Imm_mux_SEL);

input [31:0]instr;
input [6:0] opcode;
input [4:0] rs1,rs2,rd;
input [2:0] funct3;
input [6:0] funct7;

output reg RegWE = 1;
output [3:0]ALU_control; // made this 4 bits for R type instructions
output Imm_mux_SEL;

assign Imm_mux_SEL = (opcode == 7'b0010011) ? 1'b1 : 1'b0;

assign ALU_control = ((funct3 == 3'b000) & (instr[30] == 1'b0) & (opcode == 7'b0110011)) ? 4'b0000 : // add
                     ((funct3 == 3'b000) & (instr[30] == 1'b1) & (opcode == 7'b0110011)) ? 4'b0001 : // sub
                     ((funct3 == 3'b001) & (opcode == 7'b0110011)) ? 4'b0010 :                       // sll
                     ((funct3 == 3'b010) & (opcode == 7'b0110011)) ? 4'b0011 :                       // slt
                     ((funct3 == 3'b011) & (opcode == 7'b0110011)) ? 4'b0100 :                       // sllu
                     ((funct3 == 3'b100) & (opcode == 7'b0110011)) ? 4'b0101 :                       // xor
                     ((funct3 == 3'b101) & (opcode == 7'b0110011) & (instr[30] == 1'b0)) ? 4'b0110 : // srl                     
                     ((funct3 == 3'b101) & (opcode == 7'b0110011) & (instr[30] == 1'b1)) ? 4'b0111 : // sra                   
                     ((funct3 == 3'b110) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 4'b1000:// or  ori
                     ((funct3 == 3'b111) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 4'b1001:// and andi

                     // for Immediate functions
                     ((funct3 == 3'b000) & (opcode == 7'b0010011)) ? 4'b0000 :                       // addi
                     ((funct3 == 3'b010) & (opcode == 7'b0010011)) ? 4'b0011 :                       // slti
                     4'b0000;  //default

/*
assign ALU_control = ((funct3 == 3'b000) & (instr[30] == 1'b0) & (opcode == 7'b0110011)) ? 4'b0000 : // add
                     ((funct3 == 3'b000) & (instr[30] == 1'b1) & (opcode == 7'b0110011)) ? 4'b0001 : // sub
                     ((funct3 == 3'b001) & (opcode == 7'b0110011)) ? 4'b0010 :                       // sll
                     ((funct3 == 3'b010) & (opcode == 7'b0110011)) ? 4'b0011 :                       // slt
                     ((funct3 == 3'b011) & (opcode == 7'b0110011)) ? 4'b0100 :                       // sllu
                     ((funct3 == 3'b100) & (opcode == 7'b0110011)) ? 4'b0101 :                       // xor
                     ((funct3 == 3'b101) & (opcode == 7'b0110011) & (instr[30] == 1'b0)) ? 4'b0110 : // srl                     // srl
                     ((funct3 == 3'b101) & (opcode == 7'b0110011) & (instr[30] == 1'b1)) ? 4'b0111 : // sra                     // sll
                     ((funct3 == 3'b110) & (opcode == 7'b0110011)) ? 4'b1000 :                       // sll
                     ((funct3 == 3'b111) & (opcode == 7'b0110011)) ? 4'b1001 :                       // sll
                     4'b0000;
*/


endmodule
