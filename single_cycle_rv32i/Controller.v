module Controller(instr,opcode,rs1,rs2,rd,funct3,funct7,RegWE,ALU_control,Imm_mux_SEL,MemRW,WB_sel);

input [31:0]instr;
input [6:0] opcode;
input [4:0] rs1,rs2,rd;
input [2:0] funct3;
input [6:0] funct7;

output reg RegWE = 1;
output [4:0]ALU_control; // made this 4 bits for R type instructions
output Imm_mux_SEL;

// for Load word 
output MemRW;
output WB_sel;
assign Imm_mux_SEL = (opcode == 7'b0010011 | opcode == 7'b0000011) ? 1'b1 : 1'b0;

assign ALU_control = ((funct3 == 3'b000) & (instr[30] == 1'b0) & (opcode == 7'b0110011)) ? 5'b00000 : // add
                     ((funct3 == 3'b000) & (instr[30] == 1'b1) & (opcode == 7'b0110011)) ? 5'b00001 : // sub
                     ((funct3 == 3'b001) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 5'b00010 :// sll slli
                     ((funct3 == 3'b010) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 5'b00011 :// slt slti
                     ((funct3 == 3'b011) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 5'b00100 :// sltu sltiu
                     ((funct3 == 3'b100) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 5'b00101: // xor xori
                     ((funct3 == 3'b101) & (opcode == 7'b0110011 | opcode == 7'b0010011) & (instr[30] == 1'b0)) ? 5'b00110 : // srl srli                   
                     ((funct3 == 3'b101) & (opcode == 7'b0110011 | opcode == 7'b0010011) & (instr[30] == 1'b1)) ? 5'b00111 : // sra srai                 
                     ((funct3 == 3'b110) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 5'b01000: // or  ori
                     ((funct3 == 3'b111) & (opcode == 7'b0110011 | opcode == 7'b0010011)) ? 5'b01001: // and andi

                     // for Immediate functions
                     ((funct3 == 3'b000) & (opcode == 7'b0010011)) ? 5'b00000 :                       // addi
                     ((funct3 == 3'b010) & (opcode == 7'b0010011)) ? 5'b00011 :                       // slti

                     //LW
                     ((opcode == 7'b0000011) & (funct3 == 3'b000)) ? 5'b01010: //LB
                     ((opcode == 7'b0000011) & (funct3 == 3'b001)) ? 5'b01011: //LH
                     ((opcode == 7'b0000011) & (funct3 == 3'b010)) ? 5'b01100: //LW
                     ((opcode == 7'b0000011) & (funct3 == 3'b100)) ? 5'b01101: //LBU load byte unsigned
                     ((opcode == 7'b0000011) & (funct3 == 3'b101)) ? 5'b01110: //LHU load halfword unsigned

                     // SW
                     ((opcode == 7'b0100011) & (funct3 == 3'b000)) ? 5'b01111: // SB
                     ((opcode == 7'b0100011) & (funct3 == 3'b001)) ? 5'b10000: // SH
                     ((opcode == 7'b0100011) & (funct3 == 3'b010)) ? 5'b10001: // SW



                     5'b0000;  //default

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

assign MemRW = (opcode == 7'b0000011) ? 1'b0 : 1'b1;
assign WB_sel = (opcode == 7'b0000011) ? 1'b1 : 1'b0; // correction in polarity done. now proper.
endmodule
