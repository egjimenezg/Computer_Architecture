-- Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is Port(
  read_register1,read_register2 : in std_logic_vector(3 downto 0);   
  read_data1,read_data2 : out std_logic_vector (15 downto 0);
  write_register : in std_logic_vector (3 downto 0);
  write_data : in std_logic_vector(15 downto 0);
  clock,clear : in std_logic;
  shamt : in std_logic_vector (3 downto 0);
  wr,she,dir : in std_logic);
end RegisterFile;

architecture Behavioral of RegisterFile is
  type customArray is array(0 to 15) of std_logic_vector(15 downto 0);
  signal regs: customArray;
begin
  process(clock,clear)
    begin

  
  end process;
end Behavioral;

