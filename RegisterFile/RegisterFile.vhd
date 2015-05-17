-- Author: Gamaliel Jim�nez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
      if(clear='1') then
        for i in 0 to 15 loop
          regs(i) <= X"0000";
        end loop;
      elsif(clock'event and clock='1') then
        if(wr='1' and she='0') then
          regs(conv_integer(write_register)) <= write_data;
      elsif(wr='0' and she='1') then
        if(dir='1') then
          regs(conv_integer(write_register)) <= to_stdlogicvector(to_bitvector(regs(conv_integer(read_register1))) sll conv_integer(shamt));
        else
          regs(conv_integer(write_register)) <= to_stdlogicvector(to_bitvector(regs(conv_integer(read_register1))) srl conv_integer(shamt)); 
        end if;
      end if;
    end if;
  end process;
end Behavioral;