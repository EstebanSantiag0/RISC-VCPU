------------------------------------------------------------------
-- Testbench
-- Programa (los registros y la memoria arrancan en 0):
--   addi x19,x0,5     -> x19 = 5
--   addi x20,x0,4     -> x20 = 4
--   addi x21,x0,2     -> x21 = 2
--   add  x1,x19,x20   -> x1  = 9
--   sub  x2,x19,x21   -> x2  = 3
--   addi x3,x0,12     -> x3  = 12
--   sw   x2,0(x3)     -> MEM[12] = 3
--   lw   x4,0(x3)     -> x4  = 3
--   sw   x1,16(x0)    -> MEM[16] = 9
--   lw   x5,16(x0)    -> x5  = 9
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity tb_datapath is
end tb_datapath;

architecture sim of tb_datapath is
  signal clk   : std_logic := '0';
  signal instr : std_logic_vector(31 downto 0) := (others => '0');

  type prog_t is array (0 to 9) of std_logic_vector(31 downto 0);
  constant PROG : prog_t := (
    x"00500993",  -- addi x19,x0,5
    x"00400A13",  -- addi x20,x0,4
    x"00200A93",  -- addi x21,x0,2
    x"014980B3",  -- add  x1,x19,x20
    x"41598133",  -- sub  x2,x19,x21
    x"00C00193",  -- addi x3,x0,12
    x"0021A023",  -- sw   x2,0(x3)
    x"0001A203",  -- lw   x4,0(x3)
    x"00102823",  -- sw   x1,16(x0)
    x"01002283"   -- lw   x5,16(x0)
  );
begin
  clk <= not clk after 5 ns;

  uut : entity work.datapath
    port map (clk => clk, instr => instr);

  process
  begin
    when falling_edge(clk);
		for i in PROG'range loop
			instr <= PROG(i);
			wait until falling_edge(clk);   -- pasa un flanco de subida: escribe RF/DM
		end loop;
    instr <= (others => '0');
    report "Fin de la simulacion" severity failure;
  end process;
end sim;
