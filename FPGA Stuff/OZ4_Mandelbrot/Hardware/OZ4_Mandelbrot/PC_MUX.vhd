library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity PC_MUX is
	port(sel : in std_logic;
		
		  RS_top : in std_logic_vector(31 downto 0);
		  stack_e0 : in std_logic_vector(31 downto 0);
		  
		  output : out std_logic_vector(31 downto 0));		  
end PC_MUX;

architecture Behavioral of PC_MUX is

begin

	main : process(sel, RS_top, stack_e0) is
	begin
		if sel = '0' then
			output <= stack_e0;
		else
			output <= RS_top;
		end if;
	end process;

end Behavioral;

