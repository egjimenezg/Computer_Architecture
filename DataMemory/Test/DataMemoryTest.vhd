-- Company: 
-- Author: Gamaliel Jiménez

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_ARITH.ALL;
USE ieee.std_logic_textio.ALL;

LIBRARY std;
USE std.textio.ALL;
 
ENTITY DataMemoryTest IS
END DataMemoryTest;
 
ARCHITECTURE behavior OF DataMemoryTest IS 

  COMPONENT DataMemory
    PORT(
      dir_w : IN  std_logic_vector(10 downto 0);
      dir_r : IN  std_logic_vector(10 downto 0);
      data_in : IN  std_logic_vector(15 downto 0);
      data_out : OUT  std_logic_vector(15 downto 0);
      clock : IN  std_logic;
      wr : IN  std_logic);
  END COMPONENT;
    
  --Inputs
  signal dir_w : std_logic_vector(10 downto 0) := (others => '0');
  signal dir_r : std_logic_vector(10 downto 0) := (others => '0');
  signal data_in : std_logic_vector(15 downto 0) := (others => '0');
  signal clock : std_logic := '0';
  signal wr : std_logic := '0';

  --Outputs
  signal data_out : std_logic_vector(15 downto 0);

  -- Clock period definitions
  constant clock_period : time := 10 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: DataMemory PORT MAP (
  dir_w => dir_w,
  dir_r => dir_r,
  data_in => data_in,
  data_out => data_out,
  clock => clock,
  wr => wr
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
    file vectorsFile : TEXT;
    file resultsFile : TEXT;
    variable vectorsLine : line;
    variable resultsLine : line;
    variable Di : std_logic_vector(15 downto 0);
    variable A: std_logic_vector(7 downto 0);
    variable WD : std_logic;
    variable header : string(1 to 5);

  begin    
    wr <= '1';
    file_open(vectorsFile,"vectors.txt",READ_MODE);
    file_open(resultsFile,"results.txt",WRITE_MODE);
    header := "  A  ";
    write(resultsLine,header,right,header'length+1);
    header := "  Di ";
    write(resultsLine,header,right,header'length+1);
    header := "   WD";
    write(resultsLine,header,right,header'length+1);
    header := "  Do ";
    write(resultsLine,header,right,header'length+1);
    writeline(resultsFile,resultsLine);
    wait for 50ns;
	 
    for i in 0 to 11 loop
      readline(vectorsFile,vectorsLine);
      hread(vectorsLine,Di);
      data_in <= Di;
      hread(vectorsLine,A);
      dir_w <= "000"&A;
      dir_r <= "000"&A;
      read(vectorsLine,WD);
      wr <= WD;
      wait for 10ns;
      hwrite(resultsLine,A,right,6);
      hwrite(resultsLine,Di,right,6);
      write(resultsLine,WD,right,6);
      hwrite(resultsLine,data_out,right,6);
      writeline(resultsFile,resultsLine);
    end loop;

    file_close(vectorsFile);
    file_close(resultsFile);
  
  wait;
  end process;
END;