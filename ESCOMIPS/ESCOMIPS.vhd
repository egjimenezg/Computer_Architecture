library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ESCOMIPSPackage.ALL;

entity ESCOMIPS is 
  Port(
    clock,clear : in std_logic;
    dir_bus : inout std_logic_vector(15 downto 0);
    instruction : inout std_logic_vector(24 downto 0);
    read_data2,aluOutput : inout std_logic_vector(15 downto 0);
    dataMemoryOutput : inout std_logic_vector(15 downto 0);
    S : inout std_logic_vector(19 downto 0));
end ESCOMIPS;

architecture Behavioral of ESCOMIPS is
--  signal clk : std_logic;
--  signal dir_bus : std_logic_vector(15 downto 0);
--  signal instruction : std_logic_vector(24 downto 0);
--  signal aluOutput : std_logic_vector(15 downto 0);
--  signal dataMemoryOutput : std_logic_vector(15 downto 0);
--  signal S : std_logic_vector(19 downto 0);

  --Register File Signals
  signal SHE,DIR,WR : std_logic;
  signal read_register1,read_register2 : std_logic_vector(3 downto 0);
  signal read_data1 : std_logic_vector(15 downto 0);
  signal write_register : std_logic_vector(3 downto 0);
  signal shamt : std_logic_vector(3 downto 0);
  signal write_data : std_logic_vector(15 downto 0);
  signal SRMuxOutput : std_logic_vector(15 downto 0);

  --Stack Signals
  signal SDMP,UP,DOWN,WPC : std_logic;
  signal stackInput : std_logic_vector(15 downto 0);

  --ALU Signals
  signal SR2,SWD,SEXT,SOP1,SOP2,SDMD : std_logic;
  signal aluInputA,aluInputB : std_logic_vector(15 downto 0);
  signal aluOptions,flags : std_logic_vector(3 downto 0);
  signal signExtension,addressExtension : std_logic_vector(15 downto 0);
  signal SEXTMuxOutput : std_logic_vector(15 downto 0);

  --DataMemorySignals
  signal WD,SR : std_logic;
  signal dirDataMemoryInput : std_logic_vector(15 downto 0);

  --ControlSignals
  signal LF : std_logic;
  signal functionCode : std_logic_vector(3 downto 0);
  signal opcode : std_logic_vector(4 downto 0);
begin

  SDMP <= s(19);
  UP <= s(18);
  DOWN <= s(17);
  WPC <= s(16);
  SR2 <= s(15);
  SWD <= s(14);
  SEXT <= s(13);
  SHE <= s(12);
  DIR <= s(11);
  WR <= s(10);
  SOP1 <= s(9);
  SOP2 <= s(8);
  aluOptions <= s(7 downto 4);
  SDMD <= s(3);
  WD <= s(2);
  SR <= s(1);
  LF <= s(0);

  write_register <= instruction(19 downto 16);
  read_register1 <= instruction(15 downto 12);
  shamt <= instruction(7 downto 4);
  opcode <= instruction(24 downto 20);
  functionCode <= instruction(3 downto 0);

  stackEntity:Stack Port Map(
    data => stackInput,
    q => dir_bus,
    up=>UP,
    down=>DOWN,
    clock=>clock,
--    clock=>clk,
    clear=>clear,
    wpc=>WPC
  );

  programMemoryEntity:ProgramMemory Port Map(
    dir_bus => dir_bus(9 downto 0),
	 data_out => instruction
  );

  registersFileEntity:RegisterFile Port Map(
    read_register1 => read_register1,
    read_register2 => read_register2,
    read_data1 => read_data1,
    read_data2 => read_data2,
    write_register => write_register,
    write_data => write_data,
    clock=>clock,
--    clock => clk,
    clear => clear,
    shamt => shamt,
    wr => WR,
    she => SHE,
    dir => DIR
  );

  dataMemoryEntity:DataMemory Port Map(
    dir => dirDataMemoryInput(9 downto 0),
    data_in => read_data2,
    data_out => dataMemoryOutput,
    clock=>clock,
--    clock => clk,
    wr => WD
  );

  aluEntity:ALU Port Map(
    inputA => aluInputA,
    inputB => aluInputB,
    aluOptions => aluOptions,
    flags => flags,
    data => aluOutput);

  controlUnityEntity:ControlUnity Port Map(
    clock=>clock,
--    clock =>clk,
    clear => clear,
    functionCode => functionCode,	 
    opcode => opcode,
    flags => flags,
    lf => LF,
    s => s);

--   dividerEntity:Divider Port Map(
--     clock_oscilator => clock,
--     clear => clear,
--     clock => clk
--   );

  SR2Mux:process(SR2,instruction)
  begin
    if(SR2='1') then
      read_register2 <= instruction(19 downto 16);
    else
      read_register2 <= instruction(11 downto 8);
    end if;
  end process SR2Mux;

  SWDMux:process(SWD,SRMuxOutput,instruction)
  begin
    if(SWD='1') then
	   write_data <= SRMuxOutput;
    else
	   write_data <= instruction(15 downto 0);
    end if;
  end process SWDMux;

  SDMPMux:process(SDMP,SRMuxOutput,instruction)
  begin
    if(SDMP='1') then
	   stackInput <= SRMuxOutput;
	 else
	   stackInput <= instruction(15 downto 0);
    end if;
  end process SDMPMux;
  
  SOP1Mux:process(SOP1,dir_bus,read_data1)
  begin
    if(SOP1='1') then
	   aluInputA <= dir_bus;
	 else
	   aluInputA <= read_data1;
	 end if;
  end process SOP1Mux;

  signExtension <= instruction(11)&instruction(11)&instruction(11)&instruction(11)&instruction(11 downto 0);
  addressExtension <= "0000"&instruction(11 downto 0);
  
  SEXTMux:process(SEXT,signExtension,addressExtension)
  begin
    if(SEXT='1') then
      SEXTMuxOutput <= signExtension; 
	 else
	   SEXTMuxOutput <= addressExtension;
	 end if;
  end process SEXTMux;

  SOP2Mux:process(SOP2,read_data2,SEXTMuxOutput)
  begin
    if(SOP2='1') then
	   aluInputB <= SEXTMuxOutput;
	 else
	   aluInputB <= read_data2;
	 end if;
  end process SOP2Mux;

  SDMDMux:process(SDMD,aluOutput,instruction)
  begin
    if(SDMD='1') then
	   dirDataMemoryInput <= instruction(15 downto 0);
	 else
	   dirDataMemoryInput <= aluOutput;
	 end if;
  end process SDMDMux;
  
  SRMux:process(SR,aluOutput,dataMemoryOutput)
  begin
    if(SR='1') then
	   SRMuxOutput <= aluOutput;
	 else
	   SRMuxOutput <= dataMemoryOutput;
	 end if;
  end process SRMux;
  
end Behavioral;
