`timescale 1ps/1ps
`include "fetch_cycle.v"
`include "instr_mem.v"
`include "PC_adder.v"
`include "PC.v"
`include "mux.v"
module fetch_cycle_tb;

reg clk=0,rst; //declare inputs as registers
reg PCSrcE;
reg [31:0]PCTargetE;
wire [31:0] InstrD; //declare outputs as wires
wire [31:0] PCD,PCPlus4D;

reg [31:0]var;
reg max_iterations = 100;

//clock generation
always begin
    clk = ~clk;  //initial was clk = 1, so the first clock will be low
    #50;
end

// declared the device under test
fetch_cycle dut(.clk(clk),.rst(rst),.PCSrcE(PCSrcE),.PCTargetE(PCTargetE), .InstrD(InstrD),.PCD(PCD),.PCPlus4D(PCPlus4D));

initial begin
rst <= 1'b0;  // give reset at the start.
#200;         // wait fr 200 clock cycles
rst <= 1'b1;  // remove reset
PCSrcE <=1'b0;// Use PCTarget plus 4, therefore PCSrcE is kept at 0
PCTargetE <= 32'h00000000; // PCTarget given as 32 bit hex 0.
#500; //give some buffer to run 
$finish;  // finish to end always blocks
end

// generate vcd
initial begin
   $dumpfile("fetch_cycle_tb.vcd");
   $dumpvars(0,fetch_cycle_tb);

   $display(" ### EOD ###");
end

endmodule