module PC_adder(PC_add,PCP4_add);

input [31:0]PC_add;

output [31:0]PCP4_add;

assign PCP4_add = PC_add + 32'd4;

endmodule