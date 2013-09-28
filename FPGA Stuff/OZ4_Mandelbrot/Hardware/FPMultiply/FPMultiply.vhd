library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity FPMultiply is
	port( A_in : in std_logic_vector(31 downto 0);
			B_in : in std_logic_vector(31 downto 0);
			R : out std_logic_vector(31 downto 0));
end FPMultiply;

architecture Behavioral of FPMultiply is

type array32x64 is array (31 downto 0) of std_logic_vector(63 downto 0);
signal shiftArray : array32x64;-- := (others => (others => '0'));

signal resultRaw : std_logic_vector(63 downto 0) := (others => '0');
signal resultCut, resultSigned : std_logic_vector(31 downto 0) := (others => '0');

signal A, B : std_logic_vector(31 downto 0);
signal sign : std_logic;

begin

	signs : process (A_in, B_in) is
	begin
		sign <= A_in(31) xor B_in(31); --Sign is 0 if the result is positive, 1 if negative
		
		--Flip A if it's negative
		if A_in(31) = '1' then
			A <= (not A_in) + 1;
		else
			A <= A_in;
		end if;
		
		--Flip B if it's negative
		if B_in(31) = '1' then
			B <= (not B_in) + 1;
		else
			B <= B_in;
		end if;		
	end process;

	shift_mul : process (A, B) is
	begin
	
		if B(0) = '1' then
			shiftArray(0) <= "00000000000000000000000000000000" & A;
		else
			shiftArray(0) <= (others => '0');
		end if;
		
		if B(1) = '1' then
			shiftArray(1) <= "0000000000000000000000000000000" & A & "0";
		else
			shiftArray(1) <= (others => '0');
		end if;
		
		if B(2) = '1' then
			shiftArray(2) <= "000000000000000000000000000000" & A & "00";
		else
			shiftArray(2) <= (others => '0');
		end if;
		
		if B(3) = '1' then
			shiftArray(3) <= "00000000000000000000000000000" & A & "000";
		else
			shiftArray(3) <= (others => '0');
		end if;
		
		if B(4) = '1' then
			shiftArray(4) <= "0000000000000000000000000000" & A & "0000";
		else
			shiftArray(4) <= (others => '0');
		end if;
		
		if B(5) = '1' then
			shiftArray(5) <= "000000000000000000000000000" & A & "00000";
		else
			shiftArray(5) <= (others => '0');
		end if;
		
		if B(6) = '1' then
			shiftArray(6) <= "00000000000000000000000000" & A & "000000";
		else
			shiftArray(6) <= (others => '0');
		end if;
		
		if B(7) = '1' then
			shiftArray(7) <= "0000000000000000000000000" & A & "0000000";
		else
			shiftArray(7) <= (others => '0');
		end if;
		
		if B(8) = '1' then
			shiftArray(8) <= "000000000000000000000000" & A & "00000000";
		else
			shiftArray(8) <= (others => '0');
		end if;
		
		if B(9) = '1' then
			shiftArray(9) <= "00000000000000000000000" & A & "000000000";
		else
			shiftArray(9) <= (others => '0');
		end if;
		
		if B(10) = '1' then
			shiftArray(10) <= "0000000000000000000000" & A & "0000000000";
		else
			shiftArray(10) <= (others => '0');
		end if;
		
		if B(11) = '1' then
			shiftArray(11) <= "000000000000000000000" & A & "00000000000";
		else
			shiftArray(11) <= (others => '0');
		end if;
		
		if B(12) = '1' then
			shiftArray(12) <= "00000000000000000000" & A & "000000000000";
		else
			shiftArray(12) <= (others => '0');
		end if;
		
		if B(13) = '1' then
			shiftArray(13) <= "0000000000000000000" & A & "0000000000000";
		else
			shiftArray(13) <= (others => '0');
		end if;
		
		if B(14) = '1' then
			shiftArray(14) <= "000000000000000000" & A & "00000000000000";
		else
			shiftArray(14) <= (others => '0');
		end if;
		
		if B(15) = '1' then
			shiftArray(15) <= "00000000000000000" & A & "000000000000000";
		else
			shiftArray(15) <= (others => '0');
		end if;
		
		if B(16) = '1' then
			shiftArray(16) <= "0000000000000000" & A & "0000000000000000";
		else
			shiftArray(16) <= (others => '0');
		end if;
		
		if B(17) = '1' then
			shiftArray(17) <= "000000000000000" & A & "00000000000000000";
		else
			shiftArray(17) <= (others => '0');
		end if;
		
		if B(18) = '1' then
			shiftArray(18) <= "00000000000000" & A & "000000000000000000";
		else
			shiftArray(18) <= (others => '0');
		end if;
		
		if B(19) = '1' then
			shiftArray(19) <= "0000000000000" & A & "0000000000000000000";
		else
			shiftArray(19) <= (others => '0');
		end if;
		
		if B(20) = '1' then
			shiftArray(20) <= "000000000000" & A & "00000000000000000000";
		else
			shiftArray(20) <= (others => '0');
		end if;
		
		if B(21) = '1' then
			shiftArray(21) <= "00000000000" & A & "000000000000000000000";
		else
			shiftArray(21) <= (others => '0');
		end if;
		
		if B(22) = '1' then
			shiftArray(22) <= "0000000000" & A & "0000000000000000000000";
		else
			shiftArray(22) <= (others => '0');
		end if;
		
		if B(23) = '1' then
			shiftArray(23) <= "000000000" & A & "00000000000000000000000";
		else
			shiftArray(23) <= (others => '0');
		end if;
		
		if B(24) = '1' then
			shiftArray(24) <= "00000000" & A & "000000000000000000000000";
		else
			shiftArray(24) <= (others => '0');
		end if;
		
		if B(25) = '1' then
			shiftArray(25) <= "0000000" & A & "0000000000000000000000000";
		else
			shiftArray(25) <= (others => '0');
		end if;
		
		if B(26) = '1' then
			shiftArray(26) <= "000000" & A & "00000000000000000000000000";
		else
			shiftArray(26) <= (others => '0');
		end if;
		
		if B(27) = '1' then
			shiftArray(27) <= "00000" & A & "000000000000000000000000000";
		else
			shiftArray(27) <= (others => '0');
		end if;
		
		if B(28) = '1' then
			shiftArray(28) <= "0000" & A & "0000000000000000000000000000";
		else
			shiftArray(28) <= (others => '0');
		end if;
		
		if B(29) = '1' then
			shiftArray(29) <= "000" & A & "00000000000000000000000000000";
		else
			shiftArray(29) <= (others => '0');
		end if;
		
		if B(30) = '1' then
			shiftArray(30) <= "00" & A & "000000000000000000000000000000";
		else
			shiftArray(30) <= (others => '0');
		end if;
		
		if B(31) = '1' then
			shiftArray(31) <= "0" & A & "0000000000000000000000000000000";
		else
			shiftArray(31) <= (others => '0');
		end if;
	end process;
	
	resultRaw <= shiftArray(0)  + shiftArray(1) + shiftArray(2)  + shiftArray(3) + shiftArray(4)  + shiftArray(5) +  shiftArray(6)  + shiftArray(7) +
					 shiftArray(8)  + shiftArray(9) + shiftArray(10) + shiftArray(11) + shiftArray(12) + shiftArray(13) +  shiftArray(14) + shiftArray(15) +
					 shiftArray(16) + shiftArray(17) + shiftArray(18) + shiftArray(19) + shiftArray(20) + shiftArray(21) + shiftArray(22) + shiftArray(23) +
					 shiftArray(24) + shiftArray(25) + shiftArray(26) + shiftArray(27) + shiftArray(28) + shiftArray(29) + shiftArray(30) + shiftArray(31);

	saturate : process(resultRaw) is
	begin
		if resultRaw(59 downto 0) > x"07FFFFFFFFFFFFFF" then
			resultCut <= x"7FFFFFFF";
		else
			resultCut <= resultRaw(59 downto 28); --Take the middle out as the result
		end if;
	end process;
	
	apply_sign : process(sign, resultCut) is
	begin
		if sign = '1' then
			resultSigned <= (not resultCut) + 1;
		else
			resultSigned <= resultCut;
		end if;
	end process;

	R <= resultSigned;

end Behavioral;

