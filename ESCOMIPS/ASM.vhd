library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ASM is Port( 
  clock,clear : in std_logic;
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
end ASM;

architecture Behavioral of ASM is
  type states is (A);
  signal currentState,nextState : states;
begin
  process(clock,clear)
  begin
    if(clear='1') then
	   currentState <= A;
	 elsif(RISING_EDGE(clock)) then
	   currentState <= nextState;
	 end if;
  end process;
  
  process(currentState,RTYPE,BEQ,BNEQ,BLT,BLE,BGT,BGET,NA,EQ,NEQ,LT,LE,G,GET)
  begin
    SM <= '0';
	 SDOPC <= '0';
	 case(currentState) is
	   when A =>
	     nextState <= A;
		  if(RTYPE='0') then
		    if(BEQ='1') then
			   if(NA='1') then
              SM <= '1';
            elsif(EQ='1') then
              SDOPC <= '1';
              SM <= '1';
            else
              SM <= '1';
			   end if;			 
			 elsif(BNEQ='1') then
            if(NA='1') then
              SM <= '1';
            elsif(NEQ='1') then
              SDOPC <= '1';
              SM <= '1';
            else
              SM <= '1';
            end if;
			 elsif(BLT='1') then
			   if(NA='1') then
              SM <= '1';
            elsif(LT='1') then
              SDOPC <= '1';
              SM <= '1';
            else
              SM <= '1';
            end if;			 
			 elsif(BLE='1') then
			   if(NA='1') then
              SM <= '1';
            elsif(LE='1') then
              SDOPC <= '1';
              SM <= '1';
            else
              SM <= '1';
            end if;			 
			 elsif(BGT='1') then
			   if(NA='1') then
              SM <= '1';
            elsif(G='1') then
              SDOPC <= '1';
              SM <= '1';
            else
              SM <= '1';
            end if;			 
			 elsif(BGET='1') then
			   if(NA='1') then
              SM <= '1';
            elsif(GET='1') then
              SDOPC <= '1';
              SM <= '1';
            else
              SM <= '1';
            end if;
			 else
			   SDOPC <= '1';
            SM <= '1';
			 end if; --END IF BEQ	  
		  end if; --END RTYPE if
	 end case;
  end process;
end Behavioral;