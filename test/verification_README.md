To verify your Verilog RISC-V core using the `riscv-arch-test` repository by `riscv-non-isa`, follow these steps:

### 1. Clone the Necessary Repositories

1. **Clone the `riscv-arch-test` Repository:**
   ```sh
   git clone https://github.com/riscv-non-isa/riscv-arch-test.git
   cd riscv-arch-test
   ```

2. **Clone the RISC-V Toolchain (if not already done):**
   ```sh
   git clone https://github.com/riscv/riscv-gnu-toolchain.git
   cd riscv-gnu-toolchain
   ./configure --prefix=/opt/riscv --with-arch=rv32i --with-abi=ilp32
   make
   export PATH=/opt/riscv/bin:$PATH
   ```

### 2. Set Up Your Core in `riscv-arch-test`

1. **Create a Custom Target Directory:**
   Inside the `riscv-arch-test` repository, create a new directory for your core under `riscv-target`.
   ```sh
   cd riscv-arch-test/riscv-target
   mkdir YourCore
   ```

2. **Provide Implementation Details:**
   In your core's directory, you need to provide several files:
   - `custom_target.mk`: Describes the build and run process.
   - `device/macros/scalar/riscv_test.h`: Contains macros for the tests.
   - `sim.py`: Python script to run simulations (if necessary).

### 3. Configuring the Makefile

1. **Create `custom_target.mk`:**
   This file should include instructions on how to compile the Verilog files and simulate them. Here's an example template:
   ```makefile
   XLEN ?= 32
   RISCV_TARGET = YourCore
   RISCV_DEVICE = rv32i

   # Compiler and flags
   CC = riscv32-unknown-elf-gcc
   OBJCOPY = riscv32-unknown-elf-objcopy
   CFLAGS = -march=rv32i -mabi=ilp32

   # Paths
   PATH_TO_CORE = ../../path/to/your/src
   OUTPUT_DIR = ../../output

   # Simulation
   SIM ?= verilator
   SIM_ARGS ?= --top-module top -f ${PATH_TO_CORE}/filelist.f

   # Rules
   .PHONY: build run clean

   build:
       $(CC) $(CFLAGS) -o $(OUTPUT_DIR)/$(TEST).elf $(TEST_SRC)
       $(OBJCOPY) -O binary $(OUTPUT_DIR)/$(TEST).elf $(OUTPUT_DIR)/$(TEST).bin

   run:
       $(SIM) $(SIM_ARGS)

   clean:
       rm -rf $(OUTPUT_DIR)
   ```

2. **Create `riscv_test.h`:**
   ```c
   #ifndef _RISCV_TEST_H
   #define _RISCV_TEST_H

   #define RV_COMPLIANCE_RV32M

   #define RVTEST_CODE_BEGIN \
       .section .text.init; \
       .align  6; \
       .globl _start; \
       _start:

   #define RVTEST_CODE_END

   #define RVTEST_PASS \
       li x1, 1; \
       ecall

   #define RVTEST_FAIL \
       li x1, 0; \
       ecall

   #define RVTEST_DATA_BEGIN \
       .align 4; \
       .global _begin_data; \
       _begin_data:

   #define RVTEST_DATA_END

   #endif
   ```

3. **Create `sim.py` (if needed for simulation):**
   This script can be used to automate the simulation process.
   ```python
   import os
   import subprocess

   def run_test(test):
       # Compile the test
       subprocess.run(["make", "build", f"TEST={test}"])

       # Run the simulation
       subprocess.run(["make", "run", f"TEST={test}"])

   if __name__ == "__main__":
       tests = ["rv32i-p-add", "rv32i-p-and", "rv32i-p-or"]
       for test in tests:
           run_test(test)
   ```

### 4. Running the Compliance Tests

1. **Navigate to the `riscv-arch-test` Directory:**
   ```sh
   cd riscv-arch-test
   ```

2. **Compile the Compliance Tests:**
   ```sh
   make RISCV_TARGET=YourCore compile
   ```

3. **Run the Tests:**
   ```sh
   make RISCV_TARGET=YourCore simulate
   ```

### 5. Debugging and Verifying Results

1. **Check Output:**
   Inspect the output files generated during simulation to ensure that your core passes all compliance tests.

2. **Fix Issues:**
   If there are any failures, debug the Verilog design and re-run the tests until all tests pass.

### 6. Documenting the Results

1. **Document Compliance Results:**
   Keep a record of the compliance results, including any modifications made to your core during the testing process.

2. **Update Repository:**
   Make sure your GitHub repository is up-to-date with all the necessary files, including documentation of the compliance testing.

By following these steps, you can verify your Verilog RISC-V core using the `riscv-arch-test` repository and ensure it complies with the RV32I standard.