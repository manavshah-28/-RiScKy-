module core_tb;

logic clk;
logic rst;

integer fd;
integer i;

int cycles;

// dut instantiation
core dut(
    .clk(clk),
    .rst(rst)
);

initial begin
clk = 0; 
forever #5 clk = ~clk;
end

initial begin
// toggle rst
rst = 0;
#10;
rst = 1;

repeat(250)begin
@(posedge clk);
end
fd = $fopen("final_state.txt", "w");
    $fwrite(fd, "PC = %h\n", dut.PC_reg_F);
    for (i = 0; i < 32; i = i + 1) begin
        $fwrite(fd, "x%0d = %d\n", i, dut.regfile.xreg[i]);
    end
    $fclose(fd);
$finish;
end

// always @(posedge clk) begin
//     fd = $fopen("final_state.txt", "w");
//     $fwrite(fd, "PC = %h\n", dut.PC_reg_F);
//     for (i = 0; i < 32; i = i + 1) begin
//         $fwrite(fd, "x%0d = %d\n", i, dut.regfile.xreg[i]);
//     end
//     $fclose(fd);
//     if (dut.INSTR_reg_M == 32'h00100073) begin
//         $display("HALT reached at PC=%0d", dut.PC_reg_F);
//         $finish;
//     end
// end

endmodule