-- Author: Gamaliel Jiménez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity DataMemory is
  generic(
    N: integer := 11;
    M: integer := 16
  );
  Port( dir_w : in std_logic_vector(N-1 downto 0);
        dir_r : in std_logic_vector(N-1 downto 0);
        data_in : in std_logic_vector(M-1 downto 0);
        data_out : out std_logic_vector(M-1 downto 0) := X"0000";
        clock : in std_logic;
        wr: in std_logic);
end DataMemory;

architecture Behavioral of DataMemory is
  type memory is array (0 to (2**N)-1) of std_logic_vector(M-1 downto 0);
  signal RAM : memory := (others => (others => '0'));
begin
  process(wr,dir_r,clock,RAM)
    data_out <= RAM(conv_integer(dir_r));
  begin
    if(wr = '1') then
      if(rising_edge(clock)) then
        RAM(conv_integer(dir_w)) <= data_in;
      end if;
    end if;
  end process;
end Behavioral;