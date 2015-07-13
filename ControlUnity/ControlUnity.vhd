ilibrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ControlUnityPackage.ALL;

entity ControlUnity is Port(
  clock,clear : in std_logic;
  functionCode : in std_logic_vector(3 downto 0);
  opcode : in std_logic_vector(4 downto 0);
  flags : in std_logic_vector(3 downto 0);
  lf : in std_logic;
  s : out std_logic_vector(19 downto 0)
);
end ControlUnity;

architecture Behavioral of ControlUnity is
  signal RTYPE,BEQ,BNEQ,BLT,BLE,BGT,BGET,NA,EQ,NEQ,LT,LE,G,GET,SM,SDOPC : std_logic;
  signal functionMemoryOutput,opcodeMemoryOutput : std_logic_vector(19 downto 0);
  signal opcodeInput : std_logic_vector(4 downto 0);
begin
  
  asmModule:ASM Port Map(
    clock => clock,
    clear => clear,
    RTYPE => RTYPE,
    BEQ => BEQ,
    BNEQ => BNEQ,
    BLT => BLT,
    BLE => BLE,
    BGT => BGT,
    BGET => BGET,
    NA => NA,
    EQ => EQ,
    NEQ => NEQ,
    LT => LT,
    LE => LE,
    G => G,
    GET => GET,
    SM => SM,
    SDOPC => SDOPC
  );
  
  functionCodeModule:FunctionCodeMemory Port Map(
    functionCode => functionCode,
    microinstruction => functionMemoryOutput
  );
  
  ControlUnityOutput:process(SM,functionMemoryOutput,opcodeMemoryOutput)
  begin
    if(SM='1') then
     s <= opcodeMemoryOutput;
   else 
     s <= functionMemoryOutput;
   end if;
  end process ControlUnityOutput;
  
  stateRegisterModule:StateRegister Port Map(
    clock => clock,
   clear => clear,   
    lf => lf,
    flags_in => flags,
    equal => EQ,
    notEqual => NEQ,
    lessThan => LT,
    lessEqual => LE,
    greaterThan => G,
    greaterEqualThan => GET
  );
  
  levelModule:Level Port Map(
    clock => clock,
    clear => clear,
    na => na
  );
  
  instructionDecoderModule:InstructionDecoder Port Map(
    opcode => opcode,
    rType => RTYPE,
    bEqual => BEQ,
    bNotEqual => BNEQ,
    bLessThan => BLT,
    bLessEqual => BLE,
    bGreaterThan => BGT,
    bGreaterEqualThan => BGET
  );
  
  OpcodeMemoryInput:process(SDOPC,opcode)
  begin
    if(SDOPC='1') then
     opcodeInput <= opcode;
   else
     opcodeInput <= "00000";
   end if;
  end process OpcodeMemoryInput;
  
  operationMemoryModule:OpcodeMemory Port Map(
    code => opcodeInput,
    instruction => opcodeMemoryOutput
  );
  
end Behavioral;
