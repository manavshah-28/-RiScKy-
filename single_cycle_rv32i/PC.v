module PC(clk,rst,PC,PCP4);

input clk,rst;
input [31:0]PCP4;
output [31:0]PC;

always @(posedge clk)begin

    if(rst == 1'b0)begin
        //if reset is active, PC = 0;
        PC <= 32'h00000000;
    end
    else begin
        PC <= PCP4;
    end

end

endmodule