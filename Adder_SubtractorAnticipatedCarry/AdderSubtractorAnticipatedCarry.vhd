-- Author: Gamaliel Jiménez 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AdderSubtractorAnticipatedCarry is
  port(inputA,inputB: in std_logic_vector(3 downto 0);
		 option: in std_logic;
		 sum_subtraction: out std_logic_vector(3 downto 0);
		 cout: out std_logic);
end AdderSubtractorAnticipatedCarry;

architecture Behavioral of AdderSubtractorAnticipatedCarry is
  signal p,g,inputWithOptions:std_logic_vector(3 downto 0);
  signal c:std_logic_vector(4 downto 0);
begin
  c(0) <= option;

  cycle:
    for i in 0 to 3 generate
      inputWithOptions(i) <= inputB(i) xor option;
      p(i) <= inputA(i) xor inputWithOptions(i);
		g(i) <= inputA(i) and inputWithOptions(i);
      sum_subtraction(i) <= p(i) xor c(i);
      c(i+1) <= g(i) or (p(i) and c(i));
  end generate cycle;
  
  cout <= c(4);

end Behavioral;

