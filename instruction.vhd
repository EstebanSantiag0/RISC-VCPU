library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction is
	generic (N: integer := 32);
	port (
		inst	: in std_logic_vector(31 downto 0);
		func7 : out std_logic_vector(6 downto 0);
		rs2	: out std_logic_vector(4 downto 0);
		rs1	: out std_logic_vector(4 downto 0);
		func3	: out std_logic_vector(2 downto 0);
		rd		: out std_logic_vector(4 downto 0);
		opcode: out std_logic_vector(6 downto 0)
	);
	end instruction;
architecture rlt of instruction is
begin
	func7 <= inst(31 downto 25);
	rs2 <= inst(24 downto 20);
	rs1 <= inst(19 downto 15);
	func3 <= inst(14 downto 12);
	rd <= inst(11 downto 7);
	opcode <= inst(6 downto 0);
end rlt;