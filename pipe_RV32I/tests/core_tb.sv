module core_tb;

logic clk;
logic rst;

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
end
// repeat(20)begin
// @(posedge clk);
// end
// fd = $fopen("final_state.txt", "w");
//     $fwrite(fd, "PC = %h\n", dut.PC_reg_F);
//     for (i = 0; i < 32; i = i + 1) begin
//         $fwrite(fd, "x%0d = %h\n", i, dut.regfile.xreg[i]);
//     end
//     $fclose(fd);
// $finish;
// end
integer fd;
integer i;
integer halt_count;
logic halt_seen;

initial begin
    halt_seen  = 0;
    halt_count = 0;

    forever begin
        @(posedge clk);

        // Detect HALT (ecall / custom halt)
        if (!halt_seen && dut.INSTR_reg_F == 32'h0010_0073) begin
            halt_seen  <= 1;
            halt_count <= 0;
            $display("HALT detected at PC = %h", dut.PC_reg_F);
        end

        // After HALT, count extra cycles
        if (halt_seen) begin
            halt_count <= halt_count + 1;

            if (halt_count == 5) begin
                fd = $fopen("final_state.txt", "w");

                $fwrite(fd, "PC = %h\n", dut.PC_reg_F);
                for (i = 0; i < 32; i = i + 1) begin
                    $fwrite(fd, "x%0d = %h\n", i, dut.regfile.xreg[i]);
                end

                $fclose(fd);
                $display("Final state dumped. Stopping simulation.");
                $finish;
            end
        end
    end
end

endmodule