----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:58:12 11/03/2014 
-- Design Name: 
-- Module Name:    Top - Behavioral 
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top is
    Port ( Clk,Reset, pause : in  STD_LOGIC;
	        Padle: in std_logic_vector (1 downto 0);
			   Hsync, Vsync : out  STD_LOGIC;
           Ax : out  STD_LOGIC_VECTOR (3 downto 0);
           Seg : out  STD_LOGIC_VECTOR (7 downto 0);
			  rgb : out std_logic_vector(2 downto 0));
end Top;

architecture Behavioral of Top is
component vga_sync is
port(
		clk, reset : in std_logic;
		hsync, vsync : out std_logic;
		video_on, p_tick : out std_logic;	
		pixel_x, pixel_y : out std_logic_vector(9 downto 0) -- Coordinates on screen
	);
end component;

component paddle is
port(
		clk, reset : in std_logic;
		btn : in std_logic_vector(1 downto 0);
		pause : in std_logic;
		location : in std_logic_vector(9 downto 0);
		paddle_on : out std_logic;
		pixel_x, pixel_y : in std_logic_vector(9 downto 0);
		paddle_rgb : out std_logic_vector(2 downto 0)
	);
end component;

component Walls is
    Port ( Pixel_x, Pixel_Y : in  STD_LOGIC_VECTOR (9 downto 0);
           Video_on : in std_logic;
			  Wall_on : out  STD_LOGIC;
           Wall_RGB : out  STD_LOGIC_VECTOR (2 downto 0));
end component;


component ball is
port(
		clk, reset : in std_logic;
		pause : in std_logic;
		pedal_on, paddle2_on : in std_logic;
		pixel_x, pixel_y : in std_logic_vector(9 downto 0);
		 Wall_Top, Wall_Bottom: out std_logic;
		ball_on : out std_logic;
		ball_rgb : out std_logic_vector(2 downto 0)
	);
end component;


component Letter is
    Port ( X_Sync, Y_Sync : in  STD_LOGIC_VECTOR (9 downto 0);
           Letter_on : out  STD_LOGIC;
           Letter_RGB : out  STD_LOGIC_vector ( 2 downto 0);
           Video_on,Clk : in  STD_LOGIC);
end component;

component Koopa is
    Port ( X_Sync, Y_Sync : in  STD_LOGIC_VECTOR (9 downto 0);
           Letter_on : out  STD_LOGIC;
           Letter_RGB : out  STD_LOGIC_vector ( 2 downto 0);
           Video_on,Clk : in  STD_LOGIC);
end component;

component Seven_Segment_Disp is
    Port ( Clk, Reset: in  STD_LOGIC;
           Ax : out  STD_LOGIC_VECTOR (3 downto 0);
           Seg : out  STD_LOGIC_VECTOR (7 downto 0);
           Player_1, Player_2 : in  STD_LOGIC);
end component;

--signal pause, state_pause : std_logic;

signal RGB_Next, rgb_reg, Background_RGB_X, Background_RGB_Y, Background_RGB,Letter_RGB, Koopa_RGB, Paddle_RGB, Wall_RGB, ball_rgb: std_logic_vector ( 2 downto 0):="000";
signal X, Y :  std_logic_vector(9 downto 0):="0000000000";
signal video, pixel_tick, Paddle_on, pedal_on, Wall_on, Ball_on, Letter_on, Koopa_on, Wall_Top, Wall_Bottom : std_logic:='0';

-------------------------------------------------------------
-------------------------------------------------------------
begin

--pause <= state_pause or sys_pause;

VGA: vga_sync port map (Clk, Reset, Hsync, Vsync,Video, pixel_tick, X, Y);
Peddle: paddle port map (Clk, Reset,Padle ,Pause, "1001011000", Paddle_on, X, Y, Paddle_RGB); --- peddle location is 600
Pedal: paddle port map (Clk, Reset,Padle ,Pause, "0000101000", pedal_on, X, Y, Paddle_RGB); --- pedal location is 40
Background: Walls port map (X, Y, Video, Wall_on, Wall_RGB);
Back_ball: ball port map (clk, reset, pause, pedal_on, Paddle_on, X, Y,Wall_Top, Wall_Bottom, Ball_on, Ball_RGB);
Letter_V: Letter port map (X,Y, Letter_on,Letter_RGB, Video, Clk); 
Koopa_V: Koopa port map (X,Y, Koopa_on,Koopa_RGB, Video, Clk);
Score: Seven_Segment_Disp port map ( Clk, Reset, AX,Seg,Wall_Top, Wall_Bottom);
--Led (0) <= Wall_Top;
--Led (1) <= Wall_Bottom;

process (Video,  Paddle_on, Paddle_RGB, Wall_on, Wall_RGB, Ball_on, Ball_RGB, Letter_on,Letter_RGB)  is
begin
if(video='1') then
  
 if (Paddle_on ='1') then
  RGB_Next <= Paddle_RGB;
  
   elsif (Letter_on ='1') then
  RGB_Next <= Letter_RGB;
  
   elsif (Koopa_on ='1') then
  RGB_Next <= Koopa_RGB;
 
 elsif (Ball_on ='1') then
  RGB_Next <= Ball_RGB;
 
 elsif (Wall_on ='1') then
  RGB_Next <= Wall_RGB;
 
 elsif (pedal_on ='1') then
  RGB_Next <= Paddle_RGB;
  
  else 
  
  RGB_Next <="000";
 end if;

else

RGB_Next <="000";

end if;
end process;

Process (clk) is
begin

 if ( Rising_Edge(Clk)) then
 
 if (pixel_tick='1') then
 
 rgb_reg <= RGB_Next;

 
 end if ;

end if;
end process;



RGB <= rgb_reg;


end Behavioral;

