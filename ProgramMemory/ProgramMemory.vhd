-- Author: Gamaliel Jiménez

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ProgramMemory is
  generic(
    D : integer := 12;
    P	: integer := 25
  );
  Port(
    dir_bus : in std_logic_vector (D-1 downto 0);
    data_out : out std_logic_vector (P-1 downto 0)
  );
end ProgramMemory;

architecture Behavioral of ProgramMemory is
  type customArray is array(0 to (2**D)-1) of std_logic_vector(P-1 downto 0);
  constant memory : customArray := (x"080002"&'1',x"088005"&'0',x"008800"&'0',x"188002"&'1',x"980001"&'0', others => x"000000"&'0');
begin
  process(dir_bus)
  begin
    data_out <= memory(conv_integer(dir_bus));
  end process;
end Behavioral;

