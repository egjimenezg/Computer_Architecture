--Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is Port(
  clock,clear : in STD_LOGIC;
  data: in STD_LOGIC_VECTOR(3 downto 0);
  counter : inout STD_LOGIC_VECTOR(3 downto 0);
  lb,eb : in STD_LOGIC
);
end Counter;

architecture Behavioral of Counter is
begin
  process(clock,clear) 
  begin
    if(clear='1') then
      counter <= "0000";
    elsif rising_edge(clock) then
      if(lb='1' and eb='0') then
        counter <= data;
      elsif(lb='0' and eb='1') then
        counter <=  counter + 1;
      end if;
    end if;
  end process;
end Behavioral;

