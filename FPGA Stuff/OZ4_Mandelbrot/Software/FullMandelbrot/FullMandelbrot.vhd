library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity immediate_memory is
	port(immediate_addr : in std_logic_vector(5 downto 0);
		  immediate_out : out std_logic_vector(31 downto 0));
end immediate_memory;

architecture Behavioral of immediate_memory is

type immediate_data_type is array (63 downto 0) of std_logic_vector(31 downto 0);
signal immediate_data : immediate_data_type;

begin

	immediate_out <= immediate_data(conv_integer(unsigned(immediate_addr)));

	immediate_data(0) <= x"00000000";
	immediate_data(1) <= x"00000001";
	immediate_data(2) <= x"e0000000";
	immediate_data(3) <= x"20000000";
	immediate_data(4) <= x"00000002";
	immediate_data(5) <= x"00000003";
	immediate_data(6) <= x"00000004";
	immediate_data(7) <= x"00000005";
	immediate_data(8) <= x"00000006";
	immediate_data(9) <= x"00000007";
	immediate_data(10) <= x"00000019";
	immediate_data(11) <= x"0000001f";
	immediate_data(12) <= x"00000032";
	immediate_data(13) <= x"000000ff";
	immediate_data(14) <= x"40000000";
	immediate_data(15) <= x"0000006c";
	immediate_data(16) <= x"00000099";
	immediate_data(17) <= x"000000a5";
	immediate_data(18) <= x"00190000";
	immediate_data(19) <= x"00000280";
	immediate_data(20) <= x"000000bd";
	immediate_data(21) <= x"ffde0000";
	immediate_data(22) <= x"000001e0";
	immediate_data(23) <= x"000000d5";
	immediate_data(24) <= x"000000d8";

end Behavioral;