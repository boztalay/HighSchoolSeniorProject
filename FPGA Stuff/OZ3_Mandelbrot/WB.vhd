----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: WB
--Module Description:
--	The writeback stage. All this does is writes the data given to it by the MEMIO
-- stage to the register file at the address given to it by the instruction
-- decoder. If no data is to be written, it just writes to address 0, which
-- the register file is designed to not respond to.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WB is
	Port ( clock : in STD_LOGIC;
	       reset : in STD_LOGIC;
			 data_from_MEM : in STD_LOGIC_VECTOR(31 downto 0);
			 cntl_from_ID  : in STD_LOGIC_VECTOR(5 downto 0);
			 rfile_write_data_to_ID : out STD_LOGIC_VECTOR(31 downto 0); --These two outputs also used for
			 rfile_write_addr_to_ID : out STD_LOGIC_VECTOR(4 downto 0);  --forwarding logic
			 rfile_write_e_to_ID   : out STD_LOGIC);
end WB;

architecture Behavioral of WB is

--//Component Declarations\\--

--Generic rising-edge-triggered register
component GenReg is
	 generic (size: integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end component;

--\\Component Declarations//--

--//Signal Declarations\\--

--These signals are used between the three registers that make up the three-stage
--buffer that delays the incoming control signals from the instruction decoder
signal buffer_1_2 : STD_LOGIC_VECTOR(5 downto 0);
signal buffer_2_3 : STD_LOGIC_VECTOR(5 downto 0);
signal buffer_out : STD_LOGIC_VECTOR(5 downto 0);

--\\Signal Declarations//--

begin

	--The input register for the stage
	in_reg: GenReg generic map (size => 32)
					   port map (clock => clock,
									 enable => '1', 
									 reset => reset, 
									 data => data_from_MEM, 
									 output => rfile_write_data_to_ID);
									 
	--The buffer's registers
	buf1 : GenReg generic map (size => 6)
					  port map (clock => clock, 
									enable => '1', 
									reset => reset,
									data => cntl_from_ID, 
									output => buffer_1_2);
	buf2 : GenReg generic map (size => 6)
					  port map (clock => clock, 
									enable => '1', 
									reset => reset, 
									data => buffer_1_2, 
									output => buffer_2_3);
	buf3 : GenReg generic map (size => 6)
					  port map (clock => clock, 
									enable => '1', 
									reset => reset, 
									data => buffer_2_3,
									output => buffer_out);
					  
	--These signals, the write address and write enable for the register
	--file, go straight to the ID stage. The data to be written is simply
	--the output of the input register
	rfile_write_addr_to_ID <= buffer_out(5 downto 1);
	rfile_write_e_to_ID  <= buffer_out(0);

end Behavioral;

