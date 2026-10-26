library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity joiner12 is
	generic (N: integer := 12);
	port(
		in7	: in std_logic_vector(6 downto 0);
		in5	: in std_logic_vector(4 downto 0);
		o		: out std_logic_vector(11 downto 0)
	);
	end joiner12;
architecture rtl of joiner12 is
begin
	o(11 downto 5) <=in7;
	o(4 downto 0) <= in5;
end rtl;