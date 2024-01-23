module ALU(A,B,control,ALU_result);

input [31:0] A,B;
//input control;
// control will have to be 3 bits wide now to support all R type instuctions. and alu will also have to be more functional.
input [4:0]control;

output [31:0]ALU_result;
wire [31:0]alu_slt;
assign alu_slt = (A < B) ? 32'h00000001: 32'h00000000;
//assign ALU_result = (control == 1'b0) ? (A + B) : ( A - B);
assign ALU_result = (control == 5'b00000) ? A + B :        //0 add
                    (control == 5'b00001) ? A - B :        //1 sub
                    (control == 5'b00010) ? A << B[4:0] :  //2 sll
                    (control == 5'b00011) ? alu_slt :      //3 slt   set less than signed  :writing 1 to rd if rs1 < rs2, 0 otherwise
                    (control == 5'b00100) ? alu_slt :      //4 sltu  set less than unsigned
                    (control == 5'b00101) ? A ^ B :        //5 xor
                    (control == 5'b00110) ? A >> B[4:0] :  // srl
                    (control == 5'b00111) ? A >>> B[4:0] : // sra
                    (control == 5'b01000) ? A | B :        // or
                    (control == 5'b01001) ? A & B :        // and
                    
                    //LW
                    (control == 5'b01010) ?  {{24{1'b0}},A[7:0]} +  B  : // LB load only 8 bits
                    (control == 5'b01011) ?  {{16{1'b0}},A[15:0]} + B  : // LH              
                    (control == 5'b01100) ?  A + B                     : // LW
                    (control == 5'b01101) ?  {{25{1'b0}},A[6:0]} +  B  : // LBU             
                    (control == 5'b01110) ?  {{17{1'b0}},A[14:0]} + B  : // LHU             
                     
                    //default 
                    32'h00000000;
                    
// SLL, SRL, and SRA perform logical left, logical right, and arithmetic right shifts on the value in 
// register rs1 by the shift amount held in the lower 5 bits of register rs2

endmodule