----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:49 11/11/2014 
-- Design Name: 
-- Module Name:    Letter - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if usingw
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Letter is
    Port ( X_Sync, Y_Sync : in  STD_LOGIC_VECTOR (9 downto 0);
           Letter_on : out  STD_LOGIC;
           Letter_RGB : out  STD_LOGIC_vector ( 2 downto 0);
           Video_on, Clk : in  STD_LOGIC);
end Letter;

architecture Behavioral of Letter is
Constant Rom_Row: integer := 6; --- Row_Columns can be represented by how many bits  (2^(6+1) = 128 >102
Constant Rom_Column: integer := 102; --- Number of Row in your Rom
Constant Heigh_Rom : integer := 35;--- Number of Column in your Rom

type rom_type is array (0 to 35) of std_logic_vector ( Rom_Column downto 0); 
constant Letter_ROM: rom_type:= (

"0000000000000000000000000000000000111111110000000000000000000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111110010110110110100000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000110000110011111111111100000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000110000110011000000000100000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000110011111111000000000111000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000110010000000000000000011000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000110011111111111111111111000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111111111111111111111000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111111101100001111111000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111111111100001111111111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111100001100000011101111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111101111100001111101111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111000001110000001111101111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000111111111111100001111111111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000001111111111100000000111111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000001111111111100000000111111000000000000000000000000000000000000000000",
"0000000000000000000000000000000000001111100000000000000110110000000000000000000000000000000000000000000",
"0000000000000000000000000000000000000011111111111111111111111111100000000000000000000000000000000000000",
"0000000000000000000000000000000000000011111111111111111111111111100000000000000000000000000000000000000",
"0000000000000000000000000000000000000000111101111111011111111111110000000000000000000000000000000000000",
"0000000000000000000000000000000000111000111111111111111111111111111000000000000000000000000000000000000",
"0000000000000000000000000000000000111000110111111001111111111111111000000000000000000000000000000000000",
"0000000000000000000000000000000000111000110111111101111111111111111110000000000000000000000000000000000",
"0000000000000000000000000000000000111111110000000001111111111111000110000000000000000000000000000000000",
"0000000000000000000000000000000000111111111100011001011101011111000110000000000000000000000000000000000",
"0000000000000000000000000000000000111110011100011100011100011110000110000000000000000000000000000000000",
"0000000000000000000000000000000000111110011100011000011100011111011110000000000000000000000000000000000",
"0000000000000000000000000000000000111110000000000000000000011111011110000000000000000000000000000000000",
"0000000000000000000000000000000000111110000000000000000000111111111000000000000000000000000000000000000",
"0000000000000000000000000000000000111110000000000000000001111111111000000000000000000000000000000000000",
"0000000000000000000000000000000000111111111111000000000001111111110000000000000000000000000000000000000",
"0000000000000000000000000000000000111111111111000000000000011111110000000000000000000000000000000000000",
"0000000000000000000000000000000000000000000011111111000000011111111000000000000000000000000000000000000",
"0000000000000000000000000000000000000000000011111111000000011111110000000000000000000000000000000000000",
"0000000000000000000000000000000000000000000000000011111111111001111000000000000000000000000000000000000",
"0000000000000000000000000000000000000000000000000011111111111001110000000000000000000000000000000000000");







--	constant Letter_ROM: rom_type:= (
--	"00000000000000000000000000",
--   "01111100000000000001111000",
--   "01111100000000000011111000",
--	"01111100000000000011111000",
--	"01111110000000000011110000",
--	"00111110000000000111110000",
--	"00111110000000000111110000",
--	"00111110000000000111100000",
--	"00011111000000001111100000",
--	"00011111000000001111100000",
--	"00011111000000001111000000",
--	"00001111100000011111000000",
--	"00001111100000011111000000",
--	"00001111100000011110000000",
--	"00000111110000111110000000",
--	"00000111110000111110000000",
--	"00000111110000111100000000",
--	"00000011111001111100000000",
--	"00000011111001111000000000",
--	"00000011111001111000000000",
--	"00000001111111111000000000",
--	"00000001111111110000000000",
--	"00000001111111110000000000",
--	"00000000111111110000000000",
--	"00000000111111100000000000",
--	"00000000111111100000000000");


constant Letter_L : integer := 50;	--Letter Starting Point
Constant Letter_T : integer := 10;   -- Letter Top Starting Pont
signal Let_RGB : std_logic_vector ( 2 downto 0):="000";	
signal X, Y :  unsigned(9 downto 0):="0000000000";
	signal rom_addr, rom_col, V_y_Reg,V_X_Reg, V_y_Next,V_X_Next : unsigned(Rom_Row downto 0):=(others => '0');
	signal rom_data: std_logic_vector(Rom_Column downto 0):=(others => '0');
	signal Screen_on,  L_on, L_C: std_logic :='0';
   
begin

--- Screen_on is signal every time screen refreshes.
Screen_on <= '1' when (Y <= 480) else '0';
 

---- Input pixel is converted into unsigned bits
X <= unsigned(X_Sync);
Y <= unsigned(Y_Sync);

--Once the pixel reach the location user want to display the letter
-- V_X_Next and V_Y_Next start incrementing to collect the bits from the Rom
V_X_Next <= (X (Rom_Row downto 0) - Letter_L) when L_C ='1' else V_X_Reg(Rom_Row downto 0) ;
V_Y_Next <= (Y (Rom_Row downto 0) - Letter_T ) when L_C ='1' else V_Y_Reg(Rom_Row downto 0);
	

rom_col <= V_X_Reg;
Rom_addr <= V_Y_Reg;

--- Transfer the V_x_Next to V_x_Reg every time Video is on
 process (Clk, Video_on)
 begin
 if ( Video_on ='0') then
   V_X_Reg <= (others => '0');
 elsif (rising_edge(Clk))then
 V_X_Reg <= V_X_Next;
 end if;
 end process;
 
 --- Transfer the V_y_Next to V_Y_Reg every time Screen Refreshes
  process (Video_on, Screen_on, Clk)
 begin
 if ( Screen_on ='0') then
   V_Y_Reg <= (others => '0');
 elsif (rising_edge(Clk))then
 V_Y_Reg <= V_Y_Next;
 end if;
 end process;



--- L_C will only turn on when the pixels is in between where 
--- user want to display the letter Letter_L = Position in X direction from left
---- Letter_T = Position wrt to top
 L_C <= '1' when ( (X >= Letter_L) and 
                   (Y >= Letter_T )  and  
						 (X < (Rom_Column +Letter_L + 1) )and 
						 (Y < (Letter_T + Heigh_Rom + 1 ))) else '0';

 --- Whole row is being selected from the rom and stored in Rom_data
Rom_data <= Letter_ROM(to_integer(rom_addr));
 ---- From the row stored in Rom_data single is collected one by one to L_on
 process (L_C, rom_col, rom_data) 
 begin 
 if (L_C = '1') then
 L_on <= rom_data(to_integer(rom_col)) ;
 else
 L_on <='0';
 
 end if;
 end process;


Letter_RGB <= "100" when L_on = '1' else "000";			
Letter_on <= L_on;




end Behavioral;

