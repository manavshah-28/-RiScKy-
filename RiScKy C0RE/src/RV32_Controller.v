/*/////////////////////////////////////////////
 File: RV32_Controller.v
 Author: Manav Shah
 ----------------------------------------------

    ██████╗ ██╗███████╗ ██████╗██╗  ██╗██╗   ██╗
    ██╔══██╗██║██╔════╝██╔════╝██║ ██╔╝╚██╗ ██╔╝
    ██████╔╝██║███████╗██║     █████╔╝  ╚████╔╝ 
    ██╔══██╗██║╚════██║██║     ██╔═██╗   ╚██╔╝  
    ██║  ██║██║███████║╚██████╗██║  ██╗   ██║   
    ╚═╝  ╚═╝╚═╝╚══════╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   
 ----------------------------------------------
                                    
 Copyright (c) 2024 MANAV SHAH
*//////////////////////////////////////////////

module RV32_Controller(i_instuction, BrEq, BrLt,
PCSel, ImmSel, BrUn, ASel, BSel, ALUSel, MemRW, RegWEn, WBSel);

input [31:0] i_instuction;
input BrEq,BrLt;

// wire reduced instruction.
wire [10:0]red_inst;
assign red_inst = {i_instuction[30],i_instuction[14:12],i_instuction[6:2],BrEq,BrLt};

// all control signals.
output PCSel;
output [2:0]ImmSel;
output BrUn;
output ASel,BSel;
output [3:0]ALUSel;
output MemRW;
output RegWEn;
output [1:0]WBSel;

wire [14:0]control_word;
assign control_word = (red_inst[10:2] == 9'b000001100) ? 15'b000000000000101 :  // add
                      (red_inst[10:2] == 9'b100001100) ? 15'b000000000010101 :  // sub
                      (red_inst[9:2]  ==  8'b00101100) ? 15'b000000000100101 :  // sll
                      (red_inst[9:2]  ==  8'b01001100) ? 15'b000000000110101 :  // slt
                      (red_inst[9:2]  ==  8'b01101100) ? 15'b000000001000101 :  // sltu
                      (red_inst[9:2]  ==  8'b10001100) ? 15'b000000001010101 :  // xor
                      (red_inst[10:2] == 9'b010101100) ? 15'b000000001100101 :  // srl
                      (red_inst[10:2] == 9'b110101100) ? 15'b000000001110101 :  // sra
                      (red_inst[9:2]  ==  8'b11001100) ? 15'b000000010000101 :  // or                  
                      (red_inst[9:2]  ==  8'b11101100) ? 15'b000000010010101 :  // and

                      (red_inst[9:2]  ==  8'b00000100) ? 15'b000100100000101 :  // addi
                      (red_inst[9:2]  ==  8'b01000100) ? 15'b000100100110101 :  // slti
                      (red_inst[9:2]  ==  8'b01100100) ? 15'b000100101000101 :  // sltiu
                      (red_inst[9:2]  ==  8'b10000100) ? 15'b000100101010101 :  // xori
                      (red_inst[9:2]  ==  8'b11000100) ? 15'b000100110000101 :  // ori
                      (red_inst[9:2]  ==  8'b11100100) ? 15'b000100110010101 :  // andi
                      (red_inst[9:2]  ==  8'b00100100) ? 15'b000100100100101 :  // slli
                      (red_inst[10:2]==  9'b010100100) ? 15'b000100101100101 :  // srli
                      (red_inst[10:2]==  9'b110100100) ? 15'b000100101110101 :  // srai

                      (red_inst[9:2]  ==  8'b00000000) ? 15'b000100110100101 :  // lb
                      (red_inst[9:2]  ==  8'b00100000) ? 15'b000100110110101 :  // lh
                      (red_inst[9:2]  ==  8'b01000000) ? 15'b000100100000101 :  // lw
                      (red_inst[9:2]  ==  8'b10000000) ? 15'b000100111000101 :  // lbu
                      (red_inst[9:2]  ==  8'b10100000) ? 15'b000100111010101 :  // lhu

                      (red_inst[9:2]  ==  8'b00001000) ? 15'b001000110100101 :  // sb
                      (red_inst[9:2]  ==  8'b00101000) ? 15'b001000110110101 :  // sh
                      (red_inst[9:2]  ==  8'b01001000) ? 15'b001000100000101 :  // sw

                      (red_inst[9:1]  == 9'b000110000) ? 15'b001101100000000 :  // beq BrEq = 0
                      (red_inst[9:1]  == 9'b000110001) ? 15'b101101100000000 :  // beq BrEq = 1
                      (red_inst[9:1]  == 9'b001110000) ? 15'b101101100000000 :  // bne BrEq = 0
                      (red_inst[9:1]  == 9'b001110001) ? 15'b001101100000000 :  // bne BrEq = 1

                      ({red_inst[9:2],red_inst[0]} == 9'b100110001) ? 15'b101101100000000 : // blt BLT = 1
                      ({red_inst[9:2],red_inst[0]} == 9'b110110001) ? 15'b101111100000000 : // bltu BLT = 1

                      ({red_inst[9:2],red_inst[0]} == 9'b101110000) ? 15'b101101100000000 : // bge brEq = (0,1) brLT = (0)

                      15'b000000000000101;

assign PCSel = control_word[14];
assign ImmSel = control_word[13:11];
assign BrUn = control_word[10];
assign ASel = control_word[9];
assign BSel = control_word[8];
assign ALUSel = control_word[7:4];
assign MemRW = control_word[3];
assign RegWEn = control_word[2];
assign WBSel = control_word[1:0];

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