library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity prog_counter is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  
		  load : in std_logic;
		  increment : in std_logic
		 );		  
end prog_counter;

architecture Behavioral of prog_counter is

signal program_counter : std_logic_vector(31 downto 0); --The actual register
signal program_counter_inc : std_logic_vector(31 downto 0); --The incremented value

begin

	main : process (clk, rst) is
	begin
		if rst = '1' then
			program_counter <= (others => '0');
		elsif falling_edge(clk) then
			if load = '1' then
				program_counter <= data_in;
			end if;
			
			if increment = '1' then
				program_counter <= program_counter_inc;
			end if;
		end if;
	end process;
	
	data_out <= program_counter;
	program_counter_inc <= program_counter + 1;

end Behavioral;

