jal x1,init
main:
  addi x7,x5,1
  addi x8,x6,1
  jal x3,end
init:
  addi x5,x5,5
  addi x6,x6,6
  jal x2,main
end:
  nop