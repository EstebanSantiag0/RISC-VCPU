------------------------------------------------------------------
-- Unidad de control
-- alu_src : 0 = do2,     1 = inmediato
-- alu2reg : 0 = memoria, 1 = resultado ALU
-- imm_rd  : 0 = instr[24:20] (tipo I/L), 1 = instr[11:7] (tipo S)
-- branch  : 1 = instruccion tipo B. La ALU compara rs1 y rs2:
--   beq/bne   -> seq  (y = 1 si rs1 =  rs2)
--   blt/bge   -> slt  (y = 1 si rs1 <  rs2)
--   bltu/bgeu -> sltu (y = 1 si rs1 <  rs2 sin signo)
-- bneg    : 1 = salto con condicion negada (bne, bge, bgeu)
--   salto tomado = branch and (y(0) xor bneg)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
  port (
    opcode  : in  std_logic_vector(6 downto 0);
    funct3  : in  std_logic_vector(2 downto 0);
    funct7  : in  std_logic_vector(6 downto 0);
    wer     : out std_logic;
    wem     : out std_logic;
    alu_src : out std_logic;
    alu2reg : out std_logic;
    imm_rd  : out std_logic;
    alu_op  : out std_logic_vector(3 downto 0);
    branch  : out std_logic;
    bneg    : out std_logic
  );
end control_unit;

architecture rtl of control_unit is
  constant OP_R : std_logic_vector(6 downto 0) := "0110011";
  constant OP_I : std_logic_vector(6 downto 0) := "0010011";
  constant OP_L : std_logic_vector(6 downto 0) := "0000011";
  constant OP_S : std_logic_vector(6 downto 0) := "0100011";
  constant OP_B : std_logic_vector(6 downto 0) := "1100011";

  constant ALU_SEQ  : std_logic_vector(3 downto 0) := "1111";
  constant ALU_SLT  : std_logic_vector(3 downto 0) := "0100";
  constant ALU_SLTU : std_logic_vector(3 downto 0) := "0110";
begin
  process (opcode, funct3, funct7)
  begin
    -- valores por defecto
    wer     <= '0';
    wem     <= '0';
    alu_src <= '0';
    alu2reg <= '1';
    imm_rd  <= '0';
    alu_op  <= "0000";
    branch  <= '0';
    bneg    <= '0';

    case opcode is
      when OP_R =>
        wer     <= '1';
        alu_src <= '0';
        -- funct3 & bit de resta/aritmetico (funct7(5))
        if funct3 = "000" or funct3 = "101" then
          alu_op <= funct3 & '0';
          alu_op(0) <= funct7(5);
        else
          alu_op <= funct3 & '0';
        end if;

      when OP_I =>
        wer     <= '1';
        alu_src <= '1';
        if funct3 = "101" then              -- srli / srai
          alu_op <= funct3 & '0';
          alu_op(0) <= funct7(5);
        else                                -- addi, slti, xori, ori, andi, slli...
          alu_op <= funct3 & '0';
        end if;

      when OP_L =>
        wer     <= '1';
        alu_src <= '1';
        alu2reg <= '0';
        alu_op  <= "0000";                  -- direccion = rs1 + imm

      when OP_S =>
        wem     <= '1';
        alu_src <= '1';
        imm_rd  <= '1';
        alu_op  <= "0000";                  -- direccion = rs1 + imm

      when OP_B =>
        alu_src <= '0';                     -- compara rs1 con rs2
        case funct3 is
          when "000" | "001" =>             -- beq / bne
            branch <= '1';
            alu_op <= ALU_SEQ;
            bneg   <= funct3(0);
          when "100" | "101" =>             -- blt / bge
            branch <= '1';
            alu_op <= ALU_SLT;
            bneg   <= funct3(0);
          when "110" | "111" =>             -- bltu / bgeu
            branch <= '1';
            alu_op <= ALU_SLTU;
            bneg   <= funct3(0);
          when others =>                    -- funct3 invalido
            null;
        end case;

      when others =>
        null;
    end case;
  end process;
end rtl;
