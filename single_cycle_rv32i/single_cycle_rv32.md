# Single Cycle RV32I Datapth Design

## Step by step implementation and progress.
* Module files were written.
* Top file is completed.
* Instantiating PC and PC_adder.
* ![Alt text](image.png)
* Instructions are properly read out of the instructions.hex file.
* ![Alt text](image-1.png)
The test code is as follows for the add instruction datapath test.
* The Add istruction works well, only that Data is not being written into the register, since WE is off.
* ![Alt text](image-2.png)
* After adding WE, this is resolved.
* ![Alt text](image-3.png)
  

* Instructions: 
```
add x5,x1,x2
add x5,x3,x5
add x5,x4,x5
```
* Machine code

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
