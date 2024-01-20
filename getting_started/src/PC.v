module PCounter(clk,rst,PC,PC_Nxt);

input clk,rst;
input [31:0]PC_Nxt;

output reg[31:0]PC;

always @(posedge clk)begin
    if (rst == 1'b0)
        PC  <= {32{1'b0}};
    else
        PC <= PC_Nxt;  
end

endmodule