`timescale 1ps/1ps
`include "register_file.v"

module register_file_tb;

reg clk =0,rst;
reg WE3;
reg [4:0] A1,A2,A3;
reg [31:0] WD3;

reg [31:0]Register[31:0];
wire [31:0] RD1,RD2;

// module isntantiation

regsiter_file regfile(.clk(clk),.rst(rst),.WE3(WE3),.WD3(WD3),.A1(A1),.A2(A2),.A3(A3),.RD1(RD1),.RD2(RD2));

always begin
    clk=~clk;
    #50;
end

initial begin
    Register[1] = 32'h01010101;
    Register[2] = 32'h01010101;
end

initial begin
  $dumpfile("register_file_tb.vcd");
  $dumpvars(0,register_file_tb);

  $display("### EOT ###");
end

initial begin
rst <= 1'b0;
#200;
rst <= 1'b1;
// gave a reset for 200 clock cycles
WD3 = 32'h00203400;


WE3 = 1;
A1 = 5'b00001;
A2 = 5'b10101;
A3 = 5'b00001;

#10;

WE3 = 1;

#10

WE3 = 1;

#10;

A1 = 32'h00000001;

#60;

rst <= 0;
#10;

rst <= 1;

#20
$finish;

end
endmodule