/*/////////////////////////////////////////////
 File: RV32_Controller.sv
 Author: Manav Shah
 ----------------------------------------------

    ██████╗ ██╗███████╗ ██████╗██╗  ██╗██╗   ██╗
    ██╔══██╗██║██╔════╝██╔════╝██║ ██╔╝╚██╗ ██╔╝
    ██████╔╝██║███████╗██║     █████╔╝  ╚████╔╝ 
    ██╔══██╗██║╚════██║██║     ██╔═██╗   ╚██╔╝  
    ██║  ██║██║███████║╚██████╗██║  ██╗   ██║   
    ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   
 ----------------------------------------------
                                    
 Copyright (c) 2025 MANAV SHAH
*//////////////////////////////////////////////

module RV32_Controller(intr_F, intr_D, intr_E, intr_M, BrEq, BrLt,
PCSel, ImmSel, BrUn, ASel, BSel, ALUSel, MemRW, RegWEn, WBSel);

input [31:0] intr_F, intr_D, intr_E, intr_M;
input BrEq,BrLt;

// wire reduced instruction.
logic [10:0]red_inst_F, red_inst_D, red_inst_E, red_inst_M;
assign red_inst_F = {intr_F[30],intr_F[14:12],intr_F[6:2],BrEq,BrLt};
assign red_inst_D = {intr_D[30],intr_D[14:12],intr_D[6:2],BrEq,BrLt};
assign red_inst_E = {intr_E[30],intr_E[14:12],intr_E[6:2],BrEq,BrLt};
assign red_inst_M = {intr_M[30],intr_M[14:12],intr_M[6:2],BrEq,BrLt};

// all control signals.
output PCSel;
output [2:0]ImmSel;
output BrUn;
output ASel,BSel;
output [3:0]ALUSel;
output MemRW;
output RegWEn;
output [1:0]WBSel;

logic [14:0]control_word_F, control_word_D, control_word_E, control_word_M;
assign control_word_F = (red_inst_F[10:2] == 9'b000001100) ? 15'b000000000000101 :  // add
                      (red_inst_F[10:2] == 9'b100001100) ? 15'b000000000010101 :  // sub
                      (red_inst_F[9:2]  ==  8'b00101100) ? 15'b000000000100101 :  // sll
                      (red_inst_F[9:2]  ==  8'b01001100) ? 15'b000000000110101 :  // slt
                      (red_inst_F[9:2]  ==  8'b01101100) ? 15'b000000001000101 :  // sltu
                      (red_inst_F[9:2]  ==  8'b10001100) ? 15'b000000001010101 :  // xor
                      (red_inst_F[10:2] == 9'b010101100) ? 15'b000000001100101 :  // srl
                      (red_inst_F[10:2] == 9'b110101100) ? 15'b000000001110101 :  // sra
                      (red_inst_F[9:2]  ==  8'b11001100) ? 15'b000000010000101 :  // or                  
                      (red_inst_F[9:2]  ==  8'b11101100) ? 15'b000000010010101 :  // and

                      (red_inst_F[9:2]  ==  8'b00000100) ? 15'b000100100000101 :  // addi
                      (red_inst_F[9:2]  ==  8'b01000100) ? 15'b000100100110101 :  // slti
                      (red_inst_F[9:2]  ==  8'b01100100) ? 15'b000100101000101 :  // sltiu
                      (red_inst_F[9:2]  ==  8'b10000100) ? 15'b000100101010101 :  // xori
                      (red_inst_F[9:2]  ==  8'b11000100) ? 15'b000100110000101 :  // ori
                      (red_inst_F[9:2]  ==  8'b11100100) ? 15'b000100110010101 :  // andi
                      (red_inst_F[9:2]  ==  8'b00100100) ? 15'b000100100100101 :  // slli
                      (red_inst_F[10:2]==  9'b010100100) ? 15'b000100101100101 :  // srli
                      (red_inst_F[10:2]==  9'b110100100) ? 15'b000100101110101 :  // srai

                      (red_inst_F[9:2]  ==  8'b00000000) ? 15'b000100110100101 :  // lb
                      (red_inst_F[9:2]  ==  8'b00100000) ? 15'b000100110110101 :  // lh
                      (red_inst_F[9:2]  ==  8'b01000000) ? 15'b000100100000101 :  // lw
                      (red_inst_F[9:2]  ==  8'b10000000) ? 15'b000100111000101 :  // lbu
                      (red_inst_F[9:2]  ==  8'b10100000) ? 15'b000100111010101 :  // lhu

                      (red_inst_F[9:2]  ==  8'b00001000) ? 15'b001000110100101 :  // sb
                      (red_inst_F[9:2]  ==  8'b00101000) ? 15'b001000110110101 :  // sh
                      (red_inst_F[9:2]  ==  8'b01001000) ? 15'b001000100000101 :  // sw

                      (red_inst_F[9:1]  == 9'b000110000) ? 15'b001101100000000 :  // beq BrEq = 0
                      (red_inst_F[9:1]  == 9'b000110001) ? 15'b101101100000000 :  // beq BrEq = 1
                      (red_inst_F[9:1]  == 9'b001110000) ? 15'b101101100000000 :  // bne BrEq = 0
                      (red_inst_F[9:1]  == 9'b001110001) ? 15'b001101100000000 :  // bne BrEq = 1

                      ({red_inst_F[9:2],red_inst_F[0]} == 9'b100110001) ? 15'b101101100000000 : // blt BLT = 1
                      ({red_inst_F[9:2],red_inst_F[0]} == 9'b110110001) ? 15'b101111100000000 : // bltu BLT = 1

                      ({red_inst_F[9:2],red_inst_F[0]} == 9'b101110000) ? 15'b101101100000000 : // bge brEq = (0,1) brLT = (0)

                      ({red_inst_F[6:2]} == 5'b11011) ? 15'b110001100000110 : // jal 
                      ({red_inst_F[6:2]} == 5'b11001) ? 15'b100100100000110 : // jalr 

                      ({red_inst_F[6:2]} == 5'b01101) ? 15'b010100111100101 : // lui // made different alu control '1110' which forwards B to output and // new immediate type named 'U' '101'
                      ({red_inst_F[6:2]} == 5'b00101) ? 15'b010101100000101 : // 
                      
                      15'b000000000000101;

assign control_word_D = (red_inst_D[10:2] == 9'b000001100) ? 15'b000000000000101 :  // add
                      (red_inst_D[10:2] == 9'b100001100) ? 15'b000000000010101 :  // sub
                      (red_inst_D[9:2]  ==  8'b00101100) ? 15'b000000000100101 :  // sll
                      (red_inst_D[9:2]  ==  8'b01001100) ? 15'b000000000110101 :  // slt
                      (red_inst_D[9:2]  ==  8'b01101100) ? 15'b000000001000101 :  // sltu
                      (red_inst_D[9:2]  ==  8'b10001100) ? 15'b000000001010101 :  // xor
                      (red_inst_D[10:2] == 9'b010101100) ? 15'b000000001100101 :  // srl
                      (red_inst_D[10:2] == 9'b110101100) ? 15'b000000001110101 :  // sra
                      (red_inst_D[9:2]  ==  8'b11001100) ? 15'b000000010000101 :  // or                  
                      (red_inst_D[9:2]  ==  8'b11101100) ? 15'b000000010010101 :  // and

                      (red_inst_D[9:2]  ==  8'b00000100) ? 15'b000100100000101 :  // addi
                      (red_inst_D[9:2]  ==  8'b01000100) ? 15'b000100100110101 :  // slti
                      (red_inst_D[9:2]  ==  8'b01100100) ? 15'b000100101000101 :  // sltiu
                      (red_inst_D[9:2]  ==  8'b10000100) ? 15'b000100101010101 :  // xori
                      (red_inst_D[9:2]  ==  8'b11000100) ? 15'b000100110000101 :  // ori
                      (red_inst_D[9:2]  ==  8'b11100100) ? 15'b000100110010101 :  // andi
                      (red_inst_D[9:2]  ==  8'b00100100) ? 15'b000100100100101 :  // slli
                      (red_inst_D[10:2]==  9'b010100100) ? 15'b000100101100101 :  // srli
                      (red_inst_D[10:2]==  9'b110100100) ? 15'b000100101110101 :  // srai

                      (red_inst_D[9:2]  ==  8'b00000000) ? 15'b000100110100101 :  // lb
                      (red_inst_D[9:2]  ==  8'b00100000) ? 15'b000100110110101 :  // lh
                      (red_inst_D[9:2]  ==  8'b01000000) ? 15'b000100100000101 :  // lw
                      (red_inst_D[9:2]  ==  8'b10000000) ? 15'b000100111000101 :  // lbu
                      (red_inst_D[9:2]  ==  8'b10100000) ? 15'b000100111010101 :  // lhu

                      (red_inst_D[9:2]  ==  8'b00001000) ? 15'b001000110100101 :  // sb
                      (red_inst_D[9:2]  ==  8'b00101000) ? 15'b001000110110101 :  // sh
                      (red_inst_D[9:2]  ==  8'b01001000) ? 15'b001000100000101 :  // sw

                      (red_inst_D[9:1]  == 9'b000110000) ? 15'b001101100000000 :  // beq BrEq = 0
                      (red_inst_D[9:1]  == 9'b000110001) ? 15'b101101100000000 :  // beq BrEq = 1
                      (red_inst_D[9:1]  == 9'b001110000) ? 15'b101101100000000 :  // bne BrEq = 0
                      (red_inst_D[9:1]  == 9'b001110001) ? 15'b001101100000000 :  // bne BrEq = 1

                      ({red_inst_D[9:2],red_inst_D[0]} == 9'b100110001) ? 15'b101101100000000 : // blt BLT = 1
                      ({red_inst_D[9:2],red_inst_D[0]} == 9'b110110001) ? 15'b101111100000000 : // bltu BLT = 1

                      ({red_inst_D[9:2],red_inst_D[0]} == 9'b101110000) ? 15'b101101100000000 : // bge brEq = (0,1) brLT = (0)

                      ({red_inst_D[6:2]} == 5'b11011) ? 15'b110001100000110 : // jal 
                      ({red_inst_D[6:2]} == 5'b11001) ? 15'b100100100000110 : // jalr 

                      ({red_inst_D[6:2]} == 5'b01101) ? 15'b010100111100101 : // lui // made different alu control '1110' which forwards B to output and // new immediate type named 'U' '101'
                      ({red_inst_D[6:2]} == 5'b00101) ? 15'b010101100000101 : // 
                      
                      15'b000000000000101;

assign control_word_E = (red_inst_E[10:2] == 9'b000001100) ? 15'b000000000000101 :  // add
                      (red_inst_E[10:2] == 9'b100001100) ? 15'b000000000010101 :  // sub
                      (red_inst_E[9:2]  ==  8'b00101100) ? 15'b000000000100101 :  // sll
                      (red_inst_E[9:2]  ==  8'b01001100) ? 15'b000000000110101 :  // slt
                      (red_inst_E[9:2]  ==  8'b01101100) ? 15'b000000001000101 :  // sltu
                      (red_inst_E[9:2]  ==  8'b10001100) ? 15'b000000001010101 :  // xor
                      (red_inst_E[10:2] == 9'b010101100) ? 15'b000000001100101 :  // srl
                      (red_inst_E[10:2] == 9'b110101100) ? 15'b000000001110101 :  // sra
                      (red_inst_E[9:2]  ==  8'b11001100) ? 15'b000000010000101 :  // or                  
                      (red_inst_E[9:2]  ==  8'b11101100) ? 15'b000000010010101 :  // and

                      (red_inst_E[9:2]  ==  8'b00000100) ? 15'b000100100000101 :  // addi
                      (red_inst_E[9:2]  ==  8'b01000100) ? 15'b000100100110101 :  // slti
                      (red_inst_E[9:2]  ==  8'b01100100) ? 15'b000100101000101 :  // sltiu
                      (red_inst_E[9:2]  ==  8'b10000100) ? 15'b000100101010101 :  // xori
                      (red_inst_E[9:2]  ==  8'b11000100) ? 15'b000100110000101 :  // ori
                      (red_inst_E[9:2]  ==  8'b11100100) ? 15'b000100110010101 :  // andi
                      (red_inst_E[9:2]  ==  8'b00100100) ? 15'b000100100100101 :  // slli
                      (red_inst_E[10:2]==  9'b010100100) ? 15'b000100101100101 :  // srli
                      (red_inst_E[10:2]==  9'b110100100) ? 15'b000100101110101 :  // srai

                      (red_inst_E[9:2]  ==  8'b00000000) ? 15'b000100110100101 :  // lb
                      (red_inst_E[9:2]  ==  8'b00100000) ? 15'b000100110110101 :  // lh
                      (red_inst_E[9:2]  ==  8'b01000000) ? 15'b000100100000101 :  // lw
                      (red_inst_E[9:2]  ==  8'b10000000) ? 15'b000100111000101 :  // lbu
                      (red_inst_E[9:2]  ==  8'b10100000) ? 15'b000100111010101 :  // lhu

                      (red_inst_E[9:2]  ==  8'b00001000) ? 15'b001000110100101 :  // sb
                      (red_inst_E[9:2]  ==  8'b00101000) ? 15'b001000110110101 :  // sh
                      (red_inst_E[9:2]  ==  8'b01001000) ? 15'b001000100000101 :  // sw

                      (red_inst_E[9:1]  == 9'b000110000) ? 15'b001101100000000 :  // beq BrEq = 0
                      (red_inst_E[9:1]  == 9'b000110001) ? 15'b101101100000000 :  // beq BrEq = 1
                      (red_inst_E[9:1]  == 9'b001110000) ? 15'b101101100000000 :  // bne BrEq = 0
                      (red_inst_E[9:1]  == 9'b001110001) ? 15'b001101100000000 :  // bne BrEq = 1

                      ({red_inst_E[9:2],red_inst_E[0]} == 9'b100110001) ? 15'b101101100000000 : // blt BLT = 1
                      ({red_inst_E[9:2],red_inst_E[0]} == 9'b110110001) ? 15'b101111100000000 : // bltu BLT = 1

                      ({red_inst_E[9:2],red_inst_E[0]} == 9'b101110000) ? 15'b101101100000000 : // bge brEq = (0,1) brLT = (0)

                      ({red_inst_E[6:2]} == 5'b11011) ? 15'b110001100000110 : // jal 
                      ({red_inst_E[6:2]} == 5'b11001) ? 15'b100100100000110 : // jalr 

                      ({red_inst_E[6:2]} == 5'b01101) ? 15'b010100111100101 : // lui // made different alu control '1110' which forwards B to output and // new immediate type named 'U' '101'
                      ({red_inst_E[6:2]} == 5'b00101) ? 15'b010101100000101 : // 
                      
                      15'b000000000000101;

assign control_word_M = (red_inst_M[10:2] == 9'b000001100) ? 15'b000000000000101 :  // add
                      (red_inst_M[10:2] == 9'b100001100) ? 15'b000000000010101 :  // sub
                      (red_inst_M[9:2]  ==  8'b00101100) ? 15'b000000000100101 :  // sll
                      (red_inst_M[9:2]  ==  8'b01001100) ? 15'b000000000110101 :  // slt
                      (red_inst_M[9:2]  ==  8'b01101100) ? 15'b000000001000101 :  // sltu
                      (red_inst_M[9:2]  ==  8'b10001100) ? 15'b000000001010101 :  // xor
                      (red_inst_M[10:2] == 9'b010101100) ? 15'b000000001100101 :  // srl
                      (red_inst_M[10:2] == 9'b110101100) ? 15'b000000001110101 :  // sra
                      (red_inst_M[9:2]  ==  8'b11001100) ? 15'b000000010000101 :  // or                  
                      (red_inst_M[9:2]  ==  8'b11101100) ? 15'b000000010010101 :  // and

                      (red_inst_M[9:2]  ==  8'b00000100) ? 15'b000100100000101 :  // addi
                      (red_inst_M[9:2]  ==  8'b01000100) ? 15'b000100100110101 :  // slti
                      (red_inst_M[9:2]  ==  8'b01100100) ? 15'b000100101000101 :  // sltiu
                      (red_inst_M[9:2]  ==  8'b10000100) ? 15'b000100101010101 :  // xori
                      (red_inst_M[9:2]  ==  8'b11000100) ? 15'b000100110000101 :  // ori
                      (red_inst_M[9:2]  ==  8'b11100100) ? 15'b000100110010101 :  // andi
                      (red_inst_M[9:2]  ==  8'b00100100) ? 15'b000100100100101 :  // slli
                      (red_inst_M[10:2]==  9'b010100100) ? 15'b000100101100101 :  // srli
                      (red_inst_M[10:2]==  9'b110100100) ? 15'b000100101110101 :  // srai

                      (red_inst_M[9:2]  ==  8'b00000000) ? 15'b000100110100101 :  // lb
                      (red_inst_M[9:2]  ==  8'b00100000) ? 15'b000100110110101 :  // lh
                      (red_inst_M[9:2]  ==  8'b01000000) ? 15'b000100100000101 :  // lw
                      (red_inst_M[9:2]  ==  8'b10000000) ? 15'b000100111000101 :  // lbu
                      (red_inst_M[9:2]  ==  8'b10100000) ? 15'b000100111010101 :  // lhu

                      (red_inst_M[9:2]  ==  8'b00001000) ? 15'b001000110100101 :  // sb
                      (red_inst_M[9:2]  ==  8'b00101000) ? 15'b001000110110101 :  // sh
                      (red_inst_M[9:2]  ==  8'b01001000) ? 15'b001000100000101 :  // sw

                      (red_inst_M[9:1]  == 9'b000110000) ? 15'b001101100000000 :  // beq BrEq = 0
                      (red_inst_M[9:1]  == 9'b000110001) ? 15'b101101100000000 :  // beq BrEq = 1
                      (red_inst_M[9:1]  == 9'b001110000) ? 15'b101101100000000 :  // bne BrEq = 0
                      (red_inst_M[9:1]  == 9'b001110001) ? 15'b001101100000000 :  // bne BrEq = 1

                      ({red_inst_M[9:2],red_inst_M[0]} == 9'b100110001) ? 15'b101101100000000 : // blt BLT = 1
                      ({red_inst_M[9:2],red_inst_M[0]} == 9'b110110001) ? 15'b101111100000000 : // bltu BLT = 1

                      ({red_inst_M[9:2],red_inst_M[0]} == 9'b101110000) ? 15'b101101100000000 : // bge brEq = (0,1) brLT = (0)

                      ({red_inst_M[6:2]} == 5'b11011) ? 15'b110001100000110 : // jal 
                      ({red_inst_M[6:2]} == 5'b11001) ? 15'b100100100000110 : // jalr 

                      ({red_inst_M[6:2]} == 5'b01101) ? 15'b010100111100101 : // lui // made different alu control '1110' which forwards B to output and // new immediate type named 'U' '101'
                      ({red_inst_M[6:2]} == 5'b00101) ? 15'b010101100000101 : // 
                      
                      15'b000000000000101;

assign PCSel = control_word_E[14];
assign ImmSel = control_word_F[13:11];
assign BrUn = control_word_D[10];
assign ASel = control_word_D[9];
assign BSel = control_word_D[8];
assign ALUSel = control_word_D[7:4];
assign MemRW = control_word_E[3];
assign RegWEn = control_word_M[2];
assign WBSel = control_word_M[1:0];

endmodule

// for instruction encoding, 9 bits of the full 32bit instruction will be used.
// bit 30, [14:12] , [6,2].
// BrEq and BrLt will also be used.
// so in total, 11 bits will be used to generate control word output. 15 bits
// control word is 15 bits 


/*
                      (red_inst[9:1]  == 9'b000110000) ? 15'b001101100000000 :  // beq BrEq = 0
                      (red_inst[9:1]  == 9'b000110001) ? 15'b101101100000000 :  // beq BrEq = 1
                      (red_inst[9:1]  == 9'b001110000) ? 15'b101101100000000 :  // bne BrEq = 0
                      (red_inst[9:1]  == 9'b001110001) ? 15'b001101100000000 :  // bne BrEq = 1

*/