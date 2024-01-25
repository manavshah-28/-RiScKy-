module Imm_Gen(Instr,ImmSel,immediate);

input [31:0]Instr;
input [2:0]ImmSel;

output [31:0]immediate;

endmodule