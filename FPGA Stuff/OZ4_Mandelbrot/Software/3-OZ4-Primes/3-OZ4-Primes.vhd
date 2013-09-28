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
	immediate_data(2) <= x"00000002";
	immediate_data(3) <= x"00000003";
	immediate_data(4) <= x"00000004";
	immediate_data(5) <= x"00000010";
	immediate_data(6) <= x"00000010";
	immediate_data(7) <= x"00000013";
	immediate_data(8) <= x"00000025";
	immediate_data(9) <= x"0000000b";
	immediate_data(10) <= x"0000003b";
	immediate_data(11) <= x"00000053";
	immediate_data(12) <= x"0000005b";

end Behavioral;