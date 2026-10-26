------------------------------------------------------------------
-- Extension de signo 12 -> 32
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
  port (
    imm : in  std_logic_vector(11 downto 0);
    y   : out std_logic_vector(31 downto 0)
  );
end sign_extend;

architecture rtl of sign_extend is
begin
  y <= std_logic_vector(resize(signed(imm), 32));
end rtl;
