library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity OpcodeMemory is
  generic(
    OPCODE_SIZE : integer := 5;
    INSTRUCTION_SIZE : integer := 20);
  Port(code : in std_logic_vector(OPCODE_SIZE-1 downto 0);
       instruction : out std_logic_vector(INSTRUCTION_SIZE-1 downto 0));
end OpcodeMemory;

architecture Behavioral of OpcodeMemory is
  type rom is array (0 to ((2**OPCODE_SIZE)-1)) of std_logic_vector(INSTRUCTION_SIZE-1 downto 0);
  -- MICROINSTRUCTION
  -- SDMP UP DW WPC SR2 SWD SEXT SHE DIR WR SOP1 SOP2 ALU[3] ALU[2] ALU[1] ALU[0] SDMD WD SR LF
  constant memory : rom := ("00001000000001110001", --COMPARISON
                            "00000000010000000000", --LI
                            "00000100010000001000", --LWI
                            "00001000000000001100", --SWI
                            "00001010000100110100", --SW
                            "00000100010100110011", --ADDI									 
                            "00000100010101110011", --SUBI									 
                            "00000110010100000011", --ANDI
                            "00000110010100010011", --ORI									 
                            "00000110010100100011", --XORI
                            "00000110010111010011", --NANDI
                            "00000110010111000011", --NORI
                            "00000110010110100011", --XNORI
                            "10010000001100110010", --BEQI									 
                            "10010000001100000010", --BNEI
                            "10010000001100000010", --BLTI
                            "10010000001100000010", --BLETI
                            "10010000001100000010", --BGTI
                            "10010000001100000010", --BGETI
                            "00010000000000000000", --B
                            "01010000000000000000", --CALL
                            "00100000000000000000", --RET
                            "00000000000000000000", --NOP
                            "00000110010100110000", --LW									 
                            others => (others => '0'));
begin
  instruction <= memory(conv_integer(code));
end Behavioral;