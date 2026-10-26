library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------
-- MUX 2:1 generico
------------------------------------------------------------------
entity mux25 is
  generic (N : integer := 5);
  port (
    sel : in  std_logic;
    d0  : in  std_logic_vector(N-1 downto 0);
    d1  : in  std_logic_vector(N-1 downto 0);
    y   : out std_logic_vector(N-1 downto 0)
  );
end mux25;

architecture rtl of mux25 is
begin
  y <= d0 when sel = '0' else d1;
end rtl;
