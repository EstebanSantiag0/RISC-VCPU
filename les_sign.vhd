------------------------------------------------------------------
-- Bit de comparacion de la ALU
-- less_s = bit 0 del resultado (seq / slt / sltu) -> add_mod.aluls
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity less_sign is
  port (
    idata  : in  std_logic_vector(31 downto 0);
    less_s : out std_logic
  );
end less_sign;

architecture rtl of less_sign is
begin
  less_s <= idata(0);
end rtl;
