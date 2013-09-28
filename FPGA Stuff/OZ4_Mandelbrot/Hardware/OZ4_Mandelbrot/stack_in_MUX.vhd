library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity stack_in_MUX is
	port(sel : in std_logic_vector(2 downto 0);
		
		  ctl_immediate : in std_logic_vector(31 downto 0);
		  ALU_result : in std_logic_vector(31 downto 0);
		  IO_ipins_data : in std_logic_vector(31 downto 0);
		  IO_iport_data : in std_logic_vector(31 downto 0);
		  mem_data_out : in std_logic_vector(31 downto 0);
		  
		  output : out std_logic_vector(31 downto 0));
end stack_in_MUX;

architecture Behavioral of stack_in_MUX is

begin

	main : process(sel, ctl_immediate, ALU_result, IO_ipins_data, IO_iport_data, mem_data_out) is
	begin
		case (sel) is
			when "000" =>
				output <= ctl_immediate;
			when "001" =>
				output <= ALU_result;
			when "010" =>
				output <= IO_ipins_data;
			when "011" =>
				output <= IO_iport_data;
			when others =>
				output <= mem_data_out;
		end case;	
	end process;

end Behavioral;

