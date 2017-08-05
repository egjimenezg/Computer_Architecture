-- Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Divider is Port(
  clock_oscilator,clear : in std_logic;
  clock : inout std_logic
);
end Divider;

architecture Behavioral of Divider is
  signal counter : integer range 0 to 25000000;
begin
  process(clock_oscilator,clear)
  begin
    if(clear='1') then
      counter <= 0;
		clock <= '0';
	 elsif(RISING_EDGE(clock_oscilator)) then
      counter <= counter+1;
		if(counter = 0) then
        clock <= not clock;
      end if;
		
	 end if;
  end process;
end Behavioral;