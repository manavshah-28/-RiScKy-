li x1, 5
li x2, 10
li x3, 5

li x4,0
li x5,1

bne x1,x1 label1
nop
bne x1,x2 label2
nop
bne x2,x2 label3
nop

label1:
   li x15,1
   nop
   nop
   beq x1,x1 end
   
label2:
   li x16,1
   nop
   nop
   beq x1,x1 end

   
label3:
   li x17,1
   nop
   nop
   beq x1,x1 end

end: 
   nop
   nop
   
   