library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Level is
  Port(clock,clear : in std_logic;
       na : out std_logic);
end Level;

architecture Behavioral of Level is
  signal high : std_logic;
  signal low  : std_logic := '0';
begin
  high_edge:process(clock,clear)
  begin
    if(clear='1') then
      high <= '0';
    elsif(RISING_EDGE(clock)) then
      high <= not(high);
    end if;
  end process high_edge;

  low_edge:process(clock,clear)
  begin
    if(clear='1') then
      low <= '0';
    elsif(FALLING_EDGE(clock)) then
      low <= not(low);
    end if;
  end process low_edge;

  na <= high xor low;
end Behavioral;
