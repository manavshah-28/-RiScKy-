module data_memory(clk,A,WD,WE,RD);
// single read write port
input clk;
input [31:0] A,WD; // writes data WD on address A
input WE; // write enable

reg [31:0]data_mem[1023:0];

output [31:0]RD;  // if WE = 0, it reads data on address A out to RD

initial begin
data_mem[0]  = 32'h00000000;
data_mem[28] = 32'h00000020;
data_mem[40] = 32'h00000002;
end
always @(posedge clk)begin
   
   if(WE == 1'b1)begin
      data_mem[A] <= WD;
   end
end

assign RD = (WE == 1'b0) ? data_mem[A] : 32'h00000000;


endmodule