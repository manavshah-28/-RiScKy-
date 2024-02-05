module immediate_gen(Instr,imm);

input [31:0]Instr;
output [31:0] imm;

wire [11:0] inst_imm;

assign inst_imm = (Instr[6:0] == 7'b0100011) ? {Instr[31:25],Instr[11:7]} : Instr[31:20];


assign imm = (inst_imm[11] == 1'b1) ? {{20{1'b1}},inst_imm[11:0]} : {{20{1'b0}},inst_imm[11:0]};

endmodule

// for the Store operations, the immediate is split in segments.
// in the [31:0]Instr, {[31:25],[11,7]} make up the immediate of 12 bits.
// these 12 bits will be concatenated with sign bit extension to create the 32 bit immediate.
