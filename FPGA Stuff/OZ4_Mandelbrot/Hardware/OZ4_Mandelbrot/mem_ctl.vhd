library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity memory_control is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  address : in std_logic_vector(31 downto 0);
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  we : in std_logic;
		  
		  mem_addr : out std_logic_vector(31 downto 0);
		  mem_write_data : out std_logic_vector(31 downto 0);
		  mem_read_data : in std_logic_vector(31 downto 0);
		  mem_we : out std_logic;
		  mem_clk : out std_logic
		 );
end memory_control;

architecture behavioral of memory_control is

signal addr_r, data_r : std_logic_vector(31 downto 0);

begin

	--Not much to it, just here so it can be expanded later in need be
	mem_clk <= clk;
	mem_addr <= addr_r;
	mem_write_data <= data_r;
	data_out <= mem_read_data;
	mem_we <= we;
	
	latch : process (clk, rst) is
	begin
		if rst = '1' then
			addr_r <= (others => '0');
			data_r <= (others => '0');
		elsif rising_edge(clk) then
			addr_r <= address;
			data_r <= data_in;
		end if;	
	end process;

end behavioral;

