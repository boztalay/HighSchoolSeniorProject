library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity instruction_memory is
	port(address : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(11 downto 0);
		  immediate_addr : in std_logic_vector(5 downto 0);
		  immediate_out : out std_logic_vector(31 downto 0));
end instruction_memory;

architecture Behavioral of instruction_memory is

type instruction_data_type is array (4095 downto 0) of std_logic_vector(11 downto 0); --4 kB of data memory
signal instruction_data : instruction_data_type;

type immediate_data_type is array (63 downto 0) of std_logic_vector(31 downto 0);
signal immediate_data : immediate_data_type;

signal address_short : std_logic_vector(11 downto 0);

begin

	address_short <= address(11 downto 0);

	data_out <= instruction_data(conv_integer(unsigned(address_short)));
	immediate_out <= immediate_data(conv_integer(unsigned(immediate_addr)));

	immediate_data(0) <= x"00000001";
	immediate_data(1) <= x"00000002";
	immediate_data(2) <= x"00000004";
	immediate_data(3) <= x"00000008";
	immediate_data(4) <= x"0000002c";
	immediate_data(5) <= x"00000041";
	instruction_data(1) <= "010100000000";
	instruction_data(2) <= "010100000001";
	instruction_data(3) <= "010100000010";
	instruction_data(4) <= "010100000011";
	instruction_data(5) <= "000001000000";
	instruction_data(6) <= "000001000000";
	instruction_data(7) <= "000001000000";
	instruction_data(8) <= "010100000100";
	instruction_data(9) <= "010100000101";
	instruction_data(10) <= "010011000000";
	instruction_data(11) <= "010101000000";
	instruction_data(12) <= "011001000000";
	instruction_data(13) <= "010000000000";
	instruction_data(14) <= "010001000000";
	instruction_data(15) <= "011010000000";
	instruction_data(16) <= "000001000000";
	instruction_data(17) <= "010001000000";
	instruction_data(18) <= "010000000000";
	instruction_data(19) <= "010000000000";


end Behavioral;