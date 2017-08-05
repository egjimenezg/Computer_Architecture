LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY ESCOMIPSTest IS
END ESCOMIPSTest;
 
ARCHITECTURE behavior OF ESCOMIPSTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ESCOMIPS
    PORT(
         clock : IN  std_logic;
         clear : IN  std_logic;
         dir_bus : INOUT  std_logic_vector(15 downto 0);
         instruction : INOUT  std_logic_vector(24 downto 0);
         read_data2 : INOUT  std_logic_vector(15 downto 0);
         aluOutput : INOUT  std_logic_vector(15 downto 0);
			dataMemoryOutput : INOUT std_logic_vector(15 downto 0);
			S : INOUT std_logic_vector(19 downto 0)
        );
    END COMPONENT;
    

   --Inputs
  signal clock : std_logic := '0';
  signal clear : std_logic := '0';

	--BiDirs
   signal dir_bus : std_logic_vector(15 downto 0);
   signal instruction : std_logic_vector(24 downto 0);
   signal read_data2 : std_logic_vector(15 downto 0);
   signal aluOutput : std_logic_vector(15 downto 0);
	signal dataMemoryOutput : std_logic_vector(15 downto 0);
   signal S : std_logic_vector(19 downto 0);
   -- Clock period definitions
   constant clock_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ESCOMIPS PORT MAP (
          clock => clock,
          clear => clear,
          dir_bus => dir_bus,
          instruction => instruction,
          read_data2 => read_data2,
          aluOutput => aluOutput,
			 dataMemoryOutput => dataMemoryOutput,
			 s => s
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
     clear <= '1';
	  clear <= '0';
     wait for clock_period*100*50000000;

     wait;
   end process;

END;
