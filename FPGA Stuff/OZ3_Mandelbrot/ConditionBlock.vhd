----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: ConditionBlock
--Module Description:
--	This module handles the condition flags and sending them to the IF stage.
-- It holds the pin, equal, greater than, less than, and carry/overflow flags. It also
-- holds a constant '1' and constant '0' flag. The output is normally the '0' flag,
-- which tells the IF stage to not branch. If a branch instruction is to be executed,
-- the relevant flag is placed on the output. The '1' flag is used for jump
-- instructions, which tells the IF stage to branch.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ConditionBlock is
	Port ( clock : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 sel   : in STD_LOGIC_VECTOR(2 downto 0);
			 flags : in STD_LOGIC_VECTOR(4 downto 0);
			 cond_out : out STD_LOGIC);
end ConditionBlock;

architecture Behavioral of ConditionBlock is

--//Components\\--

--A generic rising-edge-triggered register
component GenReg is
	 generic (size: integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end component;

--\\Components//--

--//Signals\\--

--Carries the output of the flags register
signal flags_reg_out : STD_LOGIC_VECTOR(3 downto 0);

--\\Signals//--

begin

	--All this process does is take the select bits and, according
	--to them, outputs a different flag to be sent to the IF stage
	main: process (sel, flags_reg_out, flags(4)) is
	begin
		case (sel) is
			when b"001" =>
				cond_out <= flags_reg_out(0);
			when b"010" =>
				cond_out <= flags_reg_out(1);
			when b"011" =>
				cond_out <= flags_reg_out(2);
			when b"100" =>
				cond_out <= flags_reg_out(3);
			when b"101" =>
				cond_out <= flags(4);
			when b"110" => --The two constant flags down here have to do
				cond_out <= '1'; --with either a jump, in which case the '1' is placed
			when others =>		  --on the output. If just regular instructions are being
				cond_out <= '0'; --performed, the '0' is placed on the output, which tells the
		end case;				  --IF stage not to branch
	end process;

	--Register that holds the flags. Except for the pin flag, which doesn't need to be delayed
	--by a cycle like the other flags since it comes from MEMIO, which is a cycle ahead.
	--The reason the flags need to be delayed a cycle is that the branch instruction is coming
	--directly after the condition being tested.
	flags_reg: GenReg generic map (size => 4)
	                  port map (clock => clock,
										 enable => '1', 
										 reset => reset, 
										 data => flags(3 downto 0), 
										 output => flags_reg_out);

end Behavioral;

