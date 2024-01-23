module immediate_gen(inst_imm,imm);

input [11:0] inst_imm;
output [31:0] imm;

assign imm = (inst_imm[11] == 1'b1) ? {{20{1'b1}},inst_imm[11:0]} : {{20{1'b0}},inst_imm[11:0]};

endmodule

// for the Store operations, the immediate is split in segments.
// in the [31:0]Instr, {[31:25],[11,7]} make up the immediate of 12 bits.
// these 12 bits will be concatenated with sign bit extension to create the 32 bit immediate.
