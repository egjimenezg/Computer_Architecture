library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity Shift is Port( 
  clock : in STD_LOGIC;
  la : in STD_LOGIC;
  ea : in STD_LOGIC;
  data : in STD_LOGIC_VECTOR(7 downto 0);
  displacement : inout STD_LOGIC_VECTOR(7 downto 0)
);
end Shift;

architecture Behavioral of Shift is

begin
  process(clock)
  begin
    if(rising_edge(clock)) then
      if(la='1' and ea='0') then
        displacement <= data;
      elsif(la='0' and ea='1') then
        displacement <= to_stdlogicvector(to_bitvector(displacement) srl (1));
      end if;
    end if;
  end process;
end Behavioral;