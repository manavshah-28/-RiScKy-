module Data_mem(clk,A_mem,DataIP,MemWE,D_read); //single read write port 
input clk;
input MemWE; //active high
input [31:0] A_mem;  // address to which input data is stored.
input [31:0] DataIP; // Input Data

output [31:0] D_read;  // the data from memory is given as output

reg [31:0] D_mem [1023:0];  // this is the actual memory

initial begin
    $readmemh("/memory/D_mem.hex",D_mem);
end

always @(posedge clk)begin
if(MemWE == 1'b1)begin
   D_mem[A_mem] <= DataIP;
end
end

assign D_read = (MemWE == 1'b0) ? D_mem[A_mem] : 32'h00000000;

endmodule