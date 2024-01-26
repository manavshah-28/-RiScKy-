module RV32_Controller(i_instuction, BrEq, BrLt,
PCSel, ImmSel, BrUn, ASel, Bsel, ALUSel, MemRW, RegWEn, WBSel);

input [31:0] i_instuction;
input BrEq,BrLt;

// wire reduced instruction.
wire [10:0]red_inst;
assign red_inst = {i_instuction[30],i_instuction[14:12],i_instuction[6:2],BrEq,BrLt};

// all control signals.
output PCSel;
output [2:0]ImmSel;
output BrUn;
output ASel,Bsel;
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

