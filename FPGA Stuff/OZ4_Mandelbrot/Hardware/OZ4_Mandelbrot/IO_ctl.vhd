library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity IO_ctl is
	port(clk : in std_logic;
		 rst : in std_logic;
		 
		 iport : in std_logic_vector(31 downto 0);
		 iport_data : out std_logic_vector(31 downto 0);
		 
		 ipins : in std_logic_vector(7 downto 0);
		 ipins_data : out std_logic_vector(31 downto 0);
		 ipins_sel : in std_logic_vector(2 downto 0);
		 
		 oport : out std_logic_vector(31 downto 0);
		 oport_data : in std_logic_vector(31 downto 0);
		 oport_en : in std_logic;
		 
		 opins : out std_logic_vector(7 downto 0);
		 opins_data : in std_logic_vector(31 downto 0);
		 opins_sel : in std_logic_vector(2 downto 0);
		 opins_en : in std_logic
	);
end IO_ctl;

architecture behavioral of IO_ctl is 

signal iport_reg : std_logic_vector(31 downto 0);
signal ipins_reg : std_logic_vector(7 downto 0);
signal oport_reg : std_logic_vector(31 downto 0);
signal opins_reg : std_logic_vector(7 downto 0);

begin
	
	iport_ctl : process (clk, rst) is
	begin
		if rst = '1' then
			iport_reg <= (others => '0');
		elsif rising_edge(clk) then
			iport_reg <= iport;
		end if;
	end process;
	iport_data <= iport_reg;
	
	ipins_ctl : process (clk, rst) is
	begin
		if rst = '1' then
			ipins_reg <= (others => '0');
		elsif rising_edge(clk) then
			ipins_reg <= ipins;
		end if;
	end process;
	ipins_data <= "0000000000000000000000000000000" & ipins_reg(conv_integer(unsigned(ipins_sel)));
	
	oport_ctl : process (clk, rst) is
	begin
		if rst = '1' then
			oport_reg <= (others => '0');
		elsif falling_edge(clk) then
			if oport_en = '1' then
				oport_reg <= oport_data;
			end if;
		end if;
	end process;
	oport <= oport_reg;
	
	opins_ctl : process (clk, rst) is
	begin
		if rst = '1' then
			opins_reg <= (others => '0');
		elsif falling_edge(clk) then
			if opins_en = '1' then
				opins_reg(conv_integer(unsigned(opins_sel))) <= opins_data(0);
			end if;
		end if;
	end process;
	opins <= opins_reg;

end behavioral;