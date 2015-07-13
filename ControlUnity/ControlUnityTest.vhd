LIBRARY ieee;
library std;
USE std.textio.all;
USE ieee.std_logic_textio.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;

ENTITY ControlUnityTest IS
END ControlUnityTest;
 
ARCHITECTURE behavior OF ControlUnityTest IS 
  
  COMPONENT ControlUnity
  PORT(
    clock : IN  std_logic;
    clear : IN  std_logic;
    functionCode : IN  std_logic_vector(3 downto 0);
    opcode : IN  std_logic_vector(4 downto 0);
    flags : IN  std_logic_vector(3 downto 0);
    lf : IN  std_logic;
    s : OUT  std_logic_vector(19 downto 0));
  END COMPONENT;
  
  --Inputs
  signal clock : std_logic := '0';
  signal clear : std_logic := '0';
  signal functionCode : std_logic_vector(3 downto 0) := (others => '0');
  signal opcode : std_logic_vector(4 downto 0) := (others => '0');
  signal flags : std_logic_vector(3 downto 0) := (others => '0');
  signal lf : std_logic := '0';

  --Outputs
  signal s : std_logic_vector(19 downto 0);

  -- Clock period definitions
  constant clock_period : time := 10 ns;
  
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
  uut: ControlUnity PORT MAP (
    clock => clock,
    clear => clear,
    functionCode => functionCode,
    opcode => opcode,
    flags => flags,
    lf => lf,
    s => s
  );

  clock_process :process
  begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
  end process;
 
  -- Stimulus process
  stim_proc: process
    file results_file,vectors_file : TEXT;
   variable results_line : line;
   variable vectors_line : line;
   variable microinstructionVariable : std_logic_vector(19 downto 0);    
   variable opcodeVariable : std_logic_vector(4 downto 0);
   variable functionCodeVariable : std_logic_vector(3 downto 0);
   variable flagsVariable : std_logic_vector(3 downto 0);
   variable clearVariable : std_logic;
   variable lfVariable : std_logic;
   variable header : string(1 to 9);
   variable microTextHeader : string(1 to 16);
   variable level : string(1 to 4);
   
  begin
    file_open(vectors_file,"VectorsFile.txt",READ_MODE);
   file_open(results_file,"resultsFile.txt",WRITE_MODE);
   header := " OP_CODE ";
   write(results_line,header,right,header'LENGTH+1);
   header := " FUN_CODE";
   write(results_line,header,right,header'LENGTH+1);
   header := " BANDERAS";
   write(results_line,header,right,header'LENGTH+1);
   header := "   CLR   ";
   write(results_line,header,right,header'LENGTH+1);
   header := "   LF    ";
   write(results_line,header,right,header'LENGTH+1);
   microTextHeader := "MICROINSTRUCCION";
   write(results_line,microTextHeader,right,microTextHeader'length+1);
   header := "  NIVEL  ";
   write(results_line,header,right,header'LENGTH+1);   
   writeline(results_file,results_line);
   
   for i in 0 to 4 loop
      level:="Alto";
    
    readline(vectors_file,vectors_line);
    read(vectors_line,opcodeVariable);
    opcode <= opcodeVariable;
    read(vectors_line,functionCodeVariable);
    functionCode <= functionCodeVariable;
    read(vectors_line,flagsVariable);
    flags <= flagsVariable;
    read(vectors_line,clearVariable);
    clear <= clearVariable;
    read(vectors_line,lfVariable);
    lf <= lfVariable;
      wait for 5ns; 
    microinstructionVariable := s;
    
    write(results_line,opcodeVariable,right,6);
    write(results_line,functionCodeVariable,right,12);
    write(results_line,flagsVariable,right,12);
    write(results_line,clearVariable,right,7);
    write(results_line,lfVariable,right,6);
    write(results_line,microinstructionVariable,right,22);
    write(results_line,level,right,6);
    writeline(results_file,results_line);
    
    if(lf='1') then
      wait for 5ns;
      microinstructionVariable := s;
      level:="Bajo";
      write(results_line,opcodeVariable,right,6);
      write(results_line,functionCodeVariable,right,12);
      write(results_line,flagsVariable,right,12);
      write(results_line,clearVariable,right,7);
      write(results_line,lfVariable,right,6);
      write(results_line,microinstructionVariable,right,22);
      write(results_line,level,right,6);
      writeline(results_file,results_line);
    end if;   
   end loop;
   file_close(results_file);
   file_close(vectors_file);
   wait;
  end process;
  
END;