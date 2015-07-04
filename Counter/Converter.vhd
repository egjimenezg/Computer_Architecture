-- Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Converter is Port(
  binaryNumber : in std_logic_vector(3 downto 0);
  convertedNumber : out std_logic_vector(6 downto 0)
);
end Converter;

architecture Behavioral of Converter is

begin
  process(binaryNumber)
  begin
    case binaryNumber is
      when "0000" => convertedNumber <= "0000001";
      when "0001" => convertedNumber <= "1001111";
      when "0010" => convertedNumber <= "0010010";
      when "0011" => convertedNumber <= "0000110";
      when "0100" => convertedNumber <= "1001100";
      when "0101" => convertedNumber <= "0100100";
      when "0110" => convertedNumber <= "0100000";
      when "0111" => convertedNumber <= "0001111";
      when "1000" => convertedNumber <= "0000000";
      when others => convertedNumber <= "0001100";
    end case;
  end process;
  
end Behavioral;