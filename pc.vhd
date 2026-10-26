------------------------------------------------------------------
-- Contador de programa (PC)
-- Registro de 32 bits: al encender dout = 0 (primera direccion);
-- en cada flanco de subida de clk carga din (siguiente PC, add_mod)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc is
  port (
    clk  : in  std_logic;
    din  : in  std_logic_vector(31 downto 0);
    dout : out std_logic_vector(31 downto 0)
  );
end pc;

architecture rtl of pc is
  -- Valor inicial = 0 (XST lo usa como valor de encendido del registro)
  signal pc_reg : std_logic_vector(31 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      pc_reg <= din;
    end if;
  end process;

  dout <= pc_reg;
end rtl;
