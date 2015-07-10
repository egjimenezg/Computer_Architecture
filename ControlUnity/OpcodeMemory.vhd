library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OpcodeMemory is
  generic(
    OPCODE_SIZE : integer := 5;
	 INSTRUCTION_SIZE : integer := 20);
  Port(code : in std_logic_vector(OPCODE_SIZE-1 downto 0);
       instruction : out std_logic_vector(INSTRUCTION_SIZE-1 downto 0));
end OpcodeMemory;

architecture Behavioral of OpcodeMemory is
  type rom is array (0 to ((2**OPCODE_SIZE)-1)) of std_logic_vector(INSTRUCTION_SIZE-1 downto 0);
  constant memory : rom := ("00000000010000000000", --LI
									 "00000100010000001000", --LWI
									 "00000110010100110000", --LW
									 "00001000000000001100", --SWI
									 "00001010000100110010", --SW
									 "00000100010100110011", --ADDI
									 "00000100010101110011", --SUBI
									 "00000110010100000011", --ANDI
									 "00000110010100010011", --ORI
									 "00000110010100100011", --XORI
									 "00000110010111010011", --NANDI
									 "00000110010111000011", --NORI
									 "00000110010110100011", --XNORI									 
									 others => (others => '0'));
begin

end Behavioral;
