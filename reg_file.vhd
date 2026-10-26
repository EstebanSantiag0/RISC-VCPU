------------------------------------------------------------------
-- Banco de registros (2 lecturas combinacionales, 1 escritura sincrona)
-- Sin valores iniciales (todo en 0 al arrancar la simulacion)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_file is
  port (
    clk : in  std_logic;
    we  : in  std_logic;
    a1  : in  std_logic_vector(4 downto 0);
    a2  : in  std_logic_vector(4 downto 0);
    ad  : in  std_logic_vector(4 downto 0);
    di  : in  std_logic_vector(31 downto 0);
    do1 : out std_logic_vector(31 downto 0);
    do2 : out std_logic_vector(31 downto 0)
  );
end reg_file;

architecture rtl of reg_file is
  type reg_array is array (0 to 31) of std_logic_vector(31 downto 0);

  signal regs : reg_array := (others => (others => '0'));
begin
  -- escritura sincrona (x0 siempre es 0)
  process (clk)
  begin
    if rising_edge(clk) then
      if we = '1' and ad /= "00000" then
        regs(to_integer(unsigned(ad))) <= di;
      end if;
    end if;
  end process;

  -- lectura combinacional
  do1 <= regs(to_integer(unsigned(a1)));
  do2 <= regs(to_integer(unsigned(a2)));
end rtl;
