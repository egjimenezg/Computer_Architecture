-- Author: Gamaliel Jiménez

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity ProgramMemory is
  generic(
    D : integer := 10;
    P	: integer := 25
  );
  Port(
    dir_bus : in std_logic_vector (D-1 downto 0);
    data_out : out std_logic_vector (P-1 downto 0)
  );
end ProgramMemory;

architecture Behavioral of ProgramMemory is
  constant OPCODE_TYPER : std_logic_vector(4 downto 0) := "00000";
  constant OPCODE_LI : std_logic_vector(4 downto 0) :=  "00001";
  constant OPCODE_LWI : std_logic_vector(4 downto 0) := "00010";
  constant OPCODE_SWI : std_logic_vector(4 downto 0) := "00011";
  constant OPCODE_SW : std_logic_vector(4 downto 0) := "00100";
  constant OPCODE_ADDI : std_logic_vector(4 downto 0) := "00101";
  constant OPCODE_SUBI : std_logic_vector(4 downto 0) := "00110";
  constant OPCODE_ANDI : std_logic_vector(4 downto 0) := "00111";
  constant OPCODE_ORI : std_logic_vector(4 downto 0) := "01000";
  constant OPCODE_XORI : std_logic_vector(4 downto 0) := "01001";
  constant OPCODE_NANDI : std_logic_vector(4 downto 0) := "01010";
  constant OPCODE_NORI : std_logic_vector(4 downto 0) := "01011";
  constant OPCODE_XNORI : std_logic_vector(4 downto 0) := "01100";
  constant OPCODE_BEQI : std_logic_vector(4 downto 0) := "01101";
  constant OPCODE_BNEI : std_logic_vector(4 downto 0) := "01110";
  constant OPCODE_BLTI : std_logic_vector(4 downto 0) := "01111";
  constant OPCODE_BLETI : std_logic_vector(4 downto 0) := "10000";
  constant OPCODE_BGTI : std_logic_vector(4 downto 0) := "10001";
  constant OPCODE_BGETI : std_logic_vector(4 downto 0) := "10010";
  constant OPCODE_B : std_logic_vector(4 downto 0) := "10011";
  constant OPCODE_CALL : std_logic_vector(4 downto 0) := "10100";
  constant OPCODE_RET : std_logic_vector(4 downto 0) := "10101";
  constant OPCODE_NOP : std_logic_vector(4 downto 0) := "10110";
  constant OPCODE_LW : std_logic_vector(4 downto 0) := "10111";
  
  constant FUNCTIONCODE_ADD : std_logic_vector(3 downto 0) := "0000";
  constant FUNCTIONCODE_SUB : std_logic_vector(3 downto 0) := "0001";
  constant FUNCTIONCODE_AND : std_logic_vector(3 downto 0) := "0010";
  constant FUNCTIONCODE_OR : std_logic_vector(3 downto 0) := "0011";
  constant FUNCTIONCODE_XOR : std_logic_vector(3 downto 0) := "0100";
  constant FUNCTIONCODE_NAND : std_logic_vector(3 downto 0) := "0101";
  constant FUNCTIONCODE_NOR : std_logic_vector(3 downto 0) := "0110";
  constant FUNCTIONCODE_XNOR : std_logic_vector(3 downto 0) := "0111";
  constant FUNCTIONCODE_NOT : std_logic_vector(3 downto 0) := "1000";
  constant FUNCTIONCODE_SSL : std_logic_vector(3 downto 0) := "1001";
  constant FUNCTIONCODE_SRL : std_logic_vector(3 downto 0) := "1010";
  
  constant R0 : std_logic_vector(3 downto 0) := "0000";
  constant R1 : std_logic_vector(3 downto 0) := "0001";
  constant R2 : std_logic_vector(3 downto 0) := "0010";
  constant R3 : std_logic_vector(3 downto 0) := "0011";
  constant R4 : std_logic_vector(3 downto 0) := "0100";
  constant R5 : std_logic_vector(3 downto 0) := "0101";
  constant R6 : std_logic_vector(3 downto 0) := "0110";
  constant R7 : std_logic_vector(3 downto 0) := "0111";
  constant R8 : std_logic_vector(3 downto 0) := "1000";
  constant R9 : std_logic_vector(3 downto 0) := "1001";
  constant R10 : std_logic_vector(3 downto 0) := "1010";
  constant R11 : std_logic_vector(3 downto 0) := "1011";
  constant R12 : std_logic_vector(3 downto 0) := "1100";

--  type customArray is array(0 to (2**D)-1) of std_logic_vector(P-1 downto 0);
--    constant memory : customArray := (
--      OPCODE_LI & R0 & X"0001",
--      OPCODE_LI & R1 & X"0007",
--      OPCODE_TYPER & R1 & R1 & R0 & "0000" & FUNCTIONCODE_ADD,
--      OPCODE_SWI & R1 & X"0005",
--      OPCODE_B & "0000" & X"0002",  
  type customArray is array(0 to (2**D)-1) of std_logic_vector(P-1 downto 0);
    constant memory : customArray := (
	   OPCODE_LI & R0 & X"0017",   --0
		OPCODE_SWI & R0 & X"000A",  --1
		
	   OPCODE_LI & R0 & X"0082",   --2
      OPCODE_SWI & R0 & X"000B",  --3
		
		OPCODE_LI & R0 & X"0046",   --4
      OPCODE_SWI & R0 & X"000C",  --5
	
		OPCODE_LI & R0 & X"0104",   --6
      OPCODE_SWI & R0 & X"000D",  --7
		
		OPCODE_LI & R0 & X"0000",   --8
		OPCODE_LI & R2 & X"0000",   --9
		OPCODE_LI & R3 & X"0004",   --10
		
		OPCODE_LW & R4 & R2 & X"00A",       --   11 R4 = mem[10+R2]
      OPCODE_TYPER & R0 & R0 & R4 & "0000" & FUNCTIONCODE_ADD, --12 R0 = R0+R4
      OPCODE_ADDI & R2 & R2 & X"001",    --13  R2 = R2+1
      OPCODE_BEQI & R2 & R3 & X"002",  --14 R2==R3
		OPCODE_B & "0000" & X"000B",     --   15 goto 11
		OPCODE_TYPER & R0 & R0 & R4 & "0000" & FUNCTIONCODE_SRL, --16
      OPCODE_SWI & R0 & X"0014",  --17 mem[20] = R0
		OPCODE_LWI & R7 & X"0014",  --18 R7 = mem[20]
		OPCODE_B & "0000" & X"0012",     --   19 goto 18
		
--    constant memory : customArray := (
--      OPCODE_LI & R0 & X"0055",   --0
--      OPCODE_SWI & R0 & X"0055",  --1
--		
--      OPCODE_LI & R0 & X"0066",   --2
--      OPCODE_SWI & R0 & X"0056",  --3
--		
--      OPCODE_LI & R0 & X"0101",   --4
--      OPCODE_SWI & R0 & X"0057",  --5	 
--		
--      OPCODE_LI & R0 & X"0002",   --6
--      OPCODE_SWI & R0 & X"0058",  --7
--		
--      OPCODE_LI & R0 & X"1024",   --8
--      OPCODE_SWI & R0 & X"0059",  --9
--		
--      OPCODE_LI & R0 & X"0019",   --10
--      OPCODE_SWI & R0 & X"005A",  --11
--		
--      OPCODE_LI & R0 & X"0061",   --12
--      OPCODE_SWI & R0 & X"005B",  --13
--		
--      OPCODE_LI & R0 & X"0000",   --14
--      OPCODE_SWI & R0 & X"005C",  --15
--		
--      OPCODE_LI & R0 & X"0035",   --16
--      OPCODE_SWI & R0 & X"005D",  --17
--		
--      OPCODE_LI & R0 & X"00FF",   --18
--      OPCODE_SWI & R0 & X"005E",  --19
--		
--      OPCODE_LI & R8 & X"0001", --i counter 20
--      OPCODE_LI & R1 & X"0000", --j counter 21
--      OPCODE_LI & R2 & X"000A", --n         22
--      OPCODE_LI & R3 & X"000A", --n         23
--      OPCODE_LI & R4 & X"0000", --a(j)      24
--      OPCODE_LI & R5 & X"0000", --a(j+1)    25
--      OPCODE_LI & R6 & X"0000", --aux       26
--      OPCODE_LI & R7 & x"0000", --j+1       27
--
--      OPCODE_BLTI & R2 & R8 & X"00C",  --   28 if(n>i) goto 40
--      OPCODE_LWI & R0 & X"0055",       --   29
--      OPCODE_LWI & R0 & X"0056",       --   30
--      OPCODE_LWI & R0 & X"0057",       --   31
--      OPCODE_LWI & R0 & X"0058",       --   32
--      OPCODE_LWI & R0 & X"0059",       --   33
--      OPCODE_LWI & R0 & X"005A",       --   34
--      OPCODE_LWI & R0 & X"005B",       --   35
--      OPCODE_LWI & R0 & X"005C",       --   36
--      OPCODE_LWI & R0 & X"005D",       --   37
--      OPCODE_LWI & R0 & X"005E",       --   38
--      OPCODE_B & "0000" & X"001D",     --   39  goto 29
--      OPCODE_TYPER & R3 & R2 & R8 & "0000" & FUNCTIONCODE_SUB, --40 n' = n-i
--      OPCODE_ADDI & R8 & R8 & X"001",    --41  i = i+1
--      OPCODE_LI & R1 & X"0000",          --42  j = 0                                   
--      OPCODE_BLTI & R3 & R1 & X"002",    --43 if(n'>j) goto 45
--      OPCODE_B & "0000" & X"001C",       --44 else goto 28
--      OPCODE_LW & R4 & R1 & X"055", 		--45  a(j) = mem[0x55+j]
--      OPCODE_ADDI & R7 & R1 & X"001",    --46  R7 = j+1
--      OPCODE_LW & R5 & R7 & X"055",      --47  a(j+1) = mem[0x55+j+1]
--      OPCODE_BLTI & R4 & R5 & X"003",    --48  if(a(j)>a(j+1)) goto 51
--      OPCODE_ADDI & R1 & R1 & X"001",    --49  j = j+1
--      OPCODE_B & "0000" & X"002B",       --50  goto 43
--      OPCODE_LW & R6 & R1 & X"055",      --51 aux = mem[0x55+j]
--      OPCODE_SW & R5 & R1 & X"055",      --52 mem[0x55+j] = a(j+1)
--      OPCODE_SW & R6 & R7 & X"055",      --53 mem[0x55+j+1] = aux
--      OPCODE_B & "0000" & X"0031",       --54  goto 49
      others => x"000000"&'0');
begin
  process(dir_bus)
  begin
    data_out <= memory(conv_integer(dir_bus));
  end process;
end Behavioral;
