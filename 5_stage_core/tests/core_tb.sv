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
    cycles = dut.imem.instr_count * 5; // pipeline depth
    repeat (cycles) begin 
    @(posedge clk);
    fd = $fopen("final_state.txt", "w");

    $fwrite(fd, "PC = %h\n", dut.PC_out);

    for (i = 0; i < 32; i = i + 1) begin
        $fwrite(fd, "x%0d = %h\n", i, dut.regfile.xreg[i]);
    end
    $fclose(fd);
    end
    $finish;
end

initial begin
clk = 0; 
forever #5 clk = ~clk;
end

initial begin
// toggle rst
rst = 0;
#10;
rst = 1;
// // begin test
// repeat(50) begin
// @(posedge clk);
// end

//     fd = $fopen("final_state.txt", "w");

//     $fwrite(fd, "PC = %h\n", dut.PC_out);

//     for (i = 0; i < 32; i = i + 1) begin
//         $fwrite(fd, "x%0d = %h\n", i, dut.regfile.xreg[i]);
//     end

//     $fclose(fd);
// $finish;
end
endmodule