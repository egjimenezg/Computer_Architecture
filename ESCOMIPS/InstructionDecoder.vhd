library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity InstructionDecoder is
  generic( OPCODE_SIZE : integer := 5);
  Port( opcode : in std_logic_vector(OPCODE_SIZE-1 downto 0); 
        rType : out std_logic;
        bEqual : out std_logic;
        bNotEqual : out std_logic;
        bLessThan : out std_logic;
        bLessEqual : out std_logic;
        bGreaterThan : out std_logic;
        bGreaterEqualThan : out std_logic);
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is
begin
  rType <= '1' when(opcode="00000") else '0';
  bEqual <= '1' when(opcode="01101") else '0';
  bNotEqual <= '1' when (opcode="01110") else '0';
  bLessThan <= '1' when (opcode="01111") else '0';
  bLessEqual <= '1' when (opcode="10000") else '0';
  bGreaterThan <= '1' when (opcode="10001") else '0';
  bGreaterEqualThan <= '1' when (opcode="10010") else '0';
end Behavioral;