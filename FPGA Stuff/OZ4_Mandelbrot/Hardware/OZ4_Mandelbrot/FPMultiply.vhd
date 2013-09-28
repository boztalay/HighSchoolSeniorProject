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

type array16x32 is array (15 downto 0) of std_logic_vector(31 downto 0);
signal shiftArray : array16x32;-- := (others => (others => '0'));

signal resultRaw : std_logic_vector(31 downto 0) := (others => '0');
signal resultCut, resultSigned : std_logic_vector(15  downto 0) := (others => '0');

signal A, B, Ashrt, Bshrt : std_logic_vector(15 downto 0);
signal sign : std_logic;

begin

	Ashrt <= A_in(31 downto 16);
	Bshrt <= B_in(31 downto 16);

	signs : process (Ashrt, Bshrt) is
	begin
		sign <= Ashrt(15) xor Bshrt(15); --Sign is 0 if the result is positive, 1 if negative
		
		--Flip A if it's negative
		if Ashrt(15) = '1' then
			A <= (not Ashrt) + 1;
		else
			A <= Ashrt;
		end if;
		
		--Flip B if it's negative
		if Bshrt(15) = '1' then
			B <= (not Bshrt) + 1;
		else
			B <= Bshrt;
		end if;		
	end process;

	shift_mul : process (A, B) is
	begin
	
		if B(0) = '1' then
			shiftArray(0) <= "0000000000000000" & A;
		else
			shiftArray(0) <= (others => '0');
		end if;
		
		if B(1) = '1' then
			shiftArray(1) <= "000000000000000" & A & "0";
		else
			shiftArray(1) <= (others => '0');
		end if;
		
		if B(2) = '1' then
			shiftArray(2) <= "00000000000000" & A & "00";
		else
			shiftArray(2) <= (others => '0');
		end if;
		
		if B(3) = '1' then
			shiftArray(3) <= "0000000000000" & A & "000";
		else
			shiftArray(3) <= (others => '0');
		end if;
		
		if B(4) = '1' then
			shiftArray(4) <= "000000000000" & A & "0000";
		else
			shiftArray(4) <= (others => '0');
		end if;
		
		if B(5) = '1' then
			shiftArray(5) <= "00000000000" & A & "00000";
		else
			shiftArray(5) <= (others => '0');
		end if;
		
		if B(6) = '1' then
			shiftArray(6) <= "0000000000" & A & "000000";
		else
			shiftArray(6) <= (others => '0');
		end if;
		
		if B(7) = '1' then
			shiftArray(7) <= "000000000" & A & "0000000";
		else
			shiftArray(7) <= (others => '0');
		end if;
		
		if B(8) = '1' then
			shiftArray(8) <= "00000000" & A & "00000000";
		else
			shiftArray(8) <= (others => '0');
		end if;
		
		if B(9) = '1' then
			shiftArray(9) <= "0000000" & A & "000000000";
		else
			shiftArray(9) <= (others => '0');
		end if;
		
		if B(10) = '1' then
			shiftArray(10) <= "000000" & A & "0000000000";
		else
			shiftArray(10) <= (others => '0');
		end if;
		
		if B(11) = '1' then
			shiftArray(11) <= "00000" & A & "00000000000";
		else
			shiftArray(11) <= (others => '0');
		end if;
		
		if B(12) = '1' then
			shiftArray(12) <= "0000" & A & "000000000000";
		else
			shiftArray(12) <= (others => '0');
		end if;
		
		if B(13) = '1' then
			shiftArray(13) <= "000" & A & "0000000000000";
		else
			shiftArray(13) <= (others => '0');
		end if;
		
		if B(14) = '1' then
			shiftArray(14) <= "00" & A & "00000000000000";
		else
			shiftArray(14) <= (others => '0');
		end if;
		
		if B(15) = '1' then
			shiftArray(15) <= "0" & A & "000000000000000";
		else
			shiftArray(15) <= (others => '0');
		end if;
	end process;
	
	resultRaw <= shiftArray(0) + shiftArray(1) + shiftArray(2)  + shiftArray(3) + shiftArray(4)  + shiftArray(5) +  shiftArray(6)  + shiftArray(7) +
					 shiftArray(8) + shiftArray(9) + shiftArray(10) + shiftArray(11) + shiftArray(12) + shiftArray(13) +  shiftArray(14) + shiftArray(15);

	saturate : process(resultRaw) is
	begin
		if resultRaw > x"07FFFFFF" then
			resultCut <= x"7FFF";
		else
			resultCut <= resultRaw(27 downto 12); --Take the middle out as the result
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

	R <= resultSigned & x"0000";

end Behavioral;

