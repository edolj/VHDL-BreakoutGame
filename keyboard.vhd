----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:56:15 02/19/2017 
-- Design Name: 
-- Module Name:    keyboard - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keyboard is
    Port ( clk_i : in  STD_LOGIC;
           reset_i : in  STD_LOGIC;
           kbdclk : in  STD_LOGIC;
           kbddata : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0);
           sc_ready : out  STD_LOGIC);
end keyboard;

architecture Behavioral of keyboard is

component nedge
    Port ( clk_i : in  STD_LOGIC;
           reset_i : in  STD_LOGIC;
           input : in  STD_LOGIC;
           output : out  STD_LOGIC);
end component;

component shiftRegister
    Port ( clk_i : in  STD_LOGIC;
           reset_i : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           input : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (8 downto 0));
end component;

type state_type is (st_IDLE, st_START, st_B0, st_B1, st_B2, st_B3,
							st_B4, st_B5, st_B6, st_B7, st_PAR);
signal state, next_state : state_type;
signal SYNCKBDDATA: STD_LOGIC;
signal SYNCKBDCLK: STD_LOGIC;
signal pulse: STD_LOGIC;
signal shr_en: STD_LOGIC;
signal shift_signal: STD_LOGIC;
signal data: STD_LOGIC_VECTOR(8 downto 0);

begin

	NegedgeDetector : nedge
	port map 
	(
		clk_i => clk_i,
		reset_i => reset_i,
		input => SYNCKBDCLK,
		output => pulse
	);
	
	Shift_reg : shiftRegister
	port map 
	(
		clk_i => clk_i,
		reset_i => reset_i,
		enable => shift_signal,
		input => SYNCKBDDATA,
		data_out => data
	);

	-- register stanj:
   SYNC_PROC: process (clk_i)
   begin
      if (clk_i'event and clk_i = '1') then
         if (reset_i = '1') then
            state <= st_IDLE;
				SYNCKBDDATA <= '1';
				SYNCKBDCLK <= '1';
         else
            state <= next_state;
				-- assign other outputs to internal signals
				SYNCKBDDATA <= kbddata;
				SYNCKBDCLK <= kbdclk;
         end if;
      end if;
   end process;
   
   -- racunanje novega stanja:
   NEXT_STATE_DECODE: process (state, pulse, SYNCKBDDATA)
	  begin
		  --declare default state for next_state to avoid latches
		  next_state <= state;  --default is to stay in current state
		  case (state) is
			  when st_IDLE =>
				  if (pulse = '1' and SYNCKBDDATA = '0') then
					  next_state <= st_START;
				  end if;
			  when st_START =>
				  if pulse = '1' then
					  next_state <= st_B0;
				  end if;
			  when st_B0 =>
				  if pulse = '1' then
					  next_state <= st_B1;
				  end if;
			  when st_B1 =>
				  if pulse = '1' then
					  next_state <= st_B2;
				  end if;
			  when st_B2 =>
				  if pulse = '1' then
					  next_state <= st_B3;
				  end if;
			  when st_B3 =>
				  if pulse = '1' then
					  next_state <= st_B4;
				  end if;    
				when st_B4 =>
					 if pulse = '1' then
						 next_state <= st_B5;
					 end if;
				 when st_B5 =>
					 if pulse = '1' then
						 next_state <= st_B6;
					 end if;
				 when st_B6 =>
					 if pulse = '1' then
						 next_state <= st_B7;
					 end if;
				 when st_B7 =>
					 if pulse = '1' then
						 next_state <= st_PAR;
					 end if; 
				 when st_PAR =>
						 if (pulse = '1' and SYNCKBDDATA = '1') then
							 next_state <= st_IDLE;
						 end if;
			  when others => 
						 next_state <= st_IDLE;
		  end case;
	  end process;
	
   -- racunanje izhodov
  	OUTPUT_DECODE: process(state) 
	begin
		sc_ready <= '0';
		if state = st_START then
			shr_en <= '1';
		elsif state = st_PAR then
			shr_en <= '0';
		elsif state = st_IDLE then
			shr_en <= '0';
			sc_ready <= '1';
		else
			shr_en <= '1';
		end if;
	end process;
	
	process(shr_en,pulse)
	begin
		if(shr_en = '1' and pulse = '1') then
			shift_signal <= '1';
		else
			shift_signal <= '0';
		end if;
	end process;

	data_out <= data(7 downto 0);
	
end Behavioral;

