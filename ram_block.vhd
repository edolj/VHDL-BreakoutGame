----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:18:23 02/25/2017 
-- Design Name: 
-- Module Name:    ram_block - Behavioral 
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

entity ram_block is
	Port ( clk_i 		: in  STD_LOGIC;
           addrOUT_i : in  STD_LOGIC_VECTOR (4 downto 0);
           data_o 	: out  STD_LOGIC_VECTOR (0 to 59));
end ram_block;

architecture Behavioral of ram_block is
	
	type ram_type is array (19 downto 0) of std_logic_vector (0 to 59);
   signal RAM : ram_type;
	signal dataOUT : STD_LOGIC_VECTOR (0 to 59);

begin
	
	data_o <= dataOUT;

	-- to je dvokanalni RAM. Pisemo na naslov addrIN_i, istocasno lahko beremo z naslova addrOUT_i
	-- RAM ima asinhronski bralni dostop, tako da ga je easy za uporabit. Ko naslovis, takoj dobis podatke.
	-- pisalni dostop je sinhronski.
	-- Pazi LSB bit je skrajno levi, zato da se lazje 'ujema' z organizacijo zaslona!

	process(clk_i)
	begin
		if (clk_i'event and clk_i = '1') then
			-- block                        
			RAM(0)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(1)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(2)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(3)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(4)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(5)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(6)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(7)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(8)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(9)  <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(10) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(11) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(12) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(13) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(14) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(15) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(16) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(17) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(18) <= "111111111111111111111111111111111111111111111111111111111111";
			RAM(19) <= "111111111111111111111111111111111111111111111111111111111111";
		end if;
	end process;

	dataOUT <= RAM(conv_integer(addrOUT_i));

end Behavioral;

