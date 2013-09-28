library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity data_memory is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  address : in std_logic_vector(31 downto 0);
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  we : in std_logic);		  
end data_memory;

architecture Behavioral of data_memory is

type memory_data_type is array (63 downto 0) of std_logic_vector(31 downto 0); --256 B of data memory
signal memory_data : memory_data_type;

signal address_short : std_logic_vector(5 downto 0);

begin

	address_short <= address(5 downto 0);

	main : process (clk, rst) is
	begin
		if rst = '1' then
			memory_data <= (others => (others => '0'));
		elsif falling_edge(clk) then
			if we = '1' then
				memory_data(conv_integer(unsigned(address_short))) <= data_in;
			end if;
		end if;
	end process;
	
	data_out <= memory_data(conv_integer(unsigned(address_short)));

end Behavioral;

