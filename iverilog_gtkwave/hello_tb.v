`timescale 1ps/1ps
`include "hello.v"

module hello_tb;

reg A;
wire B;

hello dut(A,B);

initial begin
    
    $dumpfile("hello_tb.vcd");
    $dumpvars(0, hello_tb);

    A=0;
    #20;

    A=1;
    #20;

    A=0;
    #20;

    $display("Test complete");
end

endmodule