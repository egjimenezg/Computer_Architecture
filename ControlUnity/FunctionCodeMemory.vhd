library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FunctionCodeMemory is 
  generic(
    CODE_SIZE : integer := 4;
    INSTRUCTION_SIZE : integer := 20
  );
  Port(functionCode : in std_logic_vector(CODE_SIZE-1 downto 0);
       microinstruction : out std_logic_vector(INSTRUCTION_SIZE-1 downto 0));
end FunctionCodeMemory;

architecture Behavioral of FunctionCodeMemory is
  type rom is array (0 to (2**CODE_SIZE)-1) of std_logic_vector (INSTRUCTION_SIZE-1 downto 0);
  --TODO: Convert microinstructions to Hex format.
  constant memory : rom := ("00000000010000000000", --LI
                            "00000100010000001000", --LWI
                            "00000110010100110000", --LW
                            "00001000000000001100", --SWI
                            "00001010000100110010", --SW
                            "00000100010000110011", --ADD
                            "00000100010001110011", --SUB
                            "00000100010100110011", --ADDI
                            "00000100010101110011", --SUBI									 
                            "00000100010000000011", --AND
                            "00000100010000010011", --OR
                            "00000100010000100011", --XOR
                            "00000100010011010011", --NAND
                            "00000100010011000011", --NOR
                            "00000100010001100011", --XNOR
                            "00000100010011010011", --NOT									 
                            "00000110010100000011", --ANDI
                            "00000110010100010011", --ORI
                            "00000110010100100011", --XORI
                            "00000110010111010011", --NANDI
                            "00000110010111000011", --NORI
                            "00000110010110100011"); --XNORI
begin

end Behavioral;

