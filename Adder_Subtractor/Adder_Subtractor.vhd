-- Module Name:    Adder_Subtractor - Behavioral 
-- Author: Gamaliel Jiménez

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_Subtractor is
  port(inputA,inputB : in std_logic_vector(3 downto 0);
       sum: out std_logic_vector(3 downto 0);
       option : in std_logic;
       cout: out std_logic);
end Adder_Subtractor;

architecture Behavioral of Adder_Subtractor is
  signal inputWithOption:std_logic_vector(4 downto 0);
  signal c:std_logic_vector(4 downto 0);
begin  
  c(0) <= option;
  cycle:
    for i in 0 to 3 generate
      inputWithOption(i) <= (inputB(i) xor option);
      sum(i) <= (inputWithOption(i) xor (inputA(i))) xor c(i);
      c(i+1) <= (inputA(i) and inputWithOption(i)) or ((inputA(i) xor inputWithOption(i)) and c(i));
    end generate cycle;
  cout <= c(4);
end Behavioral;

