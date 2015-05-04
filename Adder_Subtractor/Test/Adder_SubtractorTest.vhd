LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Adder_SubtractorTest IS
END Adder_SubtractorTest;
 
ARCHITECTURE behavior OF Adder_SubtractorTest IS 
 
  COMPONENT Adder_Subtractor PORT(
    inputA : IN  std_logic_vector(3 downto 0);
    inputB : IN  std_logic_vector(3 downto 0);
    sum : OUT  std_logic_vector(3 downto 0);
    option : IN  std_logic;
    cout : OUT  std_logic);
  END COMPONENT;

  signal inputA : std_logic_vector(3 downto 0) := (others => '0');
  signal inputB : std_logic_vector(3 downto 0) := (others => '0');
  signal option : std_logic := '0';

  signal sum : std_logic_vector(3 downto 0);
  signal cout : std_logic;
  
BEGIN
  -- Instantiate the Unit Under Test (UUT)
  uut: Adder_Subtractor PORT MAP (
    inputA => inputA,
    inputB => inputB,
    sum => sum,
    option => option,
    cout => cout
  );

  process
    begin
      inputA <= "0101";
      inputB <= "0101";
      option <= '0';
      wait for 10ns;
		
      inputA <= "1100";
      inputB <= "1000";
      option <= '0';
      wait for 10ns;
		
      inputA <= "1001";
      inputB <= "0101";
      option <= '0';
      wait for 10ns;
		
      inputA <= "1010";
      inputB <= "1001";
      option <= '1';
      wait for 10ns;
		
      inputA <= "0100";
      inputB <= "0010";
      option <= '0';
      wait for 10ns;

      inputA <= "0111";
      inputB <= "1001";
      option <= '1';
      wait for 10ns;

      inputA <= "1111";
      inputB <= "1111";
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