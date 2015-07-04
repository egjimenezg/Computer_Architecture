library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
-- Author: Gamaliel Jiménez

entity Stack is
  generic(
    REGISTER_SIZE : integer := 16;
    STACK_SIZE : integer := 16
  );
  Port(data: in STD_LOGIC_VECTOR(REGISTER_SIZE-1 downto 0);
       q: out STD_LOGIC_VECTOR(REGISTER_SIZE-1 downto 0);
       up,down: in STD_LOGIC;
       sp : out std_logic_vector(3 downto 0);
       clock, clear, wpc : in STD_LOGIC);
end Stack;

architecture Behavioral of Stack is
  type stack_matrix is array(0 to STACK_SIZE) of std_logic_vector(REGISTER_SIZE-1 downto 0);
begin
  process(clock,clear)
    variable registers : stack_matrix;
    variable stackPointer : std_logic_vector(3 downto 0);
  begin    
    if(clear='1') then
      stackPointer := "0000";
      sp <= stackPointer;
      for i in 0 to STACK_SIZE loop
        registers(i) := X"0000";
      end loop;
    elsif(rising_edge(clock)) then  
      if(wpc='1' and up='0' and down='0') then
        registers(conv_integer(stackPointer)) := data;
      elsif(wpc='1' and up='1' and down='0') then
        registers(conv_integer(stackPointer)) := registers(conv_integer(stackPointer))+1;
        stackPointer := stackPointer+1;
        registers(conv_integer(stackPointer)) := data;
      elsif(wpc='0' and up='0' and down='1') then
        stackPointer := stackPointer-1;		  
      else
        registers(conv_integer(stackPointer)) := registers(conv_integer(stackPointer))+1;
      end if;
      
      sp <= stackPointer;
    end if;
    q <= registers(conv_integer(stackPointer));
  end process;
end Behavioral;