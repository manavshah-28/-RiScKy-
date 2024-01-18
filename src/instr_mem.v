module Instruction_memory(rst,A,RD);
input rst;
input [31:0]A;
output [31:0]RD;

reg [31:0]mem[1023:0]; //empty 1 dimensional array to store 32 bit RISCV instructions.

assign RD = (rst == 1'b0) ? {32{1'b0}} : mem[A[31:2]];

  initial begin
    $readmemh("memfile.hex",mem);  //system task to read data from a hexadecimal file named "memfile.hex" and initialize the content of the memory array mem
  end

/* 
// To store instructions, uncomment the following section.
initial begin
mem[0] = 32'h;
mem[1] = 32'h;
end
*/

endmodule