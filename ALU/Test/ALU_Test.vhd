--Author: Gamaliel Jiménez

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY ALU_Test IS
END ALU_Test;
 
ARCHITECTURE behavior OF ALU_Test IS 

  COMPONENT ALU 
    PORT(inputA : IN  std_logic_vector(3 downto 0);
         inputB : IN  std_logic_vector(3 downto 0);
         aluOptions : IN  std_logic_vector(3 downto 0);
         flags : OUT  std_logic_vector(3 downto 0);
         data : INOUT  std_logic_vector(3 downto 0));
    END COMPONENT;

  --Inputs
  signal inputA : std_logic_vector(3 downto 0) := (others => '0');
  signal inputB : std_logic_vector(3 downto 0) := (others => '0');
  signal aluOptions : std_logic_vector(3 downto 0) := (others => '0');

  --BiDirs
  signal data : std_logic_vector(3 downto 0);

  --Outputs
  signal flags : std_logic_vector(3 downto 0);
  
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          inputA => inputA,
          inputB => inputB,
          aluOptions => aluOptions,
          flags => flags,
          data => data);			 
  process
    begin
    inputA <= "0101";
    inputB <= "1110";
    aluOptions <= "0011";
    wait for 10ns;
		
    aluOptions <= "0111";
    wait for 10ns;

    aluOptions <= "0000";
    wait for 10ns;

    aluOptions <= "1101";
    wait for 10ns;
		
    aluOptions <= "0001";
    wait for 10ns;

    aluOptions <= "1100";
    wait for 10ns;

    aluOptions <= "0010";
    wait for 10ns;

    aluOptions <= "0110";
    wait for 10ns;

    inputA <= "0101";
    inputB <= "0101";
    aluOptions <= "0111";
    wait for 10 ns;
    aluOptions <= "1101";
    wait for 10 ns;

  end process;

END;