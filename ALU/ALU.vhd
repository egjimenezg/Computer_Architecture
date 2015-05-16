-- Author: Edueardo Gamaliel Jiménez García
-- Create Date:    05/03/2015 
-- Module Name:    ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is port(
  inputA,inputB: in std_logic_vector(3 downto 0);
  aluOptions: in std_logic_vector(3 downto 0);
  flags: out std_logic_vector(3 downto 0);
  data: inout std_logic_vector(3 downto 0));
end ALU;

architecture Behavioral of ALU is
  
begin
  ALU:process(inputA,inputB,aluOptions,data) 
    variable p,g:std_logic_vector(3 downto 0);
    variable carry:std_logic_vector(4 downto 0);
    variable muxa,muxb:std_logic_vector(3 downto 0);
  begin
    carry := (others=>'0');
    carry(0) := aluOptions(2);
	  
    for i in 0 to 3 loop
      muxa(i) := inputA(i) xor aluOptions(3); 
      muxb(i) := inputB(i) xor aluOptions(2);
      
      case aluOptions(1 downto 0) is
        when "00" =>
          data(i) <= muxa(i) and muxb(i);
        when "01" =>
          data(i) <= muxa(i) or muxb(i);
        when "10" =>
          data(i) <= muxa(i) xor muxb(i);
        when others =>
          p(i) := muxa(i) xor muxb(i);
          g(i) := muxa(i) and muxb(i);
          data(i) <= p(i) xor carry(i);
          carry(i+1) := g(i) or (p(i) and carry(i));		 
      end case;
    end loop;
    --OV
    flags(3) <= carry(4) xor carry(3);
    --N
    flags(2) <= data(3);
    --Z
    if(data="0000") then
      flags(1) <= '1';
    else
      flags(1) <= '0';
    end if;

    --C
    flags(0) <= carry(4);
  end process ALU;

end Behavioral;