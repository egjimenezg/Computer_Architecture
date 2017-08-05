library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
  -- MICROINSTRUCTION FORMAT
  -- SDMP UP DW WPC SR2 SWD SEXT SHE DIR WR SOP1 SOP2 ALU[3] ALU[2] ALU[1] ALU[0] SDMD WD SR LF
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
                            "00000001100000000000", --SLL
                            "00000001000000000000", --SLR
                            others => (others => '0'));
begin
  microinstruction <= memory(conv_integer(functionCode));
end Behavioral;

