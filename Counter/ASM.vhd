--Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ASM is Port(
  clock,clear : in std_logic;
  start : in std_logic;
  la,lb : out std_logic;
  ea,eb,ec : out std_logic;
  a0 : in std_logic;
  z : in std_logic
);
end ASM;

architecture Behavioral of ASM is
  type states is (E0,E1,E2);
  signal currentState,nextState : states;
begin
  process(clock,clear)
  begin
    if(clear='1') then
      currentState <= E0;
    elsif(rising_edge(clock)) then
      currentState <= nextState;
    end if;
  end process;

  process(currentState,z,a0,start)
  begin
    la <= '0';
    lb <= '0';
    ea <= '0';
    eb <= '0';
    ec <= '0';

    case currentState is
      when E0 =>
        lb <= '1';
        if start = '1' then
          nextState <= E1;
        else
          la <= '1';
          nextState <= E0;
        end if;
      
      when E1 =>
        ea <= '1';
        if z = '1' then
          nextState <= E2;
        else
          if(a0 = '1') then
            eb <= '1';
          end if;
          nextState <= E1;
        end if;

      when E2 =>
        ec <= '1';
        if(start = '1') then
          nextState <= E2;
        else
          nextState <= E0;			 
        end if;
    end case;
  end process;
end Behavioral;