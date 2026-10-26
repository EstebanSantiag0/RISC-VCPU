# CLAUDE.md

Single-cycle RV32I subset CPU written in VHDL-93 for a **Xilinx ISE 14.7** project
(`RISC-VCPU.xise`, Spartan-3E `xc3s500e-5fg320`). See `docs/architecture.md` for the
datapath, control signals, ALU codes and the list of known problems.

## Layout
- RTL: `alu.vhd`, `control_unit.vhd`, `reg_file.vhd`, `data_mem.vhd`, `sign_extend.vhd`,
  `mux2.vhd`, `mux2-5.vhd` (entity `mux25`), `instruction.vhd`, `joiner12.vhd`, `instr_rom.vhd`.
- `datapath.vhd`, `tb_datapath.vhd` — old VHDL-only top + testbench; not maintained, ignore.
- `main.sch` — ISE schematic top (the configured *Implementation Top*); `main.vhf` is
  generated from it by `sch2hdl` — never edit `.vhf`.
- Everything else (`*.sym`, `*.spl`, `*.cmd_log`, `*.xrpt`, `*.syr`, `xst/`, `_xmsgs/`,
  `iseconfig/`, `*.gise`, `*.html`) is ISE-generated output.

## Conventions
- Comments and header blocks are in Spanish; follow the existing banner style
  (`------` / `-- Titulo` / `------`).
- `ieee.std_logic_1164` + `ieee.numeric_std` only (no `std_logic_arith`/`unsigned` libs).
- Entities instantiated directly (`entity work.x`), architectures named `rtl`/`struct`/`sim`.
- 2-space indentation in new code (some older files use tabs).
- Memories: 32-bit byte address in, word index = `a(N downto 2)`; sync write, async read
  (`data_mem`) or sync read (`instr_rom`).

## Tooling
- No GHDL/NVC installed on this machine; simulate/synthesize with ISE (ISim/XST).
- New `.vhd` files must be added to the project in ISE (Project → Add Source) to be
  compiled; schematic symbols are regenerated with "Create Schematic Symbol".
