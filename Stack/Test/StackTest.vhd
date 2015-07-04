LIBRARY ieee;

USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_ARITH.ALL;
USE ieee.std_logic_TEXTIO.ALL;

-- Author: Gamaliel Jiménez

LIBRARY std;
USE std.textio.ALL; 
 
ENTITY StackTest IS
END StackTest;
 
ARCHITECTURE behavior OF StackTest IS
  COMPONENT Stack
  PORT(data : IN  std_logic_vector(15 downto 0);
       q : OUT  std_logic_vector(15 downto 0);
       sp : OUT std_logic_vector(3 downto 0);
       up : IN  std_logic;
       down : IN  std_logic;
       clock : IN  std_logic;
       clear : IN  std_logic;
       wpc : IN  std_logic);
  END COMPONENT;

  --Inputs
  signal data : std_logic_vector(15 downto 0) := (others => '0');
  signal up : std_logic := '0';
  signal down : std_logic := '0';
  signal clock : std_logic := '0';
  signal clear : std_logic := '0';
  signal wpc : std_logic := '0';

  --Outputs
  signal q : std_logic_vector(15 downto 0);
  signal sp : std_logic_vector(3 downto 0);
  
  -- Clock period definitions
  constant clock_period : time := 10 ns;

BEGIN
  -- Instantiate the Unit Under Test (UUT)
  uut: Stack PORT MAP (
    data => data,
    q => q,
    sp => sp,
    up => up,
    down => down,
    clock => clock,
    clear => clear,
    wpc => wpc);

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
    file file_vec : TEXT;
    file results_file : TEXT;
    variable vectors_line : line;
    variable results_line : line;
    variable datav : std_logic_vector(15 downto 0);
    variable clearv : std_logic;
    variable upv : std_logic;
    variable downv : std_logic;
    variable wpcv : std_logic;
    variable header : string(1 to 4);
  begin		
    clear <= '1';
    file_open(file_vec,"vectors.txt",READ_MODE);
    file_open(results_file,"results.txt",WRITE_MODE);
    header := " D  ";
    write(results_line,header,right,header'length+1);
    header := " UP ";
    write(results_line,header,right,header'length+1);
    header := " DW ";
    write(results_line,header,right,header'length+1);
    header := " WPC";
    write(results_line,header,right,header'length+1);
    header := " CLR";
    write(results_line,header,right,header'length+1);
    header := " Q  ";
    write(results_line,header,right,header'length+1);
    header := " SP ";
    write(results_line,header,right,header'length+1);
    writeline(results_file,results_line);
    wait for 20ns;	  
      
    for i in 0 to 10 loop
      readline(file_vec,vectors_line);
      hread(vectors_line,datav);
      data <= datav;
      read(vectors_line,clearv);
      clear <= clearv;
      read(vectors_line,upv);
      up <= upv;
      read(vectors_line,downv);
      down <= downv;
      read(vectors_line,wpcv);
      wpc <= wpcv;
      wait for 10ns;
      hwrite(results_line,data,right,5);
      write(results_line,up,right,5);
      write(results_line,down,right,5);
      write(results_line,wpc,right,5);
      write(results_line,clear,right,5);
      hwrite(results_line,q,right,6);
      write(results_line,sp,right,6);
      writeline(results_file,results_line);
    end loop;

    file_close(file_vec);
    file_close(results_file);

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '1';
    wait for 10ns;

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;

    data <= x"0010";
    up <= '1';
    down <= '0';
    wpc <= '1';
    clear <= '0';
    wait for 10ns;

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;

    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;  
      
    data <= x"0020";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0100";
    up <= '1';
    down <= '0';
    wpc <= '1';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '1';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '1';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '1';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';
    wait for 10ns;
    
    data <= x"0000";
    up <= '0';
    down <= '0';
    wpc <= '0';
    clear <= '0';

    wait;
  end process;
END;