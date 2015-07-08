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
  type instruction is array (0 to (2**CODE_SIZE)-1) of std_logic_vector (INSTRUCTION_SIZE-1 downto 0);
begin

end Behavioral;

