----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: RegFile
--Module Description:
--	The register file of the OZ-3. It holds 32 32-bit registers,
-- with register 0 hardwired to 0. It has three outputs and one
-- input port, with four address ports to go with each. All of the
-- ports can be used at once, and the register file writes on
-- the falling edge. If it's being written to at address 0, the register
-- file simply doesn't respond.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegFile is
	Port ( clock : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 write_e : in STD_LOGIC;
			 data_in : in STD_LOGIC_VECTOR(31 downto 0);
			 r_addr1 : in STD_LOGIC_VECTOR(4 downto 0);
			 r_addr2 : in STD_LOGIC_VECTOR(4 downto 0);
			 r_addr3 : in STD_LOGIC_VECTOR(4 downto 0);
			 w_addr1 : in STD_LOGIC_VECTOR(4 downto 0);
			 data_out_1 : out STD_LOGIC_VECTOR(31 downto 0); --Operand A
			 data_out_2 : out STD_LOGIC_VECTOR(31 downto 0); --Operand B
			 data_out_3 : out STD_LOGIC_VECTOR(31 downto 0)); --Data to write to memory or mix with incoming data
end RegFile;															  --from memory

architecture Behavioral of RegFile is

begin
	
	--The main process of the register file
	main: process (clock, reset, r_addr1, r_addr2, r_addr3) is
		type reg_array is array (31 downto 0) of                --This new type of array was made to make a
			STD_LOGIC_VECTOR(31 downto 0);							  --2D array of 32x32
		variable reg_file: reg_array := (others => x"00000000");
	begin
		if falling_edge(clock) then
			if reset = '1' then --Reset
				reg_file := (others => x"00000000");
			elsif write_e = '1' then --If it's a write operation
				if w_addr1 /= b"00000" then --and if address zero isn't trying to be written to
					reg_file(conv_integer(unsigned(w_addr1))) := data_in; --then write to the array
				end if;
			end if;
		end if;
		
		--All of the data outputs are asynchronous
		data_out_1 <= reg_file(conv_integer(unsigned(r_addr1)));
		data_out_2 <= reg_file(conv_integer(unsigned(r_addr2)));
		data_out_3 <= reg_file(conv_integer(unsigned(r_addr3)));
	end process;

end Behavioral;

