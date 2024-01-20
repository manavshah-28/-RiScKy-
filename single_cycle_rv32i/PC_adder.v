module PC_adder(clk,PC_add,PCP4_add);

input clk;
input [31:0]PC_add;

output [31:0]PCP4_add;

always @(posedge clk)begin
   PCP4_add = PC_add + 32'h00000004;
end
endmodule