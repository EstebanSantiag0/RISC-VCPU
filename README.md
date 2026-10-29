# Procesador RISC-V (RV32I) de un Solo Ciclo en VHDL

Procesador **RISC-V de un solo ciclo** escrito en **VHDL** para la FPGA **Xilinx Spartan-3E** (`xc3s500e-5fg320`) con **Xilinx ISE 14.7**. Implementa un subconjunto de **RV32I**: operaciones aritméticas y lógicas, desplazamientos, comparaciones, carga/almacenamiento de palabras y los seis saltos condicionales. Cada instrucción se busca, decodifica, ejecuta y escribe en un solo ciclo de reloj.

## Tabla de contenido

- [Descripción general](#descripción-general)
- [Hardware y herramientas](#hardware-y-herramientas)
- [Instrucciones soportadas](#instrucciones-soportadas)
- [Ruta de datos](#ruta-de-datos)
- [Módulos](#módulos)
- [Unidad de control](#unidad-de-control)
- [ALU](#alu)
- [Saltos condicionales](#saltos-condicionales)
- [Programas de prueba](#programas-de-prueba)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Cómo compilar y simular](#cómo-compilar-y-simular)
- [Limitaciones y trabajo futuro](#limitaciones-y-trabajo-futuro)
- [Autoría](#autoría)

## Descripción general

El procesador está formado por los bloques clásicos de una CPU de un ciclo: **contador de programa (PC)**, **memoria de instrucciones**, **banco de 32 registros**, **ALU de 32 bits**, **memoria de datos**, **unidad de control** y la lógica que calcula la **siguiente dirección** (`PC + 4` o `PC + desplazamiento` si se toma un salto). Los módulos están escritos en VHDL y se conectan en el esquemático `main.sch`, que es el *top* del proyecto.

El *top* expone el reloj (`CLK`) y la salida de la ALU (`aluOutput`, 32 bits), que permite seguir en simulación el resultado de cada instrucción.

## Hardware y herramientas

- **FPGA:** Xilinx **Spartan-3E** `xc3s500e-5fg320` (la de la tarjeta Digilent Nexys 2)
- **Herramienta:** Xilinx ISE Design Suite 14.7 (XST para síntesis, ISim para simulación)
- **Lenguaje:** VHDL-93 con `ieee.std_logic_1164` e `ieee.numeric_std`

## Instrucciones soportadas

| Tipo | Opcode | Instrucciones |
|------|--------|---------------|
| R | `0110011` | `add`, `sub`, `sll`, `slt`, `sltu`, `xor`, `srl`, `sra`, `or`, `and` |
| I | `0010011` | `addi`, `slti`, `sltiu`, `xori`, `ori`, `andi`, `slli`, `srli`, `srai` |
| Carga | `0000011` | `lw` |
| Almacenamiento | `0100011` | `sw` |
| B | `1100011` | `beq`, `bne`, `blt`, `bge`, `bltu`, `bgeu` |

No incluye saltos incondicionales (`jal`, `jalr`) ni `lui`/`auipc`. El PC arranca en 0 al encender.

## Ruta de datos

```
 PC ─► instr_rom ─► instruction ─► opcode / funct3 / funct7 ─► control_unit
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

 PC ─► add_mod ─► PC        (PC + 4, o PC + imm_b si el salto se toma)
 alu_y(0) ─► less_sign ─► add_mod
```

La memoria de instrucciones se lee de forma **asíncrona**: en el mismo ciclo en que cambia el PC aparece la instrucción, se ejecuta y se calcula la siguiente dirección; la escritura en registros/memoria y la actualización del PC ocurren juntas en el siguiente flanco de subida.

## Módulos

| Archivo | Entidad | Función |
|---------|---------|---------|
| `pc.vhd` | `pc` | Registro de 32 bits del contador de programa; vale 0 al encender |
| `instr_rom.vhd` | `instr_rom` | ROM de 64 × 32 bits con el programa; lectura asíncrona |
| `instruction.vhd` | `instruction` | Separa la instrucción en sus campos (opcode, rd, rs1, rs2, funct3, funct7) |
| `control_unit.vhd` | `control_unit` | Decodifica opcode/funct3/funct7 y genera las señales de control |
| `reg_file.vhd` | `reg_file` | 32 registros de 32 bits; 2 lecturas asíncronas, 1 escritura síncrona; `x0` siempre vale 0 |
| `mux2-5.vhd` | `mux25` | Multiplexor 2:1 de 5 bits (elige de dónde salen los bits bajos del inmediato) |
| `joiner12.vhd` | `joiner12` | Une 7 + 5 bits para formar el inmediato de 12 bits |
| `sign_extend.vhd` | `sign_extend` | Extensión de signo de 12 a 32 bits |
| `mux2.vhd` | `mux2` | Multiplexor 2:1 genérico (32 bits por defecto) |
| `alu.vhd` | `alu` | ALU combinacional de 32 bits con código de operación de 4 bits |
| `data_mem.vhd` | `data_mem` | RAM de 32 × 32 bits (128 B); escritura síncrona, lectura asíncrona |
| `les_sign.vhd` | `less_sign` | Toma el bit 0 del resultado de la ALU (resultado de la comparación) |
| `add_mod.vhd` | `add_mod` | Sumador de siguiente PC: `PC + 4` o `PC + imm_b` |
| `main.sch` | `main` | Esquemático *top* que conecta todos los módulos |

## Unidad de control

| Señal | 0 | 1 |
|-------|---|---|
| `wer` | — | escribe en el banco de registros |
| `wem` | — | escribe en la memoria de datos |
| `alu_src` | ALU.b = registro `rs2` | ALU.b = inmediato |
| `alu2reg` | se escribe el dato de memoria | se escribe el resultado de la ALU |
| `imm_rd` | inmediato[4:0] = instr[24:20] (tipo I y carga) | inmediato[4:0] = instr[11:7] (almacenamiento) |
| `branch` | no es salto | instrucción tipo B |
| `bneg` | salta si y(0) = 1 (`beq`, `blt`, `bltu`) | salta si y(0) = 0 (`bne`, `bge`, `bgeu`) |

## ALU

Para instrucciones R e I, `alu_op = funct3 & funct7[5]`:

| `alu_op` | Operación | `alu_op` | Operación |
|----------|-----------|----------|-----------|
| `0000` | add | `1000` | xor |
| `0001` | sub | `1010` | srl |
| `0010` | sll | `1011` | sra |
| `0100` | slt | `1100` | or |
| `0110` | sltu | `1110` | and |
| `1111` | seq (a = b) | otros | 0 |

`seq` solo lo selecciona la unidad de control para `beq`/`bne`.

## Saltos condicionales

En las instrucciones tipo B la ALU compara `rs1` con `rs2`:

| funct3 | Instrucción | `alu_op` | Se toma cuando |
|--------|-------------|----------|----------------|
| `000` / `001` | `beq` / `bne` | seq | y(0) = 1 / y(0) = 0 |
| `100` / `101` | `blt` / `bge` | slt | y(0) = 1 / y(0) = 0 |
| `110` / `111` | `bltu` / `bgeu` | sltu | y(0) = 1 / y(0) = 0 |

`tomado = branch and (alu_y(0) xor bneg)`. `add_mod` arma el inmediato B (`imm[12|11|10:5|4:1] = instr[31|7|30:25|11:8]`) y el desplazamiento es relativo a la dirección del propio salto, como en RISC-V. Los saltos no escriben ni en registros ni en memoria.

## Programas de prueba

El programa se carga editando la constante de `instr_rom.vhd`. Los archivos de texto incluyen dos programas listos para pegar:

- **`funct1.txt` — Fibonacci.** `x10`/`x11` guardan F(n−1)/F(n) y `x12` el siguiente término; el ciclo se repite hasta que el contador `x6` llega al límite `x5`. En la simulación, `aluOutput` muestra los términos de la serie (1, 2, 3, 5, 8, 13, 21, 34, …) intercalados con los valores del contador y de las comparaciones.
- **`funct2.txt` — Conjetura de Collatz.** Parte de n = 5000 (cargado como 1250 y desplazado 2 bits a la izquierda) y aplica n/2 si es par o 3n + 1 si es impar hasta llegar a 1; `x12` cuenta los pasos (28 para n = 5000). Es el programa cargado actualmente en la ROM.

## Estructura del repositorio

```
RISC-VCPU/
├── docs/
│   └── architecture.md     # Notas técnicas detalladas (en inglés)
├── main.sch                # Esquemático top
├── *.vhd                   # Módulos del procesador (ver tabla de módulos)
├── *.sym                   # Símbolos de esquemático de cada módulo
├── funct1.txt              # Programa de prueba: Fibonacci
├── funct2.txt              # Programa de prueba: Collatz
├── sim_main.cmd            # Comandos de ISim (reloj, ondas, registros)
├── datapath.vhd            # Versión anterior del top, solo VHDL (sin mantenimiento)
├── tb_datapath.vhd         # Testbench de la versión anterior
└── RISC-VCPU.xise          # Proyecto de Xilinx ISE
```

## Cómo compilar y simular

1. Abre `RISC-VCPU.xise` en Xilinx ISE 14.7. El *top* es `main.sch`.
2. **Síntesis:** ejecuta **Synthesize – XST**.
3. **Simulación:** selecciona la vista *Simulation*, elige `main` y en **Simulate Behavioral Model → Process Properties** activa *Use Custom Simulation Command File* con `sim_main.cmd`. El archivo genera el reloj, agrega `aluOutput` y los registros `x0`–`x31` en decimal con signo y corre la simulación.

> En Arch Linux, ISim puede fallar al enlazar con `cannot find -lgcc_s`. Se soluciona con
> `sudo ln -s /usr/lib/libgcc_s.so.1 /usr/lib/gcc/x86_64-pc-linux-gnu/4.9.4/libgcc_s.so`.

## Limitaciones y trabajo futuro

- Faltan `jal`, `jalr`, `lui` y `auipc`, así como las cargas y almacenamientos de byte y media palabra (`lb`, `lh`, `sb`, `sh`…); `lw`/`sw` no decodifican funct3.
- No hay entrada de *reset*: el PC empieza en 0 solo al encender.
- Por ahora se verifica en simulación; el proyecto no tiene archivo de restricciones (`.ucf`) para mostrar resultados en la tarjeta.
- Un siguiente paso natural es convertirlo en un procesador segmentado (*pipeline*), lo que requiere rediseñar el cálculo del siguiente PC.

## Autoría

El diseño, los esquemáticos y el código de este procesador son obra de **Esteban Santiago**. La documentación (este README) se redactó con ayuda de Claude (IA).
