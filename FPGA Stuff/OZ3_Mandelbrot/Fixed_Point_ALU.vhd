library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library ieee_proposed;
use ieee.fixed_float_types.all;
use ieee.fixed_pkg.all;

entity Fixed_Point_ALU is
	port( clk : in std_logic;
	      rst : in std_logic;
		  A : in std_logic_vector(31 downto 0);
		  B : in std_logic_vector(31 downto 0);
		  result : out std_logic_vector(31 downto 0);
		  sel : in std_logic);
end Fixed_Point_ALU;

architecture behavioral of Fixed_Point_ALU is 

signal A_fixed : sfixed(2 downto -29);
signal B_fixed : sfixed(2 downto -29);

signal result_fixed : sfixed(2 downto -29);

begin
	
	--reg_inputs : process(clk, rst)
--	begin		
--		if rst = '1' then
--			A_fixed <= (others => '0');
--			B_fixed <= (others => '0');
--		elsif rising_edge(clk) then
--			A_fixed <= to_sfixed(A, 2, -29);
--			B_fixed <= to_sfixed(B, 2, -29);
--		end if;
--	end process;
	
	A_fixed <= to_sfixed(A, 2, -29);
	B_fixed <= to_sfixed(B, 2, -29);
	
	process (A_fixed, B_fixed, sel)
	begin
		if sel = '1' then --multiply
			result_fixed <= resize(A_fixed * B_fixed, result_fixed'high, result_fixed'low);
			result <= to_slv(result_fixed);
		else --divide
			result_fixed <= resize(A_fixed / B_fixed, result_fixed'high, result_fixed'low);
			result <= to_slv(result_fixed);
		end if;
	end process;
	
end behavioral;

		 