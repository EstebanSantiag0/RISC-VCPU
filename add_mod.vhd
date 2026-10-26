------------------------------------------------------------------
-- Sumador del siguiente PC
-- aout = ain + 4            (no hay salto)
-- aout = ain + imm_b        (salto tomado: branch and (aluls xor bneg))
-- aluls = bit 0 del resultado de la ALU (comparacion)
-- imm_b = inmediato tipo B (13 bits con signo, bit 0 = 0):
--   imm[12]   = func7(6)   (instr(31))
--   imm[10:5] = func7(5:0) (instr(30:25))
--   imm[4:1]  = rd(4:1)    (instr(11:8))
--   imm[11]   = rd(0)      (instr(7))
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add_mod is
  port (
    func7  : in  std_logic_vector(6 downto 0);
    rd     : in  std_logic_vector(4 downto 0);
    branch : in  std_logic;
    bneg   : in  std_logic;
    aluls  : in  std_logic;
    ain    : in  std_logic_vector(31 downto 0);
    aout   : out std_logic_vector(31 downto 0)
  );
end add_mod;

architecture rtl of add_mod is
  signal imm_b : std_logic_vector(12 downto 0);
  signal taken : std_logic;
  signal ofs   : signed(31 downto 0);
begin
  imm_b <= func7(6) & rd(0) & func7(5 downto 0) & rd(4 downto 1) & '0';

  taken <= branch and (aluls xor bneg);

  ofs <= resize(signed(imm_b), 32) when taken = '1' else
         to_signed(4, 32);

  aout <= std_logic_vector(signed(ain) + ofs);
end rtl;
