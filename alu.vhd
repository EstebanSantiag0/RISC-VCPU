------------------------------------------------------------------
-- ALU (codigos segun la tabla del esquema)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  port (
    a      : in  std_logic_vector(31 downto 0);
    b      : in  std_logic_vector(31 downto 0);
    alu_op : in  std_logic_vector(3 downto 0);
    y      : out std_logic_vector(31 downto 0)
  );
end alu;

architecture rtl of alu is
begin
  process (a, b, alu_op)
    variable sh : natural range 0 to 31;
  begin
    sh := to_integer(unsigned(b(4 downto 0)));
    case alu_op is
      when "0000" => y <= std_logic_vector(signed(a) + signed(b));             -- suma
      when "0001" => y <= std_logic_vector(signed(a) - signed(b));             -- resta
      when "0010" => y <= std_logic_vector(shift_left(unsigned(a), sh));       -- sll
      when "0100" =>                                                           -- slt
        if signed(a) < signed(b) then
          y <= x"00000001";
        else
          y <= x"00000000";
        end if;
      when "0110" =>                                                           -- sltu
        if unsigned(a) < unsigned(b) then
          y <= x"00000001";
        else
          y <= x"00000000";
        end if;
      when "1000" => y <= a xor b;                                             -- xor
      when "1010" => y <= std_logic_vector(shift_right(unsigned(a), sh));      -- srl
      when "1011" => y <= std_logic_vector(shift_right(signed(a), sh));        -- sra
      when "1100" => y <= a or b;                                              -- or
      when "1110" => y <= a and b;                                             -- and
      when "1111" =>                                                           -- seq (beq/bne)
        if a = b then
          y <= x"00000001";
        else
          y <= x"00000000";
        end if;
      when others => y <= x"00000000";
    end case;
  end process;
end rtl;
