----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--Module Title: GenRegFalling
--Module Description:
--	This is a general-purpose, falling edge triggered, resizeable register
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GenRegFalling is
	 generic (size: integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end GenRegFalling;

architecture Behavioral of GenRegFalling is

begin

	main: process (clock, reset) is
		variable data_reg : STD_LOGIC_VECTOR((size - 1) downto 0);
	begin
		if falling_edge(clock) then
			if reset = '1' then
				data_reg := (others => '0');
			elsif enable = '1' then
				data_reg := data;
			end if;
		end if;
		output <= data_reg;
	end process;


end Behavioral;

