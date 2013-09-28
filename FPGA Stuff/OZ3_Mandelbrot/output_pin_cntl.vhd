----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: Output_pin_cntl
--Module Description:
--	This module handles the pin output, mainly by holding the flip-flops that
-- store what each pin should be outputting. If the processor needs a certain
-- pin to output 0, '0' is stored in that pin's flip-flop, which drives the
-- output. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity output_pin_cntl is
    Port ( clock : in  STD_LOGIC;
			  enable : in STD_LOGIC;
           reset : in  STD_LOGIC;
           data : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR(3 downto 0);
           pins : out  STD_LOGIC_VECTOR (15 downto 0));
end output_pin_cntl;

architecture Behavioral of output_pin_cntl is

begin

	--The main process that handles everything
	opin: process (clock, reset) is
		--This variable is that actual register. I decided to make it a variable as
		--opposed to a register component because it's easier to address and manipulate
		--individual bits that way
		variable opin_reg : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
	begin
		if falling_edge(clock) then
			if enable = '1' then
				opin_reg(conv_integer(unsigned(sel))) := data; --Write a 0 or 1 to the selected pin
			end if;
		end if;
		if reset = '1' then
			opin_reg := (others => '0');
		end if;
		pins <= opin_reg; --Drive the pins
	end process;

end Behavioral;

