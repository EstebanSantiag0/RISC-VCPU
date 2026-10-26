------------------------------------------------------------------
-- Memoria de instrucciones (ROM): 64 palabras de 32 bits
-- addr = direccion de byte (PC), alineada a palabra (0, 4, 8, ...)
-- addr(7 downto 2) = indice de palabra
-- Lectura asincrona: dout = ROM(addr) en el mismo ciclo, para que la
-- instruccion en PC se ejecute en ese ciclo (CPU de un solo ciclo).
-- XST la infiere como ROM distribuida (LUTs). clk no se usa; se deja
-- para no cambiar el simbolo del esquema.
-- Posiciones no definidas = nop (addi x0,x0,0)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instr_rom is
  port (
    clk  : in  std_logic;
    addr : in  std_logic_vector(31 downto 0);
    dout : out std_logic_vector(31 downto 0)
  );
end instr_rom;

architecture rtl of instr_rom is
  type rom_array is array (0 to 63) of std_logic_vector(31 downto 0);

  constant NOP : std_logic_vector(31 downto 0) := x"00000013";

  constant ROM : rom_array := (
    0      => x"00000513",  -- 0x00 addi x10 x0 0
    1      => x"00100593",  -- 0x04 addi x11 x0 1
    2      => x"1f400293",  -- 0x08 addi x5 x0 500
    3      => x"00100313",  -- 0x0C addi x6 x0 1
    4      => x"00b50633",  -- 0x10 add x12 x10 x11
    5      => x"00565863",  -- 0x14 bge x12 x5 16
    6      => x"00b00533",  -- 0x18 add x10 x0 x11
    7      => x"00c005b3",  -- 0x1C add x11 x0 x12
    8      => x"fe0008e3",  -- 0x20 beq x0 x0 -16
    9      => x"00000063",  -- 0x24 beq x0 x0 0
    others => NOP
  );

  signal idx : integer range 0 to 63;
begin
  idx <= to_integer(unsigned(addr(7 downto 2)));

  dout <= ROM(idx);
end rtl;
