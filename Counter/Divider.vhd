-- Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Divider is Port(
  clock_oscilator,clear : in std_logic;
  clock : out std_logic
);
end Divider;

architecture Behavioral of Divider is
  signal counter : std_logic_vector(25 downto 0);
begin
  process(clock_oscilator,clear)
  begin
    if(clear='1') then
      counter <= (others => '0');
    elsif(rising_edge(clock_oscilator)) then
      counter <= counter+1;
      clock <= counter(0);
    end if;
  end process;
end Behavioral;
