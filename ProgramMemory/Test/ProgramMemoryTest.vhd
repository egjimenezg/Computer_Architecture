-- Author: Gamaliel Jiménez
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.Numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_textio.ALL;
  
LIBRARY std;
USE std.textio.ALL;

ENTITY ProgramMemoryTest IS
END ProgramMemoryTest;
 
ARCHITECTURE behavior OF ProgramMemoryTest IS 
 
  COMPONENT ProgramMemory
  PORT(
    dir_bus : IN  std_logic_vector(11 downto 0);
    data_out : OUT  std_logic_vector(24 downto 0)
  );
  END COMPONENT;
    
  --Inputs
  signal dir_bus : std_logic_vector(11 downto 0) := (others => '0');

  --Outputs
  signal data_out : std_logic_vector(24 downto 0);
  
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: ProgramMemory PORT MAP (
    dir_bus => dir_bus,
    data_out => data_out
  );

  -- Stimulus process
  stim_proc: process
    file vectorsFile : TEXT;
    file resultsFile : TEXT;
    variable vectorsLine : line;
    variable resultsLine : line;
    variable header : string(1 to 6);
    variable A : std_logic_vector(11 downto 0);
    variable opcode : std_logic_vector(4 downto 0);
    variable bit19to16 : std_logic_vector(3 downto 0);
    variable bit15to12 : std_logic_vector(3 downto 0);
    variable bit11to8 : std_logic_vector(3 downto 0);
    variable bit7to4 : std_logic_vector(3 downto 0);
    variable bit3to0 : std_logic_vector(3 downto 0);
	 
  begin
    file_open(vectorsFile,"vectors.txt",READ_MODE);
    file_open(resultsFile,"results.txt",WRITE_MODE);
    header := "  A   ";
    write(resultsLine,header,right,header'length+1);
    header := "OPCODE";
    write(resultsLine,header,right,header'length+1);
    header := "19..16";
    write(resultsLine,header,right,header'length+1);
    header := "15..12";
    write(resultsLine,header,right,header'length+1);
    header := "11...8";
    write(resultsLine,header,right,header'length+1);
    header := "7....4";
    write(resultsLine,header,right,header'length+1);
    header := "3....0";
    write(resultsLine,header,right,header'length+1);
    writeline(resultsFile,resultsLine);
    wait for 50ns;
    
    for i in 0 to 6 loop
      readline(vectorsFile,vectorsLine);
      hread(vectorsLine,A);
      dir_bus <= A;
      wait for 5ns;
      opcode := data_out(24) & data_out(23) & data_out(22) & data_out(21) & data_out(20);
      bit19to16 := data_out(19) & data_out(18) & data_out(17) & data_out(16);
      bit15to12 := data_out(15) & data_out(14) & data_out(13) & data_out(12);
      bit11to8 := data_out(11) & data_out(10) & data_out(9) & data_out(8);
      bit7to4 := data_out(7) & data_out(6) & data_out(5) & data_out(4);
      bit3to0 := data_out(3) & data_out(2) & data_out(1) & data_out(0);		
      hwrite(resultsLine,A,right,6);
      write(resultsLine,opcode,right,7);
      write(resultsLine,bit19to16,right,7);
      write(resultsLine,bit15to12,right,7);
      write(resultsLine,bit11to8,right,7);
      write(resultsLine,bit7to4,right,7);
      write(resultsLine,bit3to0,right,7);
      writeline(resultsFile,resultsLine);		
    end loop;
    wait;
  end process;

END;