------------------------------------------------------------------
-- Datapath completo (top)
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity datapath is
  port (
    clk   : in  std_logic;
    instr : in  std_logic_vector(31 downto 0)   -- codigo de instruccion
  );
end datapath;

architecture struct of datapath is
  signal wer, wem, alu_src, alu2reg, imm_rd : std_logic;
  signal alu_op      : std_logic_vector(3 downto 0);

  signal do1, do2    : std_logic_vector(31 downto 0);
  signal alu_b       : std_logic_vector(31 downto 0);
  signal alu_y       : std_logic_vector(31 downto 0);
  signal mem_do      : std_logic_vector(31 downto 0);
  signal wb_data     : std_logic_vector(31 downto 0);
  signal imm_ext     : std_logic_vector(31 downto 0);

  signal imm_lo_sel  : std_logic_vector(4 downto 0);
  signal imm12       : std_logic_vector(11 downto 0);
begin
  -- Unidad de control
  cu : entity work.control_unit
    port map (
      opcode  => instr(6 downto 0),
      funct3  => instr(14 downto 12),
      funct7  => instr(31 downto 25),
      wer     => wer,
      wem     => wem,
      alu_src => alu_src,
      alu2reg => alu2reg,
      imm_rd  => imm_rd,
      alu_op  => alu_op
    );

  -- Mux 5 bits: imm(4:0) = rs2 (I/L) o rd (S)
  mux_imm : entity work.mux2
    generic map (N => 5)
    port map (
      sel => imm_rd,
      d0  => instr(24 downto 20),
      d1  => instr(11 downto 7),
      y   => imm_lo_sel
    );

  imm12 <= instr(31 downto 25) & imm_lo_sel;

  se : entity work.sign_extend
    port map (imm => imm12, y => imm_ext);

  -- Banco de registros
  rf : entity work.reg_file
    port map (
      clk => clk,
      we  => wer,
      a1  => instr(19 downto 15),   -- rs1
      a2  => instr(24 downto 20),   -- rs2
      ad  => instr(11 downto 7),    -- rd
      di  => wb_data,
      do1 => do1,
      do2 => do2
    );

  -- Mux de la entrada B de la ALU
  mux_alu : entity work.mux2
    generic map (N => 32)
    port map (sel => alu_src, d0 => do2, d1 => imm_ext, y => alu_b);

  -- ALU
  alu_i : entity work.alu
    port map (a => do1, b => alu_b, alu_op => alu_op, y => alu_y);

  -- Memoria de datos
  dm : entity work.data_mem
    port map (
      clk => clk,
      we  => wem,
      a   => alu_y,
      di  => do2,
      do  => mem_do
    );

  -- Mux de escritura al banco de registros
  mux_wb : entity work.mux2
    generic map (N => 32)
    port map (sel => alu2reg, d0 => mem_do, d1 => alu_y, y => wb_data);
end struct;
