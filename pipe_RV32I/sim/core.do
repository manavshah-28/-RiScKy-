# ----------------------------------
# Clean and create library
# ----------------------------------
if {[file exists work]} {
    vdel -lib work -all
}
vlib work

# ----------------------------------
# Compile
# ----------------------------------
vlog -sv -work work ../src/PC.sv
vlog -sv -work work ../src/PC_adder.sv
vlog -sv -work work ../src/mux.sv
vlog -sv -work work ../src/Instruction_Memory.sv
vlog -sv -work work ../src/Regfile.sv
vlog -sv -work work ../src/Imm_Gen.sv
vlog -sv -work work ../src/RV32_Controller.sv
vlog -sv -work work ../src/branch_comp.sv
vlog -sv -work work ../src/ALU.sv
vlog -sv -work work ../src/Data_mem.sv
vlog -sv -work work ../src/RV32I.sv
vlog -sv -work work ../tests/RV32I_tb.sv


# ----------------------------------
# Simulate
# ----------------------------------
vsim work.RV32I_tb

run -all
quit
