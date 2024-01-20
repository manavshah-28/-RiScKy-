# Single Cycle RV32I Datapth Design

## Step by step implementation and progress.
* Module files were written.
* Top file is completed.
* Instantiating PC and PC_adder.
* ![Alt text](image.png)
* Instructions are properly read out of the instructions.hex file.
  
The test code is as follows for the add instruction datapath test.
Instructions: 
```
add x5,x1,x2 # add contents of reg x1 and x2, store result x5
add x5,x3,x5 # add contents of reg x3 and x5, store result x5
add x5,x4,x5 # add contents of reg x4 and x5, store result x5
```
Machine code

```
0x002082B3
0x005182B3
0x005202B3
```
Inside instructions.hex 
```
@00000000
002082B3
005182B3
005202B3
```

* ![Alt text](image-1.png)
* The Add istruction works well, only that Data is not being written into the register, since WE is off.
* ![Alt text](image-2.png)
* After adding WE, this is resolved.
* ![Alt text](image-3.png)
  
