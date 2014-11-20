----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:01:03 11/17/2014 
-- Design Name: 
-- Module Name:    Zero_Ten_Counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Zero_Ten_Counter is
    Port ( Reset, Clk, Count_Tick: in  STD_LOGIC;
           Count_Out : out  STD_LOGIC_VECTOR (3 downto 0);
           Max_Reached : out  STD_LOGIC);
end Zero_Ten_Counter;

architecture Behavioral of Zero_Ten_Counter is
Component clock_buffer is
port	(
		clk	:	in	std_logic;
		btn	:	in	std_logic;
		clk_o	:	out	std_logic
		);
end Component;


Type State_type IS (Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten); 
Signal PS, NS : State_type;
signal Tick: std_logic :='0';

begin

Debounce: clock_buffer port map (Clk => Clk, Btn => Count_Tick, clk_o => Tick);

Counter: Process (Reset,clk)
begin
If( Reset = '1') then
 PS <= Zero;
elsif (rising_edge(clk)) then
 PS <= NS;
end if;
end process; 



Process (PS, Tick)
begin
Case PS is 
 When Zero =>   Count_Out <= "0000";
               Max_Reached <= '0';
					 
					 if ( (Tick ='1')) then
					 NS <= One;
					 else
					 NS <= Zero;
					 end if;

 When One =>   Count_Out <= "0001";
               Max_Reached <= '0';
					
					if ((Tick ='1')) then
					 NS <= Two;
					 else
					 NS <= One;
					 end if;
					
 When Two =>   Count_Out <= "0010";
               Max_Reached <= '0';
               
					if (  (Tick ='1')) then
					 NS <= Three;
					 else
					 NS <= Two;
					 end if;
					
 When Three =>   Count_Out <= "0011";
               Max_Reached <= '0';
					if ((Tick ='1')) then
					 NS <= Four;
					 else
					 NS <= Three;
					 end if;
					
 When Four =>   Count_Out <= "0100";
               Max_Reached <= '0';
					if (Tick ='1') then
					 NS <= Five;
					 else
					 NS <= Four;
					 end if;

 When Five =>   Count_Out <= "0101";
               Max_Reached <= '0';
					if (Tick ='1') then
					 NS <= Six;
					 else
					 NS <= Five;
					 end if;
					
When Six =>   Count_Out <= "0110";
               Max_Reached <= '0';	
					if (Tick ='1') then
					 NS <= Seven;
					 else
					 NS <= Six;
					 end if;

 When Seven =>   Count_Out <= "0111";
               Max_Reached <= '0';
					if ( Tick ='1') then
					 NS <= Eight;
					 else
					 NS <= Seven;
					 end if;
					
When Eight =>   Count_Out <= "1000";
               Max_Reached <= '0';	
					if (Tick ='1') then
					 NS <= Nine;
					 else
					 NS <= Eight;
					 end if;
					
When NINE =>   Count_Out <= "1001";
               Max_Reached <= '0';	
					if ( (Tick ='1')) then
					 NS <= TEN;
					 else
					 NS <= Nine;
					 end if;

When Ten =>   Count_Out <= "0000";
               Max_Reached <= '1';	
					if ((Tick ='1')) then
					 NS <= One;
					 else
					 NS <= Zero;
					 end if;	

end case;					

end process;




end Behavioral;

