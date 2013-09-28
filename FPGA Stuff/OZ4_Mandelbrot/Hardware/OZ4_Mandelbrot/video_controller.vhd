library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity video_controller is
	port(
		clk : in std_logic;
		rst : in std_logic;
		
		trippy : in std_logic;
		
		red : out std_logic_vector(2 downto 0);
		green : out std_logic_vector(2 downto 0);
		blue : out std_logic_vector(1 downto 0);
		
		vidon : in std_logic;
		
		RAM_data_in : in std_logic_vector(15 downto 0);
		RAM_addr : out std_logic_vector(31 downto 0));
end video_controller;

architecture Behavioral of video_controller is

signal clk_half : std_logic;
signal RAM_addr_reg : std_logic_vector(31 downto 0);
signal colors : std_logic_vector(7 downto 0);

signal pre_colors : std_logic_vector(7 downto 0);
signal clk_div : std_logic_vector(24 downto 0);
signal trippy_ctr : std_logic_vector(2 downto 0);

begin

	clk_synth : process (clk, rst) is
	begin
		if rst = '1' then
			clk_half <= '0';
		elsif rising_edge(clk) then
			clk_half <= not clk_half;
		end if;
	end process;
	
	addr_inc : process (clk_half, rst) is
	begin
		if rst = '1' then
			RAM_addr_reg <= (others => '0');
		elsif rising_edge(clk_half) then
			if vidon = '1' then
				if RAM_addr_reg = 153599 then
					RAM_addr_reg <= (others => '0');
				else
					RAM_addr_reg <= RAM_addr_reg + 1;
				end if;
			end if;
		end if;
	end process;
	RAM_addr <= RAM_addr_reg;
	
	color_data : process (clk, rst) is
	begin
		if rst = '1' then
			pre_colors <= (others => '0');
		elsif rising_edge(clk) then
			if clk_half = '0' then
				pre_colors <= RAM_data_in(7 downto 0);
			else
				pre_colors <= RAM_data_in(15 downto 8);
			end if;
		end if;
	end process;
	
	clkdiv : process (clk, rst) is
	begin
		if rst = '1' then
			clk_div <= (others => '0');
		elsif rising_edge(clk) then
			clk_div <= clk_div + 1;
		end if;	
	end process;
	
	tripomatic : process (clk_div, rst, trippy_ctr) is
	begin
		if rst = '1' then
			trippy_ctr <= "000";
		elsif rising_edge(clk_div(21)) then
			if trippy = '1' then
				trippy_ctr <= trippy_ctr + 1;
			end if;
		end if;
		
		case (trippy_ctr) is
			when "000" => 
				colors <= pre_colors;
			when "001" => 
				colors <= pre_colors(0) & pre_colors(7 downto 1);
			when "010" => 
				colors <= pre_colors(1 downto 0) & pre_colors(7 downto 2);
			when "011" => 
				colors <= pre_colors(2 downto 0) & pre_colors(7 downto 3);
			when "100" => 
				colors <= pre_colors(3 downto 0) & pre_colors(7 downto 4);
			when "101" => 
				colors <= pre_colors(4 downto 0) & pre_colors(7 downto 5);
			when "110" => 
				colors <= pre_colors(5 downto 0) & pre_colors(7 downto 6);
			when "111" => 
				colors <= pre_colors(6 downto 0) & pre_colors(7 downto 7);
			when others =>
				colors <= pre_colors;
		end case;	
	end process;			
	
	send_colors : process (vidon, colors) is
	begin
		red <= "000";
		green <= "000";
		blue <= "00";
		
		if vidon = '1' then
			red <= colors(7 downto 5);
			green <= colors(4 downto 2);
			blue <= colors(1 downto 0);
		end if;
	end process;

end Behavioral;

