----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:12:06 11/10/2014 
-- Design Name: 
-- Module Name:    Walls - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Walls is
    Port ( Pixel_x, Pixel_Y : in  STD_LOGIC_VECTOR (9 downto 0);
           Video_on : in std_logic;
			  Wall_on : out  STD_LOGIC;
           Wall_RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end Walls;

architecture Behavioral of Walls is
Signal Wall_L_On,Wall_B_On, Wall_T_On, Wall_I_on, Wall, sq_d_on: std_logic:='0';
signal Wall_T_RGB, Wall_L_RGB, Wall_B_RGB : std_logic_vector ( 2 downto 0):="000";
signal X, Y :  std_logic_vector(9 downto 0):="0000000000";
signal pix_x, pix_y: unsigned(9 downto 0);
signal rom_row, rom_col: unsigned(3 downto 0);
constant dbottom: unsigned(9 downto 0):="0001100100";
	signal rom_data: std_logic_vector(15 downto 0);
	signal rom_bit: std_logic;
	type rom_type is array(0 to 15) of std_logic_vector(0 to 15);
	constant D_ROM: rom_type:= (
    "1111111111110000",
    "1111111110111000",
    "1110000000011100",
    "1110000000001110",
    "1110000000000111",
    "1110000000000111",
    "1110000000000111",
    "1110000000000111",
    "1110000000000111",
    "1110000000000111",
    "1110000000000111",
    "1110000000001111",
    "1110000000001110",
    "1110000000011100",
    "1111111111111000",
    "1111111111110000"
	 );
begin
X <= Pixel_x;
Y <= Pixel_Y;

Wall_RGB <="001" when ((Wall = '1')and (video_on='1')) else "000";

Wall <= Wall_T_On or Wall_B_On or Wall_L_On or Wall_I_on ;
Wall_on <= Wall;
----- Top Wall ---- 
Wall_T_On <= '1' when ((Y < "0000110010") and (video_on='1')) else '0';
---My splat on the screen---
--Top of the T
Wall_I_on <= '1' when ((X > "0001100100") and (Y > "0001100100") and (X < "0011001000") and (Y < "0001111100") and (video_on='1')) else
             '1' when ((X > "0010001001") and (Y > "0001111011") and (X < "0010100010") and (Y < "0011001000") and (video_on='1')) else
				 '0';

--	 sq_d_on <= '1' when ((X > "0001100100") and (Y > "0001100100")and (X < "0001110011") and (Y < "0001110011")
								   --and (video_on='1')) else 
					  --'0';
  -- map scan coord to ROM addr/col -- use low order three
	-- bits of pixel and ball positions.
	-- ROM row
	--rom_row <= pix_y(3 downto 0) - dbottom(3 downto 0);
	-- ROM column
	--rom_col <= pix_x(3 downto 0) - dbottom(3 downto 0);
	-- Get row data
	--rom_data <= D_ROM(to_integer(rom_row));
	-- Get column bit
	--rom_bit <= rom_data(to_integer(rom_col));
	
	-- Turn ball on only if within square and ROM bit is 1.
	--Wall_I_On <= '1' when (sq_d_on = '1') and (rom_bit = '1') else 
	--				  '0';
	--ball_on <= rd_ball_on;
					 
----- Bottom Wall ---- 
Wall_B_On <= '1' when ((Y > "0110101110") and (Y<="1000001011") and (video_on='1')) else '0';
----- Left Wall ---- 
--Wall_L_On <= '1' when ((X < "0000010101")  and (video_on='1')) else '0';


end Behavioral;

