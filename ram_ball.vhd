----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:02:15 02/22/2017 
-- Design Name: 
-- Module Name:    ram32x40 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ram_ball is
    Port ( clk_i 		: in  STD_LOGIC;
           addrOUT_i : in  STD_LOGIC_VECTOR (4 downto 0);
           data_o 	: out  STD_LOGIC_VECTOR (0 to 39));
end ram_ball;

architecture Behavioral of ram_ball is

	type ram_type is array (31 downto 0) of std_logic_vector (0 to 39);
   signal RAM : ram_type;
	signal dataOUT : STD_LOGIC_VECTOR (0 to 39);

begin
	
	data_o <= dataOUT;

	-- to je dvokanalni RAM. Pisemo na naslov addrIN_i, istocasno lahko beremo z naslova addrOUT_i
	-- RAM ima asinhronski bralni dostop, tako da ga je easy za uporabit. Ko naslovis, takoj dobis podatke.
	-- pisalni dostop je sinhronski.
	-- Pazi LSB bit je skrajno levi, zato da se lazje 'ujema' z organizacijo zaslona!

	process(clk_i)
	begin
		if (clk_i'event and clk_i = '1') then
			-- ball                         
			RAM(0)  <= "0000000000000000000000000000000000000000";
			RAM(1)  <= "0000000000000000000000000000000000000000";
			RAM(2)  <= "0000000000000001111111111000000000000000";
			RAM(3)  <= "0000000000000111111111111110000000000000";
			RAM(4)  <= "0000000000001111111111111111110000000000";
			RAM(5)  <= "0000000000111111111111111111110000000000";
			RAM(6)  <= "0000000011111111111111111111111100000000";
			RAM(7)  <= "0000000111111111111111111111111110000000";
			RAM(8)  <= "0000001111111111111111111111111111000000";
			RAM(9)  <= "0000001111111111111111111111111111000000";
			RAM(10) <= "0000011111111111111111111111111111100000";
			RAM(11) <= "0000011111111111111111111111111111100000";
			RAM(12) <= "0000111111111111111111111111111111110000";
			RAM(13) <= "0001111111111111111111111111111111111000";
			RAM(14) <= "0001111111111111111111111111111111111000";
			RAM(15) <= "0001111111111111111111111111111111111000";
			RAM(16) <= "0001111111111111111111111111111111111000";
			RAM(17) <= "0001111111111111111111111111111111111000";
			RAM(18) <= "0000111111111111111111111111111111110000";
			RAM(19) <= "0000111111111111111111111111111111110000";
			RAM(20) <= "0000011111111111111111111111111111100000";
			RAM(21) <= "0000011111111111111111111111111111100000";
			RAM(22) <= "0000001111111111111111111111111111000000";
			RAM(23) <= "0000001111111111111111111111111111000000";
			RAM(24) <= "0000000111111111111111111111111110000000";
			RAM(25) <= "0000000011111111111111111111111100000000";
			RAM(26) <= "0000000000111111111111111111110000000000";
			RAM(27) <= "0000000000001111111111111111000000000000";
			RAM(28) <= "0000000000000001111111111100000000000000";
			RAM(29) <= "0000000000000000011111110000000000000000";
			RAM(30) <= "0000000000000000000000000000000000000000";
			RAM(31) <= "0000000000000000000000000000000000000000";
		end if;
	end process;

	dataOUT <= RAM(conv_integer(addrOUT_i));


end Behavioral;
