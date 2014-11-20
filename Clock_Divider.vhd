----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:40:10 11/17/2014 
-- Design Name: 
-- Module Name:    Clock_Divider - Behavioral 
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
use IEEE.STD_LOGIc_Unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock_Divider is
    Port ( Clk,  Reset : in  STD_LOGIC;
           Slow_clk : out  STD_LOGIC_Vector ( 3 downto 0));
end Clock_Divider;

architecture Behavioral of Clock_Divider is
signal Count: std_logic_vector ( 18 downto 0):=(others => '0'); 
signal N_clk : std_logic:='0';
Signal New_Count: std_logic_vector ( 1 downto 0) :=(others => '0');
begin

Slow_Clock_Gen: process (Clk, Reset)
begin
if (reset = '1') then
Count <= (others => '0');
elsif ( rising_edge (clk)) then
Count <= Count + 1 ;
end if;
end process;
N_clk <= Count(18);

Input_Decoder: process (N_clk )
begin
if (rising_edge(N_clk)) then
New_Count <= New_Count + 1;
end if;
end process;

Slow_Clk <= "1110" when New_Count = "00" else
            "1101" when New_Count = "01" else
				"1011" when New_Count = "10" else
				"0111";

end Behavioral;

