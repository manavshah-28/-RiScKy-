module Instruction_memory(rst,A,RD);

input rst;
input [31:0]A;

output [31:0]RD;

reg [31:0]mem[1023:0];
assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[32:2]];

initial begin
    $readmemh("instructions.hex",mem);
end


endmodule