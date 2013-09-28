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

	immediate_data(0) <= x"00000000";
	immediate_data(1) <= x"80000000";
	immediate_data(2) <= x"06660000";
	immediate_data(3) <= x"08cc0000";
	immediate_data(4) <= x"00000001";
	immediate_data(5) <= x"00000012";
	immediate_data(6) <= x"20000000";
	immediate_data(7) <= x"00000002";
	immediate_data(8) <= x"00000003";
	immediate_data(9) <= x"000000ff";
	immediate_data(10) <= x"40000000";
	immediate_data(11) <= x"00000049";
	immediate_data(12) <= x"0000004c";
	instruction_data(1) <= "010100000001";
	instruction_data(2) <= "110011000000";
	instruction_data(3) <= "010100000010";
	instruction_data(4) <= "010100000000";
	instruction_data(5) <= "110001000000";
	instruction_data(6) <= "010100000011";
	instruction_data(7) <= "010100000100";
	instruction_data(8) <= "110001000000";
	instruction_data(9) <= "010100000011";
	instruction_data(10) <= "010101000000";
	instruction_data(11) <= "001011000000";
	instruction_data(12) <= "010100000010";
	instruction_data(13) <= "010101000000";
	instruction_data(14) <= "001011000000";
	instruction_data(15) <= "010100000011";
	instruction_data(16) <= "010100000011";
	instruction_data(17) <= "010100000010";
	instruction_data(18) <= "001011000000";
	instruction_data(19) <= "010100000110";
	instruction_data(20) <= "001011000000";
	instruction_data(21) <= "000001000000";
	instruction_data(22) <= "010010000000";
	instruction_data(23) <= "010100000000";
	instruction_data(24) <= "110000000000";
	instruction_data(25) <= "010010000000";
	instruction_data(26) <= "000010000000";
	instruction_data(27) <= "000001000000";
	instruction_data(28) <= "010001000000";
	instruction_data(29) <= "010101000000";
	instruction_data(30) <= "010101000000";
	instruction_data(31) <= "001011000000";
	instruction_data(32) <= "010101000000";
	instruction_data(33) <= "010100000111";
	instruction_data(34) <= "110001000000";
	instruction_data(35) <= "010010000000";
	instruction_data(36) <= "011010000000";
	instruction_data(37) <= "010101000000";
	instruction_data(38) <= "001011000000";
	instruction_data(39) <= "010101000000";
	instruction_data(40) <= "010100000111";
	instruction_data(41) <= "110000000000";
	instruction_data(42) <= "000001000000";
	instruction_data(43) <= "010100000111";
	instruction_data(44) <= "110001000000";
	instruction_data(45) <= "010010000000";
	instruction_data(46) <= "010001000000";
	instruction_data(47) <= "010100000100";
	instruction_data(48) <= "110000000000";
	instruction_data(49) <= "010010000000";
	instruction_data(50) <= "010100001000";
	instruction_data(51) <= "110000000000";
	instruction_data(52) <= "010100000100";
	instruction_data(53) <= "000001000000";
	instruction_data(54) <= "010100001001";
	instruction_data(55) <= "000110000000";
	instruction_data(56) <= "010000000000";
	instruction_data(57) <= "010100001000";
	instruction_data(58) <= "110001000000";
	instruction_data(59) <= "010100000111";
	instruction_data(60) <= "010100001011";
	instruction_data(61) <= "100001000000";
	instruction_data(62) <= "010100000111";
	instruction_data(63) <= "110000000000";
	instruction_data(64) <= "010100001010";
	instruction_data(65) <= "000110000000";
	instruction_data(66) <= "010000000000";
	instruction_data(67) <= "010000000000";
	instruction_data(68) <= "010100001000";
	instruction_data(69) <= "010100001011";
	instruction_data(70) <= "100001000000";
	instruction_data(71) <= "010100000101";
	instruction_data(72) <= "100000000000";
	instruction_data(73) <= "010100001000";
	instruction_data(74) <= "110000000000";
	instruction_data(75) <= "110011000000";
	instruction_data(76) <= "010100001100";
	instruction_data(77) <= "100000000000";


end Behavioral;