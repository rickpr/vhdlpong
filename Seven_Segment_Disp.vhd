----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:25:57 11/17/2014 
-- Design Name: 
-- Module Name:    Seven_Segment_Disp - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Seven_Segment_Disp is
    Port ( Clk, Reset: in  STD_LOGIC;
           Ax : out  STD_LOGIC_VECTOR (3 downto 0);
           Seg : out  STD_LOGIC_VECTOR (7 downto 0);
           Player_1, Player_2 : in  STD_LOGIC);
end Seven_Segment_Disp;

architecture Behavioral of Seven_Segment_Disp is
Signal Count1, Count2, Count3, Count4 :std_logic_vector ( 3 downto 0):="0000";

Component Clock_Divider is
    Port ( Clk,  Reset : in  STD_LOGIC;
           Slow_clk : out  STD_LOGIC_Vector ( 3 downto 0));
end component;

component Bin_2_Seg is
    Port ( Bin : in  STD_LOGIC_VECTOR (3 downto 0);
           Seg : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Zero_Ten_Counter is
    Port ( Reset, Clk, Count_Tick: in  STD_LOGIC;
           Count_Out : out  STD_LOGIC_VECTOR (3 downto 0);
           Max_Reached : out  STD_LOGIC);
end component;




signal New_Clk, Decode_in: std_logic_vector ( 3 downto 0):="0000";
Signal Clk1, Clk2, Clk3, Clk4: std_logic :='0';

begin
U0: Clock_Divider port map (Clk, Reset, New_Clk);
U1: Bin_2_Seg port map (Decode_in, Seg);
U100_Player1: Zero_Ten_Counter port map ( Reset, Clk, Player_1,Count2 , Clk1);
U1000_Player1: Zero_Ten_Counter port map ( Reset, Clk, Clk1, Count1, Clk2);
U1_Player2: Zero_Ten_Counter port map ( Reset, Clk, Player_2, Count4 , Clk3);
U10_Player2: Zero_Ten_Counter port map ( Reset, Clk, Clk3, Count3, Clk4);

Ax<= New_Clk ;

Decode_in <=  Count1 when New_clk="0111" else
              Count2 when New_clk="1011" else
				  Count3 when New_clk="1101" else
				  Count4 when New_clk="1110" else
				  "0000";
				  
				  
				  
				   
     
end Behavioral;

