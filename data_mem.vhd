------------------------------------------------------------------
-- Memoria de datos: 1 Kbit (1024 bits = 32 palabras de 32 bits)
-- Entrada y salida de 32 bits; direcciones de byte alineadas (0, 4, 8, ...)
-- a(6 downto 2) = indice de palabra
-- Rango valido: 0x00 - 0x7C. Fuera de rango o desalineada:
--   no se escribe y la lectura devuelve 0 (sin repeticion cada 128 bytes)
-- Sin valores iniciales (todo en 0 al arrancar la simulacion)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_mem is
  port (
    clk : in  std_logic;
    we  : in  std_logic;
    a   : in  std_logic_vector(31 downto 0);
    di  : in  std_logic_vector(31 downto 0);
    do  : out std_logic_vector(31 downto 0)
  );
end data_mem;

architecture rtl of data_mem is
  type mem_array is array (0 to 31) of std_logic_vector(31 downto 0);

  signal mem   : mem_array := (others => (others => '0'));
  signal idx   : integer range 0 to 31;
  signal valid : std_logic;
begin
  idx <= to_integer(unsigned(a(6 downto 2)));  -- indice de palabra (32 palabras)

  -- direccion dentro de los 128 bytes y alineada a palabra
  valid <= '1' when unsigned(a(31 downto 7)) = 0 and a(1 downto 0) = "00" else '0';

  process (clk)
  begin
    if rising_edge(clk) then
      if we = '1' and valid = '1' then
        mem(idx) <= di;
      end if;
    end if;
  end process;

  do <= mem(idx) when valid = '1' else (others => '0');
end rtl;
