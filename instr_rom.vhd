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
    0      => x"00500513",  -- 0x00 addi x10 x0 5     n = 5
    1      => x"00100593",  -- 0x04 addi x11 x0 1     constante 1
    2      => x"02b50263",  -- 0x08 beq x10 x11 36    loop: n = 1 -> fin (0x2C)
    3      => x"00157313",  -- 0x0C andi x6 x10 1     x6 = n impar?
    4      => x"00030a63",  -- 0x10 beq x6 x0 20      par -> 0x24
    5      => x"00a502b3",  -- 0x14 add x5 x10 x10    x5 = 2n
    6      => x"00550533",  -- 0x18 add x10 x10 x5    n = 3n
    7      => x"00b50533",  -- 0x1C add x10 x10 x11   n = 3n + 1
    8      => x"fe0004e3",  -- 0x20 beq x0 x0 -24     -> loop (0x08)
    9      => x"00b55533",  -- 0x24 srl x10 x10 x11   n = n / 2
    10     => x"fe0000e3",  -- 0x28 beq x0 x0 -32     -> loop (0x08)
    11     => x"00000063",  -- 0x2C beq x0 x0 0       fin: se queda aqui
    others => NOP
  );

  signal idx : integer range 0 to 63;
begin
  idx <= to_integer(unsigned(addr(7 downto 2)));

  dout <= ROM(idx);
end rtl;
