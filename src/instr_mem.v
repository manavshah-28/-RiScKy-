module Instruction_memory(rst,A,RD);
input rst;
input A;
output RD;

reg [31:0]mem[1023:0]; //empty 1 dimensional array to store 32 bit RISCV instructions.


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