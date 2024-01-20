module Instruction_memory(rst,A,RD);

input rst;
input [31:0]A;

output [31:0]RD;

reg [31:0]mem[1023:0];

assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

initial begin
    $readmemh("instructions.hex",mem);
end

//test purposes
/*initial begin
mem[0]=32'h002082B3;
mem[4]=32'h005182B3;
mem[8]=32'h005202B3;
end*/

endmodule