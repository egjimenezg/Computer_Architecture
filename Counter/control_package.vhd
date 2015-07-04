library IEEE;
use IEEE.STD_LOGIC_1164.all;

package control_package is

  component Shift IS PORT(
    clock : in STD_LOGIC;
    la : in STD_LOGIC;
    ea : in STD_LOGIC;
    data : in STD_LOGIC_VECTOR(7 downto 0);
    displacement : inout STD_LOGIC_VECTOR(7 downto 0));
  END component;

  component Counter IS 
    PORT(clock,clear : in STD_LOGIC;
         data: in STD_LOGIC_VECTOR(3 downto 0);
         counter : inout STD_LOGIC_VECTOR(3 downto 0);
         lb,eb : in STD_LOGIC);
  END component;

  component Converter IS
    PORT(binaryNumber : in std_logic_vector(3 downto 0);
         convertedNumber : out std_logic_vector(6 downto 0));
  END component;

  component Divider IS
    PORT(clock_oscilator,clear : in std_logic;
         clock : inout std_logic);
  END component;

  component ASM IS
    PORT(clock,clear : in std_logic;
         start : in std_logic;
         la,lb : out std_logic;
         ea,eb,ec : out std_logic;
         a0 : in std_logic;
         z : in std_logic);
  END component;
end control_package;