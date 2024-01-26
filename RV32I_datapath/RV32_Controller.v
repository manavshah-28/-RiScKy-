module RV32_Controller(i_instuction);

input [31:0] i_instuction;
input BrEq,BrLt;
wire [6:0]opcode;

// all control signals emerging from the controller.
output PCSel;
output [2:0]ImmSel;
output BrUn;
output ASel,Bsel;
output [3:0]ALUSel;
output MemRW;
output RegWEn;
output [1:0]WBSel;

output [14:0]control_word;

// for instruction encoding, 9 bits of the full 32bit instruction will be used.
// bit 30, [14:12] , [6,2].
// BrEq and BrLt will also be used.
// so in total, 11 bits will be used to generate control word output. 15 bits


endmodule