`include "immediate_gen.v"

module immediate_tb();
reg [11:0]inst_imm;
wire [31:0] imm;
immediate_gen immediate(.inst_imm(inst_imm),
                        .imm(imm));

initial begin
    $dumpfile("immediate_gen_tb.vcd");
    $dumpvars(0);
end

initial begin

inst_imm = 12'b001011010101;
#20;

inst_imm = 12'b101011010101;
#20;

$display("End of Test");
$finish;
end

endmodule
