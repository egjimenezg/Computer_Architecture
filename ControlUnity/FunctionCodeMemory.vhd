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
  constant memory : rom := ("00000100010000110011", --ADD
                            "00000100010001110011", --SUB
                            "00000100010000000011", --AND
                            "00000100010000010011", --OR
                            "00000100010000100011", --XOR
                            "00000100010011010011", --NAND
                            "00000100010011000011", --NOR
                            "00000100010001100011", --XNOR
                            "00000100010011010011", --NOT 
                            others => (others => '0'));
                            
begin

end Behavioral;

