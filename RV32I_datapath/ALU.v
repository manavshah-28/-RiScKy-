module ALU(A,B,control,ALU_result);

input [31:0] A,B;
//input control;
// control will have to be 3 bits wide now to support all R type instuctions. and alu will also have to be more functional.
input [3:0]control;

output [31:0]ALU_result;

//wires
wire [31:0]alu_slt;

assign alu_slt = (A < B) ? 32'h00000001: 32'h00000000;
//assign ALU_result = (control == 1'b0) ? (A + B) : ( A - B);
assign ALU_result = (control == 4'b0000) ? A + B :        //0 add
                    (control == 4'b0001) ? A - B :        //1 sub
                    (control == 4'b0010) ? A << B[4:0] :  //2 sll
                    (control == 4'b0011) ? alu_slt :      //3 slt   set less than signed  :writing 1 to rd if rs1 < rs2, 0 otherwise
                    (control == 4'b0100) ? alu_slt :      //4 sltu  set less than unsigned
                    (control == 4'b0101) ? A ^ B :        //5 xor
                    (control == 4'b0110) ? A >> B[4:0] :  // srl
                    (control == 4'b0111) ? A >>> B[4:0] : // sra
                    (control == 4'b1000) ? A | B :        // or
                    (control == 4'b1001) ? A & B :        // and
                    
                    //Loads and stores
                    (control == 4'b1010) ? ({{24{1'b0}},A[7:0]} +  B)  : // LB load only 8 bits
                    (control == 4'b1011) ? ({{16{1'b0}},A[15:0]} + B)  : // LH     
                    (control == 4'b1100) ? ({{25{1'b0}},A[6:0]} +  B)  : // LBU  
                    (control == 4'b1101) ? ({{17{1'b0}},A[14:0]} + B)  : // LHU            

                    //default 
                    32'h00000000;
                    
// SLL, SRL, and SRA perform logical left, logical right, and arithmetic right shifts on the value in 
// register rs1 by the shift amount held in the lower 5 bits of register rs2

endmodule