brary IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity StateRegister is
  Port( clear,clock : in std_logic;
        lf : in std_logic;
        flags_in : std_logic_vector(3 downto 0); -- (3)OV (2)N (1)Z (0)C
        equal : out std_logic;
        notEqual : out std_logic;
        lessThan : out std_logic;
        lessEqual : out std_logic;
        greaterThan : out std_logic;
        greaterEqualThan : out std_logic);
end StateRegister;

architecture Behavioral of StateRegister is
  signal flags_out : std_logic_vector(3 downto 0);
begin
  process(clock,clear)
    begin
      if(clear='1') then
        flags_out <= (others => '0');
      elsif(FALLING_EDGE(clock)) then
        if(lf='1') then
          flags_out <= flags_in;
        end if;
      end if;
  end process;

  equal <= flags_out(1);  --EQ
  notEqual <= not flags_out(1); --NEQ
  lessThan <= (flags_out(2) xor flags_out(3)) and (not flags_out(1)); --LT
  lessEqual <= (flags_out(2) xor flags_out(3)) or flags_out(1); --LET
  greaterThan <= (not (flags_out(2) xor flags_out(3))) and (not flags_out(1)); --GT
  greaterEqualThan <= (not (flags_out(2) xor flags_out(3))) and (not flags_out(1)); --GET

end Behavioral;
