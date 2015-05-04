--Author: Gamaliel Jiménez

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY AdderSubtractorAnticipatedTest IS
END AdderSubtractorAnticipatedTest;
 
ARCHITECTURE behavior OF AdderSubtractorAnticipatedTest IS 
 
 
    COMPONENT AdderSubtractorAnticipatedCarry
    PORT(
         inputA : IN  std_logic_vector(3 downto 0);
         inputB : IN  std_logic_vector(3 downto 0);
         option : IN  std_logic;
         sum_subtraction : OUT  std_logic_vector(3 downto 0);
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal inputA : std_logic_vector(3 downto 0) := (others => '0');
   signal inputB : std_logic_vector(3 downto 0) := (others => '0');
   signal option : std_logic := '0';

 	--Outputs
   signal sum_subtraction : std_logic_vector(3 downto 0);
   signal cout : std_logic;
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: AdderSubtractorAnticipatedCarry PORT MAP (
          inputA => inputA,
          inputB => inputB,
          option => option,
          sum_subtraction => sum_subtraction,
          cout => cout
        );

   -- Clock process definitions
   process
   begin
     inputA <= "0101";
	  inputB <= "0101";
	  option <= '0';
     wait for 10ns;
	  
	  inputA <= "1100";
	  inputB <= "0111";
	  option <= '0';
     wait for 10ns;
	  
	  inputA <= "1001";
	  inputB <= "0101";
	  option <= '0';
     wait for 10ns;
	  
	  inputA <= "1110";
	  inputB <= "1001";
	  option <= '1';
     wait for 10ns;
	  
	  inputA <= "0100";
	  inputB <= "0010";
	  option <= '0';
     wait for 10ns;
	  
	  inputA <= "0111";
	  inputB <= "0111";
	  option <= '1';
     wait for 10ns;
	  
	  inputA <= "1111";
	  inputB <= "0101";
	  option <= '1';
     wait for 10ns;
	  
	  inputA <= "1011";
	  inputB <= "1000";
	  option <= '1';
     wait for 10ns;
	  
	  inputA <= "0001";
	  inputB <= "0100";
	  option <= '1';
     wait for 10ns;		
   end process;


END;
