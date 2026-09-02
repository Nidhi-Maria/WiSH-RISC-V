# WiSH-RISC-V

A single-cycle **RV32I** RISC-V processor written in **SystemVerilog**, with a
Python (**cocotb**) testbench driven by **Icarus Verilog**. The core implements
the RV32I base integer instruction set and is verified at two levels: individual
submodules in isolation, and the full processor running compiled C firmware.

Built as part of the WiSH course.

## Features

- Single-cycle RV32I datapath organised as fetch → decode → execute
- Register/immediate ALU operations, loads and stores, conditional branches,
  jumps (JAL/JALR), and upper-immediate instructions (LUI/AUIPC)
- A unified memory with an instruction/data arbiter that shares one memory port
  between instruction fetch and data access
- Two-tier verification: per-module unit tests and full-processor firmware tests
- C firmware examples compiled to a hex image and loaded into memory

## Repository layout

```
ver/                 SystemVerilog RTL (the processor)
  processor.sv         top-level module (wires IFU, arbiter, mem, IDU, IEU)
  processor_defines.sv shared defines
  ifu.sv               instruction fetch unit (PC logic)
  idu.sv / ieu.sv      decode and execute units
  inst_data_arbiter.sv shares the memory port between fetch and data access
  mem.sv               unified memory
  regfile.sv           register file
  alu.sv / alu_core.sv arithmetic/logic unit
  branch.sv jump.sv load.sv store.sv   execute helpers
  decode_*_inst.sv     per-instruction-type decoders

sim_submodules/      cocotb unit tests for individual modules
sim/                 cocotb integration tests for the whole processor
  firmware/            C sources, linker script, and hex-build scripts
```

## Prerequisites

- [Icarus Verilog](http://iverilog.icarus.com/) (`iverilog`)
- Python 3 with [cocotb](https://www.cocotb.org/) (`pip install cocotb`)
- A RISC-V GCC toolchain (`riscv32-unknown-elf-gcc` or similar) to build the
  firmware hex used by the full-processor tests

On Ubuntu:

```bash
sudo apt install iverilog
pip install cocotb
```

## Running the tests

Each Makefile takes the test name via `tname`.

**Submodule (unit) tests** — run a single module in isolation:

```bash
cd sim_submodules
make tname=alu
make tname=load
make tname=branch
make tname=inst_data_arbiter
```

**Full-processor (integration) tests** — run compiled firmware on the whole core:

```bash
cd sim
make tname=example1
make tname=example2
make tname=general
```

Waveforms are written to the `sim_build/` directory as `.vcd` files and can be
opened in GTKWave.
