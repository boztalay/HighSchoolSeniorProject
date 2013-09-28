----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: ALU
--Module Description:
--	The Arithmetic and Logic Unit of the OZ-3. It handles two 32-bit
-- inputs and performs one of ten operations, being:
-- 	addition, subtraction, AND, OR, XOR, shift left, shift right,
--		rotate left, rotate right, and compare.
--	Rotations and shifts are one bit at a time only, and the compare
--	operation simply passes input A through. All analysis of the inputs
--	is done continuously and parallel to normal operation.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
           flags : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is

begin

	main: process(A, B, sel) is
		variable output : STD_LOGIC_VECTOR(32 downto 0);
	begin
		--Set flags to 0 as default
		flags <= "0000";
		
		--This actually performs the operation chosen by the select lines
		--The reason the output variable is 33 bits wide is to accomodate for
		--the carry bit, and it also helps a lot with shifting operations. By
		--the way, I did try the built-in shift operations, but without much
		--luck.
		case sel is 
			when "0000" => --add
				output := ('0' & A(31 downto 0)) + ('0' & B(31 downto 0));
			when "0001" => --sub
				output := ('0' & A(31 downto 0)) - ('0' & B(31 downto 0));
			when "0010" => --and
				output := '0' & (A and B);
			when "0011" => --or
				output := '0' & (A or B);
			when "0100" => --xor
				output := '0' & (A xor B);
			when "0101" => --cp
				output := ('0' & A);
			when "0110" => --sll
				output := (A(31 downto 0) & '0');
			when "0111" => --srl
				output := ("00" & A(31 downto 1));
			when "1000" => --rol
				output := (A(0) & A(0) & A(31 downto 1));
			when "1001" => --ror
				output := (A(30) & A(30 downto 0) & A(31));
			when others =>
			   output := ('0' & A);
		end case;
		
		--This if statement generates the flags
		if (A > B) then --Greater than
			flags(1) <= '1';
		elsif (A = B) then --Equal to
			flags(2) <= '1';
		elsif (A < B) then --Less than
			flags(3) <= '1';
		end if;
		flags(0) <= output(32); --Carry flag (33rd bit)
		
		result <= output(31 downto 0);
	end process;

end Behavioral;

