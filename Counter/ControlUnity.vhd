-- Author: Gamaliel Jimenez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.control_package.all;

entity ControlUnity is Port(
  clock,clear : in std_logic;
  data : in std_logic_vector(7 downto 0);
  start : in std_logic;
  display : out std_logic_vector(6 downto 0);
  output : out std_logic_vector(7 downto 0)
);
end ControlUnity;

architecture Behavioral of ControlUnity is
  signal la,ea,eb,lb,ec,z,clk : STD_LOGIC;
  signal auxCounter : std_logic_vector(3 downto 0);
  signal auxInput : std_logic_vector(7 downto 0);
  signal auxDisplay : std_logic_vector(6 downto 0);
begin
  ushift:Shift PORT MAP(
    clock=>clk,
    ea => ea,
    la => la,
    data => data,
    displacement => auxInput
  );

  udivider:Divider PORT MAP(
    clock_oscilator => clock,
    clear => clear,
    clock => clk
  );

  uasm:ASM PORT MAP(
    clock => clk,
    clear => clear,
    start => start,
    la => la,
    lb => lb,
    ea => ea,
    eb => eb,
    ec => ec,
    a0 => auxInput(0),
    z => z);

  ucounter:Counter PORT MAP(
    clear => clear,
    clock => clk,
    eb => eb,
    lb => lb,
    data => auxCounter,
    counter => auxCounter);
  
  uconverter:Converter PORT MAP(
    binaryNumber => auxCounter,
    convertedNumber => auxDisplay);

  with ec select display <= auxDisplay when '1',
                            "0000001" when others;

  z<=not(auxInput(0) or auxInput(1) or auxInput(2) or auxInput(3) or auxInput(4) or auxInput(5) or auxInput(6) or auxInput(7)); 
  output<=auxInput;
  
end Behavioral;