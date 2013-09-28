----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3, a 32-bit processor
--
--Module Title: IFetch
--Module Description:
--	The instruction fetch stage of the OZ-3. It runs 
-- twice as fast as the rest of the processor in
-- order to get both 16-bit halves of the 32-bit
-- instructions in time.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity IFetch is
	Port ( clock : in STD_LOGIC;
		    reset : in STD_LOGIC;
			 condition_flag_from_EX : in STD_LOGIC;
			 PC_new_addr_from_EX : in STD_LOGIC_VECTOR(31 downto 0);
			 instruction_from_iROM : in STD_LOGIC_VECTOR(31 downto 0);
			 addr_to_iROM : out STD_LOGIC_VECTOR(22 downto 0);
			 instruction_to_ID : out STD_LOGIC_VECTOR(31 downto 0));
end IFetch;

architecture Behavioral of IFetch is

--//Components\\--

component GenReg is
	 generic (size: integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end component;

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

--Signals that have to do with the program counter
signal PC_addr_to_load : STD_LOGIC_VECTOR(22 downto 0);
signal incremented_addr : STD_LOGIC_VECTOR(22 downto 0);
signal PC_out : STD_LOGIC_VECTOR(22 downto 0);

--Signals that carry the outputs of the two 16-bit instruction
--registers
signal instruction : STD_LOGIC_VECTOR(31 downto 0);

--\\Signals//--

begin
	
	--This process gives the program counter either an incremented
	--address, or an alternate address to jump to
	PC_new_addr_cntl: process (PC_new_addr_from_EX, incremented_addr, condition_flag_from_EX) is
	begin
		if condition_flag_from_EX = '1' then
			PC_addr_to_load <= PC_new_addr_from_EX(22 downto 0);
		else
			PC_addr_to_load <= incremented_addr;
		end if;
	end process;
	
	PC: GenReg generic map (23)
				  port map (clock => clock, 
								enable => '1',
								reset => reset, 
								data => PC_addr_to_load, 
								output => PC_out);
	
	Inst_reg : GenRegFalling generic map (32)
							  port map (clock => clock, 
											enable => '1', 
											reset => reset, 
											data => instruction_from_iROM, 
											output => instruction);
	
	--The address that goes out to the flash
	addr_to_iROM <= PC_out;
	
	--Send both halves of the instruction to the instruction decoder
	instruction_to_ID <= instruction;
	
	--This generates the incremented address for the program counter
	incremented_addr <= (PC_out + b"00000000000000000000001");
	
end Behavioral;

