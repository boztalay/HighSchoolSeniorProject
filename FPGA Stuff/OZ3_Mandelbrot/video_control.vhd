library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity video_control is
	port ( pclk : in std_logic;
	       rst : in std_logic;
		   vidon : in std_logic;
		   vsync : in std_logic;
		   data_from_mem : in std_logic_vector(15 downto 0);
		   red : out std_logic_vector(2 downto 0);
		   green : out std_logic_vector(2 downto 0);
		   blue : out std_logic_vector(1 downto 0);
		   RAM_addr : out std_logic_vector(22 downto 0));
end video_control;

architecture behavioral of video_control is	

--NOTE: may need to register the incoming data from memory

signal top_bottom : std_logic;
signal RAM_addr_count : std_logic_vector(22 downto 0);

begin
	
	addr_cnt_ctl : process (pclk, rst, vsync) is
	begin
		if rst = '1' or vsync = '0' then
			RAM_addr_count <= (others => '0');
		elsif rising_edge(pclk) then
			RAM_addr_count <= RAM_addr_count + 1;
		end if;
	end process;
	RAM_addr <= RAM_addr_count;
	
	color_ctl : process (pclk, rst) is
	begin
		if rst = '1' or vidon = '0' then
			red <= "000";
			green <= "000";
			blue <= "00";
		elsif rising_edge(pclk) then
			if top_bottom = '0' then
				red <= data_from_mem(7 downto 5);
				green <= data_from_mem(4 downto 2);
				blue <= data_from_mem(1 downto 0);
			else
			    red <= data_from_mem(15 downto 13);
				green <= data_from_mem(12 downto 10);
				blue <= data_from_mem(9 downto 8);
			end if;
			top_bottom <= not top_bottom;
		end if;
	end process;
	
end behavioral;
		   