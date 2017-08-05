library IEEE;
use IEEE.STD_LOGIC_1164.all;

package ESCOMIPSPackage is
  
  component ALU is Port(
    inputA,inputB: in std_logic_vector(15 downto 0);
    aluOptions: in std_logic_vector(3 downto 0);
    flags: out std_logic_vector(3 downto 0);
    data: inout std_logic_vector(15 downto 0));
  end component;  
  
  component RegisterFile is Port(
    read_register1,read_register2 : in std_logic_vector(3 downto 0);
    read_data1,read_data2 : out std_logic_vector (15 downto 0);
    write_register : in std_logic_vector (3 downto 0);
    write_data : in std_logic_vector(15 downto 0);
    clock : in std_logic;
    clear : in std_logic;
    shamt : in std_logic_vector (3 downto 0);
    wr,she,dir : in std_logic
  );
  end component;
  
  component DataMemory is 
    generic(
      N: integer := 10;
      M: integer := 16);
    Port(dir : in std_logic_vector(N-1 downto 0);
         data_in : in std_logic_vector(M-1 downto 0);
         data_out : out std_logic_vector(M-1 downto 0);
         clock : in std_logic;
         wr: in std_logic);
  end component;
  
  component ProgramMemory is 
    generic(
      D : integer := 10;
      P : integer := 25
	 );
	 Port(
    dir_bus : in std_logic_vector (D-1 downto 0);
    data_out : out std_logic_vector (P-1 downto 0));
  end component;
  
  component Stack is 
    generic(
      REGISTER_SIZE : integer := 16;
      STACK_SIZE : integer := 8
    );
    Port(data: in STD_LOGIC_VECTOR(REGISTER_SIZE-1 downto 0);
         q: out STD_LOGIC_VECTOR(REGISTER_SIZE-1 downto 0);
         up,down: in STD_LOGIC;
         clock, clear, wpc : in STD_LOGIC);
  end component;
  
  component ControlUnity is 
    Port(clock,clear : in std_logic;
         functionCode : in std_logic_vector(3 downto 0);
         opcode : in std_logic_vector(4 downto 0);
         flags : in std_logic_vector(3 downto 0);
         lf : in std_logic;
         s : out std_logic_vector(19 downto 0));
  end component;
  
  component Divider is
    Port(
	   clock_oscilator,clear : in std_logic;
     clock : inout std_logic
	  );
  end component;
end ESCOMIPSPackage;

package body ESCOMIPSPackage is

end ESCOMIPSPackage;
