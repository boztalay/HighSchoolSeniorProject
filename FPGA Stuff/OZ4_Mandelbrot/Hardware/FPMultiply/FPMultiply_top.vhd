library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;  

entity FPMultiply_top is
	port(switches : in std_logic_vector(7 downto 0);
		  result : out std_logic_vector(7 downto 0));
end FPMultiply_top;

architecture Behavioral of FPMultiply_top is

component FPMultiply is
	port( A : in std_logic_vector(31 downto 0);
			B : in std_logic_vector(31 downto 0);
			R : out std_logic_vector(31 downto 0));
end component;

signal result_s : std_logic_vector(31 downto 0);
signal A_s, B_s : std_logic_vector(31 downto 0);

begin

	A_s <= x"0000000" & switches(3 downto 0);
	B_s <= x"0000000" & switches(7 downto 4);

	fpm : FPMultiply
		port map( A => A_s,
					 B => B_s,
					 R => result_s);

	result <= result_s(7 downto 0);
	
end Behavioral;

