----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: MEMIO
--Module Description:
--	This is the Memory and I/O stage of the OZ-3, easily the most complex stage.
-- It handles everything that has to do with interfacing with the memory, as
-- well as pin and port I/O. Although it does a lot, most of the logic operates
-- in parallel, so this stage isn't a bottleneck to the rest of the processor.
--
--Control signal catalog: (for my own purposes during debugging)
--		0.	Pin cntl e   	
--		1. Port cntl e          
--		2. RAM cntl e           
--		3.	pchk e				   
--		4.	opin clk e				
--		5.	opin 1/0					
--		6.	oprt clk e				
--		7.	dRAM W/R					
--		8-12. dest/data reg adr						
--		13-17. result reg adr
--		18-19. output MUX sel
--		20. dRAM lower/upper write/read
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEMIO is
	Port ( clock : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 cntl_from_ID : in STD_LOGIC_VECTOR(20 downto 0);
			 ALU_result_from_EX_in : in STD_LOGIC_VECTOR(31 downto 0);
			 RAM_reg_data_from_ID : in STD_LOGIC_VECTOR(31 downto 0);
			 ipin_reg_data : in STD_LOGIC_VECTOR(15 downto 0);
			 iprt_data : in STD_LOGIC_VECTOR(31 downto 0);
			 dRAM_data_in: in STD_LOGIC_VECTOR(31 downto 0);
			 dRAM_data_out : out STD_LOGIC_VECTOR(31 downto 0);
			 dRAM_WR : out STD_LOGIC;
			 dRAM_addr : out STD_LOGIC_VECTOR(22 downto 0);
			 dest_reg_addr_to_ID : out STD_LOGIC_VECTOR(4 downto 0);
			 pflag_to_EX : out STD_LOGIC;
			 opin_clk_e : out STD_LOGIC;
			 opin_select : out STD_LOGIC_VECTOR(3 downto 0);
			 opin_1_0 : out STD_LOGIC;
			 oprt_data : out STD_LOGIC_VECTOR(31 downto 0);
			 oprt_reg_clk_e : out STD_LOGIC;
			 RAM_reg_addr_to_ID : out STD_LOGIC_VECTOR(4 downto 0);
			 data_to_WB : out STD_LOGIC_VECTOR(31 downto 0));
end MEMIO;

architecture Behavioral of MEMIO is

--//Components\\--

--Generic rising-edge-triggered register
component GenReg is
	 generic (size: integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end component;

--Generic falling-edge-triggered register
component GenRegFalling is
	 generic (size: integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end component;

--\\Components//--

--//Signals\\--

--These signals are between the registers that make up the two-stage buffer
--that delays the incoming control lines from the instruction decoder
signal cntl_buffer_1_2 : STD_LOGIC_VECTOR(20 downto 0);
signal cntl_buffer_2_out : STD_LOGIC_VECTOR(20 downto 0);

--This signal carries the output of the register that delays the
--incoming data from the RAM by half a cycle
signal dRAM_data_reg_out : STD_LOGIC_VECTOR(31 downto 0);

--This signal carries a mix of the incoming RAM data and what's currently
--in the register that that data is supposed to go to. Further explained below
signal mixed_dRAM_data : STD_LOGIC_VECTOR(31 downto 0);

--This carries the output of the stage's input register
signal ALU_result_from_EX : STD_LOGIC_VECTOR(31 downto 0);

--\\Signals//--

begin

	--This process handles all of the pin I/O, such as running pin checks and sending signals to the output pin
	--controller
	pins: process (ALU_result_from_EX, cntl_buffer_2_out, ipin_reg_data) is
	begin
		--Default the outputs to 0
		pflag_to_EX <= '0';
		opin_select <= b"0000";
		opin_clk_e <= '0';
		opin_1_0 <= '0';
		
		if cntl_buffer_2_out(0) = '1' then --If this process is active
			--This giant line looks at the input pin register and if the selected pin is 0 or 1. The and
			--operator at the end is the pin check enable signal. If it's 0, meaning the instruction is
			--not a pin check, the flag sent to the condition block is automatically 0.
			pflag_to_EX <= (ipin_reg_data(conv_integer(unsigned(ALU_result_from_EX(3 downto 0)))) and cntl_buffer_2_out(3));
			opin_clk_e <= cntl_buffer_2_out(4); --clock the output pins if it's an opin instruction
			opin_select <= ALU_result_from_EX(3 downto 0); --Choose which output pin to control
			opin_1_0 <= cntl_buffer_2_out(5); --This is the control line that tells the output pin control block
		end if;										 --to output a 1 or 0 on the selected pin
	end process;
	
	--This process takes care of the input and output ports
	ports: process (ALU_result_from_EX, cntl_buffer_2_out, clock) is
	begin
		--Default the outputs to 0
		oprt_data <= x"00000000";
		oprt_reg_clk_e <= '0';
		
		 --If this process is active, send data out. The input port is always taking input, no matter what
		if cntl_buffer_2_out(1) = '1' then
			oprt_data <= ALU_result_from_EX; --Sending data to the output port register
			oprt_reg_clk_e <= (clock and cntl_buffer_2_out(6)); --Enable the output port's clock
		end if;
	end process;
	
	--This one interfaces with the memory bus controller if there needs to be communication with the
	--RAM
	RAM: process (ALU_result_from_EX, cntl_buffer_2_out, RAM_reg_data_from_ID) is
	begin
		--Default the outputs to 0, read operation is default
		dRAM_data_out <= x"00000000";
		dRAM_WR <= '0';
		dRAM_addr <= b"00000000000000000000000";
		
		if cntl_buffer_2_out(2) = '1' then --If this process is active
			if cntl_buffer_2_out(7) = '1' then --If the instruction is a write operation
				dRAM_data_out <= RAM_reg_data_from_ID; --Send the data on out
				dRAM_WR <= '1'; --Tell the memory bus controller to write
			end if;
			dRAM_addr <= ALU_result_from_EX(22 downto 0); --Send the address
		end if;
		
		--As a note, all of the read stuff is done automatically, as in, reading the memory is default.
		--I know it's a bit inefficient, but it's the most efficient way to do it with this processor.
	end process;
	
	--This models the MUX at the end of the stage that decides what data from where goes to WB
	MUX: process (ALU_result_from_EX, mixed_dRAM_data, iprt_data, cntl_buffer_2_out) is 
	begin																											
		case cntl_buffer_2_out(19 downto 18) is --Using a couple control lines for the select value
			when b"00" =>
				data_to_WB <= ALU_result_from_EX; --Send the ALU result straight through
			when b"01" =>
				data_to_WB <= iprt_data; --Send the input port's value through
			when b"10" =>
				data_to_WB <= mixed_dRAM_data; --Send the RAM data for a read operation through
			when others =>
				data_to_WB <= x"00000000"; --Otherwise, just send zero. This shouldn't get selected
		end case;
	end process;
	
	--This process takes the dRAM_data_in signal and mixes it with the data from the register that's being read into
	--so that it can put the new data in the upper or lower half of that register.
	--As you can see, this is always active, which allows for reading from the memory to be automatic
	mix_dRAM_data: process (dRAM_data_reg_out, cntl_buffer_2_out, RAM_reg_data_from_ID) is
	begin																							   									
			mixed_dRAM_data <= dRAM_data_reg_out;
	end process;
	
	--These registers make up the two-stage buffer for the control
	--signals that get sent out by the instruction decoder
	buf_1: GenReg generic map (size => 21)                                             
					  port map (clock => clock,
									enable => '1', 
									reset => reset, 
									data => cntl_from_ID, 
									output => cntl_buffer_1_2); 		
	buf_2: GenReg generic map (size => 21)
					  port map (clock => clock, 
									enable => '1', 
									reset => reset, 
									data => cntl_buffer_1_2, 
									output => cntl_buffer_2_out);
	
	--This is the input register for the stage
	input_reg: GenReg generic map (size => 32)
						   port map (clock => clock, 
										 enable => '1', 
										 reset => reset, 
										 data => ALU_result_from_EX_in, 
										 output => ALU_result_from_EX);
	
	--This is the register that delays the incoming data from RAM. It has to
	--be here because, otherwise, the data would only be present during the 
	--falling edge of the clock and would never be picked up by the WB stage.
	dRAM_data_reg : GenRegFalling generic map (32)
								         port map (clock, '1', reset, dRAM_data_in, dRAM_data_reg_out);
	
	--This output carries the address of the register that's used for RAM operations, such as
	--being a source for write operations and reading to the upper or lower half of it
	RAM_reg_addr_to_ID <= cntl_buffer_2_out(12 downto 8);
	
	--This is used in the forwarding logic in the ID stage. What's being placed on the output
	--is the address of the register where the result of the current operation is going.
	dest_reg_addr_to_ID <= cntl_buffer_2_out(17 downto 13);

end Behavioral;

