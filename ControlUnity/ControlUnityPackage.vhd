Calibrary IEEE;
use IEEE.STD_LOGIC_1164.all;

package ControlUnityPackage is
  component StateRegister is
    Port(clear,clock : in std_logic;
         lf : in std_logic;
         flags_in : std_logic_vector(3 downto 0); -- (3)OV (2)N (1)Z (0)C
         equal : out std_logic;
         notEqual : out std_logic;
         lessThan : out std_logic;
         lessEqual : out std_logic;
         greaterThan : out std_logic;
         greaterEqualThan : out std_logic);
  end component;
  
  component Level is
    Port(clock,clear : in std_logic;
         na : out std_logic);
  end component;
  
  component InstructionDecoder is
    Port( opcode : in std_logic_vector(4 downto 0); 
          rType : out std_logic;
          bEqual : out std_logic;
          bNotEqual : out std_logic;
          bLessThan : out std_logic;
          bLessEqual : out std_logic;
          bGreaterThan : out std_logic;
          bGreaterEqualThan : out std_logic);
  end component;
  
  component FunctionCodeMemory is
    Port(functionCode : in std_logic_vector(3 downto 0);
         microinstruction : out std_logic_vector(19 downto 0));
  end component;
  
  component OpcodeMemory is
    Port(code : in std_logic_vector(4 downto 0);
         instruction : out std_logic_vector(19 downto 0));
  end component;
  
  component ASM is
    Port( clock,clear : in std_logic;
          RTYPE : in std_logic;
          BEQ : in std_logic;
          BNEQ : in std_logic;
          BLT : in std_logic;
          BLE : in std_logic;
          BGT : in std_logic;
          BGET : in std_logic;
          NA : in std_logic;
          EQ : in std_logic;
          NEQ : in std_logic;
          LT : in std_logic;
          LE : in std_logic;
          G : in std_logic;
          GET : in std_logic;
          SM : out std_logic;
          SDOPC : out std_logic);
  end component;
end ControlUnityPackage;

package body ControlUnityPackage is

end ControlUnityPackage;
