# RISC-V CPU — Architecture

Single-cycle implementation of a subset of RV32I targeting Xilinx Spartan-3E
(`xc3s500e-5fg320`, ISE 14.7). The implementation top is the schematic `main.sch`.

## Supported instructions

| Class | Opcode    | Instructions                                              |
|-------|-----------|-----------------------------------------------------------|
| R     | `0110011` | add, sub, sll, slt, sltu, xor, srl, sra, or, and          |
| I     | `0010011` | addi, slti, sltiu, xori, ori, andi, slli, srli, srai      |
| L     | `0000011` | lw (funct3 not decoded)                                   |
| S     | `0100011` | sw (funct3 not decoded)                                   |
| B     | `1100011` | beq, bne, blt, bge, bltu, bgeu                            |

No jumps, LUI/AUIPC. The PC starts at 0 on power-up (no reset input).

## Datapath (`main.sch`)

```
 pc ─► instr_rom ─► instruction ─► opcode/funct3/funct7 ─► control_unit
                         │                                     wer wem alu_src alu2reg imm_rd alu_op branch bneg
                         ├─ rs1 ─► reg_file.a1
                         ├─ rs2 ─► reg_file.a2,  mux25.d0
                         ├─ rd  ─► reg_file.ad,  mux25.d1
                         └─ funct7 ─► joiner12.in7
 mux25 (imm_rd) ─► joiner12.in5 ─► sign_extend ─► imm_ext

 reg_file.do1 ───────────────────────────► ALU.a
 reg_file.do2 ─┬─► mux2(alu_src).d0 ┐
 imm_ext ──────┼─► mux2(alu_src).d1 ┴────► ALU.b ─► alu_y ─► data_mem.a
               └─────────────────────────► data_mem.di
 data_mem.do ─► mux2(alu2reg).d0 ┐
 alu_y ───────► mux2(alu2reg).d1 ┴─► reg_file.di

 pc.dout ─► add_mod.ain ─► add_mod.aout ─► pc.din
 alu_y ─► less_sign (bit 0) ─► add_mod.aluls
 branch, bneg, funct7, rd ─► add_mod     (aluOutput = alu_y, only output port)
```

## Modules

| File | Entity | Function |
|------|--------|----------|
| `alu.vhd` | `alu` | Combinational 32-bit ALU, 4-bit `alu_op` |
| `control_unit.vhd` | `control_unit` | Decodes opcode/funct3/funct7 into control signals |
| `reg_file.vhd` | `reg_file` | 32×32 registers, 2 async reads, 1 sync write, x0 hard-wired to 0 |
| `data_mem.vhd` | `data_mem` | 32×32 RAM (128 B), sync write, async read; out-of-range/misaligned → no write, reads 0 |
| `instr_rom.vhd` | `instr_rom` | 64×32 instruction ROM, async read, index `addr(7:2)`, unused words = `nop`; `clk` unused |
| `sign_extend.vhd` | `sign_extend` | 12 → 32-bit sign extension |
| `mux2.vhd` | `mux2` | Generic 2:1 mux (default N=32) |
| `mux2-5.vhd` | `mux25` | Same mux with N=5 default |
| `instruction.vhd` | `instruction` | Splits instruction into fields |
| `joiner12.vhd` | `joiner12` | Concatenates 7+5 bits into a 12-bit immediate |
| `pc.vhd` | `pc` | 32-bit PC register, power-up value 0, loads `din` on every rising edge |
| `les_sign.vhd` | `less_sign` | Takes bit 0 of the ALU result (compare outcome) → `add_mod.aluls` |
| `add_mod.vhd` | `add_mod` | Next-PC adder: `ain + 4`, or `ain + imm_b` (B-type immediate from funct7/rd) when the branch is taken |
| `main.sch` | `main` | Schematic top (ISE implementation top) |

`datapath.vhd` / `tb_datapath.vhd` are an older VHDL-only version of the top and
are not maintained.

### Control signals

| Signal | 0 | 1 |
|--------|---|---|
| `wer` | — | write register file |
| `wem` | — | write data memory |
| `alu_src` | ALU.b = `do2` | ALU.b = `imm_ext` |
| `alu2reg` | write-back = memory | write-back = ALU |
| `imm_rd` | imm[4:0] = instr[24:20] (I/L) | imm[4:0] = instr[11:7] (S) |
| `branch` | not a branch | B-type instruction (see below) |
| `bneg` | branch on y(0) = 1 (beq, blt, bltu) | branch on y(0) = 0 (bne, bge, bgeu) |

### ALU codes (`alu_op = funct3 & funct7[5]` for R/I)

| alu_op | Op | alu_op | Op |
|--------|----|--------|----|
| 0000 | add | 1000 | xor |
| 0001 | sub | 1010 | srl |
| 0010 | sll | 1011 | sra |
| 0100 | slt | 1100 | or |
| 0110 | sltu | 1110 | and |
| 1111 | seq (a = b) | others | 0 |

`funct7[5]` is only used for funct3 = 000 (R-type) and 101 (shift right), so
`1111` is never produced by R/I instructions; `seq` is only selected by the
control unit for `beq`/`bne`.

### Branches

For B-type the ALU compares rs1 and rs2:

| funct3 | Instr | alu_op | taken when |
|--------|-------|--------|------------|
| 000 / 001 | beq / bne | seq | y(0) = 1 / y(0) = 0 |
| 100 / 101 | blt / bge | slt | y(0) = 1 / y(0) = 0 |
| 110 / 111 | bltu / bgeu | sltu | y(0) = 1 / y(0) = 0 |

`taken = branch and (alu_y(0) xor bneg)` (`bneg = funct3(0)` for valid branches). B-type writes neither the register
file nor memory. `add_mod` builds the B immediate
(`imm[12|11|10:5|4:1] = instr[31|7|30:25|11:8]`) and sets the next PC to
`PC + imm_b` when taken, `PC + 4` otherwise. Offsets are relative to the address
of the branch itself, as in RISC-V.

### Instruction ROM timing

`instr_rom` reads **asynchronously**: `dout` follows `addr` (the PC) in the same
cycle, so each cycle fetches, executes and computes the next PC for the instruction
at PC, and the register/memory write and the PC update happen together on the next
rising edge. XST builds it as distributed ROM (LUTs), not Block RAM.

It used to have a registered (synchronous) output. Together with the PC register
that delayed the instruction by one cycle relative to the PC, so `add_mod` added
branch offsets to PC = branch + 4 (targets one word too far) and the word after a
taken branch still executed. With the test program the loop skipped
`add x12 x10 x11` and the ALU output got stuck at 1. Keep the ROM asynchronous
unless the next-PC logic is redesigned for a pipeline.

## Schematic check (`main.sch` / `main.vhf`, 2026-10-26)

The issues found on 2026-10-23 are fixed: ALU.b comes from the `alu_src` mux
(`do2`/`imm_ext`), `data_mem.di` ← `do2`, write-back mux `d0 = data_mem.do`,
`d1 = alu_y`, `instr_rom` is driven by the PC, `branch`/`bneg` go to `add_mod`,
`aluOutput` is an output port, and `main.vhf` is regenerated.

Behavioral simulation (2026-10-26, 40 cycles, 20 ns clock) of the ROM's Fibonacci
program gives `aluOutput` = 0 1 500 1 1 1 1 1 1 2 1 1 2 1 3 1 2 3 1 5 … 21 1 13 21 1 34,
as expected.

## ISim on Arch Linux

ISim compiles with `/usr/bin/gcc4` (GCC 4.9.4) and links with `-lgcc_s`. Arch
only ships `/usr/lib/libgcc_s.so.1`, so linking fails with
`ld: cannot find -lgcc_s` / `ERROR:Simulator:861 - Failed to link the design`.
Fix (done 2026-10-26):

```
sudo ln -s /usr/lib/libgcc_s.so.1 /usr/lib/gcc/x86_64-pc-linux-gnu/4.9.4/libgcc_s.so
```
