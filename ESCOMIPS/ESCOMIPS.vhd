library IEEE;
use IEEE.std_logic_1164.ALL
use IEEE.std_logic_arith.ALL
use IEEE.std_logic_unsigned.ALL

entity ESCOMIPS is
  Port(
    clock,clear : in std_logic;
    dataMemoryInput : out std_logic_vector(15 downto 0);       
  );
end ESCOMIPS;

architecture Behavoiral of ESCOMIPS is
  signal read_register1,read_register2 : std_logic_vector(3  downto 0);
  signal aluInput : std_logic_vector(15 downto 0);
begin
 
  aluEntity:ALU Port Map(
    inputA =>,
    inputB =>,
    aluOptions => ,
    flags =>,
    data => 
  ); 

  dataMemoryEntity:DataMemory Port Map(
    dir_w =>,
    dir_r =>,
    data_in =>,
    data_out =>,    
    clock => clock
  );
  
  registersFile:RegisterFile Port Map(
    read_register1 =>,
    read_register2 =>,
    read_data1 =>,
    read_data2 =>,
    write_register =>,
    write_data =>,
    clock =>,
    clear : in std_logic;
    shamt : in std_logic_vector (3 downto 0);
    wr,
    she,
    dir : in std_logic 
  );

  programMemoryEntity:ProgramMemory Port Map(
    dir_bus =>,
    data_out =>   
  );
  
  stackEntity:Stack Port Map(
    data =>,
    q  =>,
    up =>,
    down =>, 
    sp =>, 
    clock =>,
    clear =>,
    wpc => 
  );

  unityControlEntity:ControlUnity Port Map(
    clock =>,
    clear =>,
    functionCode =>,
    opcode =>,
    flags =>,
    lf =>,
    s =>
  );

end Behavoiral;
