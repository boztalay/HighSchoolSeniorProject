library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity sim_top_TB is
end sim_top_TB;

architecture Behavioral of sim_top_TB is

component sim_top is
	port(clk : in std_logic;
		  rst : in std_logic);
end component;

signal rst, clk : std_logic;

begin

	uut : sim_top
	port map(clk => clk,
				rst => rst);
				
	clocker : process is
	begin
		clk <= '1';
		wait for 10 ns;
		clk <= '0';
		wait for 10 ns;
	end process;
	
	stim : process is
	begin
		rst <= '1';
		wait for 1000 ns;
		rst <= '0';
		wait;
	end process;
	
end Behavioral;

