----------------------------------------------------------------------------------
--Ben Oztalay, 2009-2010
--
--This VHDL code is part of the OZ-3 Based Computer System designed for the
--Digilent Nexys 2 FPGA Development Board
--
--Module Title: OZ3
--Module Description:
--	The OZ-3, a 32-bit, 5-stage RISC
--	Documentation of the exact specifications should
-- be included with this code.
--
--Notes:
-- Nomenclature for signals: OZ3_dRAM_data_to_MC
--									  |^| |---^---| |-^-|
--										|	    |       |
--							sending module  |  receiving module
-- 								 signal name/content
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity OZ3 is
	Port ( main_clock : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 input_pins : in STD_LOGIC_VECTOR(15 downto 0);
			 input_port : in STD_LOGIC_VECTOR(31 downto 0);
			 instruction_from_iROM : in STD_LOGIC_VECTOR(31 downto 0);
			 data_from_dRAM : in STD_LOGIC_VECTOR(31 downto 0);
			 output_pins : out STD_LOGIC_VECTOR(15 downto 0);
			 output_port : out STD_LOGIC_VECTOR(31 downto 0);
			 output_port_enable : out STD_LOGIC;
			 addr_to_iROM : out STD_LOGIC_VECTOR(22 downto 0);
			 data_to_dRAM : out STD_LOGIC_VECTOR(31 downto 0);
			 addr_to_dRAM : out STD_LOGIC_VECTOR(22 downto 0);
			 WR_to_dRAM : out STD_LOGIC);
end OZ3;

architecture Behavioral of OZ3 is

--//Components\\--

--Instruction Fetch Stage
component IFetch is
	Port ( clock : in STD_LOGIC;
		    reset : in STD_LOGIC;
			 condition_flag_from_EX : in STD_LOGIC;
			 PC_new_addr_from_EX : in STD_LOGIC_VECTOR(31 downto 0);
			 instruction_from_iROM : in STD_LOGIC_VECTOR(31 downto 0);
			 addr_to_iROM : out STD_LOGIC_VECTOR(22 downto 0);
			 instruction_to_ID : out STD_LOGIC_VECTOR(31 downto 0));
end component;

--Instruction Decode Stage
component ID is
	Port ( --Inputs--
	
			 --Main inputs
			 clock : in STD_LOGIC;
			 reset : in STD_LOGIC;
			 instruction_from_IF : in STD_LOGIC_VECTOR(31 downto 0);
			 --Register file inputs
			 rfile_RAM_reg_addr_from_MEMIO : in STD_LOGIC_VECTOR(4 downto 0);
			 rfile_write_addr_from_WB : in STD_LOGIC_VECTOR(4 downto 0);
			 rfile_write_data_from_WB : in STD_LOGIC_VECTOR(31 downto 0);
			 rfile_write_e_from_WB    : in STD_LOGIC;
			 --Forwarding logic inptus
			 forward_addr_EX    : in STD_LOGIC_VECTOR(4 downto 0);
			 forward_data_EX    : in STD_LOGIC_VECTOR(31 downto 0);
			 forward_addr_MEMIO : in STD_LOGIC_VECTOR(4 downto 0);
			 forward_data_MEMIO : in STD_LOGIC_VECTOR(31 downto 0);
			 forward_addr_WB    : in STD_LOGIC_VECTOR(4 downto 0);
			 forward_data_WB    : in STD_LOGIC_VECTOR(31 downto 0); 
				
			 --Outputs--
			 
			 --EX Control
			 ALU_A_to_EX : out STD_LOGIC_VECTOR(31 downto 0);
			 ALU_B_to_EX : out STD_LOGIC_VECTOR(31 downto 0);
			 EX_control : out STD_LOGIC_VECTOR(11 downto 0);
			 --MEMIO Control
			 RAM_reg_data_to_MEMIO : out STD_LOGIC_VECTOR(31 downto 0);
			 MEMIO_control : out STD_LOGIC_VECTOR(20 downto 0);
			 --WB Control
			 WB_control : out STD_LOGIC_VECTOR(5 downto 0));	 
end component;

--Execute Stage
component EX is
	Port ( clock : in STD_LOGIC;
		    reset : in STD_LOGIC;
			 ALUA_from_ID  : in STD_LOGIC_VECTOR(31 downto 0);
			 ALUB_from_ID  : in STD_LOGIC_VECTOR(31 downto 0);
			 cntl_from_ID : in STD_LOGIC_VECTOR(11 downto 0);
			 p_flag_from_MEM : in STD_LOGIC;
			 ALUR_to_MEM : out STD_LOGIC_VECTOR(31 downto 0);
			 dest_reg_addr_to_ID : out STD_LOGIC_VECTOR(4 downto 0);
			 cond_bit_to_IF : out STD_LOGIC);
end component;

--Memory and I/O Stage
component MEMIO is
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
end component;

--Writeback Stage
component WB is
	Port ( clock : in STD_LOGIC;
	       reset : in STD_LOGIC;
			 data_from_MEM : in STD_LOGIC_VECTOR(31 downto 0);
			 cntl_from_ID  : in STD_LOGIC_VECTOR(5 downto 0);
			 rfile_write_data_to_ID : out STD_LOGIC_VECTOR(31 downto 0);
			 rfile_write_addr_to_ID : out STD_LOGIC_VECTOR(4 downto 0);
			 rfile_write_e_to_ID   : out STD_LOGIC);
end component;

--Output Pin Register and Controller--
component output_pin_cntl is
    Port ( clock : in  STD_LOGIC;
			  enable : in STD_LOGIC;
           reset : in  STD_LOGIC;
           data : in  STD_LOGIC;
           sel : in  STD_LOGIC_VECTOR(3 downto 0);
           pins : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

--Generic Registers--
--Writes on rising edge
component GenReg is
	 generic (size : integer);
		 Port ( clock : in  STD_LOGIC;
				  enable : in STD_LOGIC;
				  reset : in  STD_LOGIC;
				  data : in  STD_LOGIC_VECTOR ((size - 1) downto 0);
				  output : out  STD_LOGIC_VECTOR ((size - 1) downto 0));
end component;

--Writes on falling edge
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

--Main Bus Signals--
--These carry the bulk of data between stages
signal IF_bus_to_ID : STD_LOGIC_VECTOR(31 downto 0);
signal ID_ALU_A_to_EX : STD_LOGIC_VECTOR(31 downto 0);
signal ID_ALU_B_to_EX : STD_LOGIC_VECTOR(31 downto 0);
signal EX_bus_to_MEMIO : STD_LOGIC_VECTOR(31 downto 0);
signal MEMIO_bus_to_WB : STD_LOGIC_VECTOR(31 downto 0);

--Control Signals for the various stages--
signal ID_EX_control_to_EX : STD_LOGIC_VECTOR(11 downto 0);
signal ID_MEMIO_control_to_MEMIO : STD_LOGIC_VECTOR(20 downto 0);
signal ID_WB_control_to_WB : STD_LOGIC_VECTOR(5 downto 0);

--Other Signals--
signal EX_cond_to_IF : STD_LOGIC; --This carries the selected flag to the IF stage
											 --to tell the IF stage to branch or not
signal WB_rfile_write_addr_to_ID : STD_LOGIC_VECTOR(4 downto 0); --Writeback communications with the register file
signal WB_rfile_write_data_to_ID : STD_LOGIC_VECTOR(31 downto 0);
signal WB_rfile_write_e_to_ID : STD_LOGIC; --Enable signal

signal MEMIO_RAM_reg_addr_to_ID : STD_LOGIC_VECTOR(4 downto 0); --These signals get MEMIO the register data
signal ID_RAM_reg_data_to_MEMIO : STD_LOGIC_VECTOR(31 downto 0);--it needs to perform read and write operations

signal EX_forward_addr_to_ID : STD_LOGIC_VECTOR(4 downto 0);    --The addresses of registers that are
signal MEMIO_forward_addr_to_ID : STD_LOGIC_VECTOR(4 downto 0); --used for forwarding purposes. The rest of the
																					 --data needed for forwarding is grabbed from the
																					 --inter-stage signals
signal MEMIO_pflag_to_EX : STD_LOGIC; --When an input pin check instruction is performed, this signal carries
												  --the value of the pin being checked to the condition block
												  
--These signals carry data and control signals between the input and output pin/port registers and blocks and
--the MEMIO stage
signal ipin_reg_out_to_MEMIO : STD_LOGIC_VECTOR(15 downto 0);
signal iprt_reg_out_to_MEMIO : STD_LOGIC_VECTOR(31 downto 0);
signal MEMIO_opin_clk_e_to_opin : STD_LOGIC;
signal MEMIO_opin_1_0_to_opin : STD_LOGIC; --Tells the output pin controller to set the specified pin to '1' or '0'
signal MEMIO_opin_select_to_opin : STD_LOGIC_VECTOR(3 downto 0);
signal MEMIO_oprt_data_to_oprt : STD_LOGIC_VECTOR(31 downto 0);
signal MEMIO_oprt_reg_clk_e_to_oprt : STD_LOGIC;

--\\Signals//--

begin
	
	--Instantiate the Stages--
	--Instantiate Instruction Fetch stage
	IF_stage: IFetch port map (clock => main_clock,
										reset => reset, 
										condition_flag_from_ex => EX_cond_to_IF, 
										PC_new_addr_from_EX => EX_bus_to_MEMIO, 
										instruction_from_iROM => instruction_from_iROM, 
										addr_to_iROM => addr_to_iROM,
										instruction_to_ID => IF_bus_to_ID);
										
	--Instantiate Instruction Decode stage
	ID_stage: ID port map (clock => main_clock, 
								  reset => reset, 
								  instruction_from_IF => IF_bus_to_ID, 
								  rfile_RAM_reg_addr_from_MEMIO => MEMIO_RAM_reg_addr_to_ID, 
								  rfile_write_addr_from_WB => WB_rfile_write_addr_to_ID,
								  rfile_write_data_from_WB => WB_rfile_write_data_to_ID, 
								  rfile_write_e_from_WB => WB_rfile_write_e_to_ID, 
								  forward_addr_EX => EX_forward_addr_to_ID, 
								  forward_data_EX => EX_bus_to_MEMIO,
								  forward_addr_MEMIO => MEMIO_forward_addr_to_ID, 
								  forward_data_MEMIO => MEMIO_bus_to_WB, 
								  forward_addr_WB => WB_rfile_write_addr_to_ID, 
								  forward_data_WB => WB_rfile_write_data_to_ID,
								  ALU_A_to_EX => ID_ALU_A_to_EX, 
								  ALU_B_to_EX => ID_ALU_B_to_EX, 
								  EX_control => ID_EX_control_to_EX,
								  RAM_reg_data_to_MEMIO => ID_RAM_reg_data_to_MEMIO,
								  MEMIO_control => ID_MEMIO_control_to_MEMIO, 
								  WB_control => ID_WB_control_to_WB);
								  
	--Instantiate Execute stage
	EX_stage: EX port map (clock => main_clock, 
								  reset => reset, 
								  ALUA_from_ID => ID_ALU_A_to_EX, 
								  ALUB_from_ID => ID_ALU_B_to_EX, 
								  cntl_from_ID => ID_EX_control_to_EX, 
								  p_flag_from_MEM => MEMIO_pflag_to_EX, 
								  ALUR_to_MEM => EX_bus_to_MEMIO,
								  dest_reg_addr_to_ID => EX_forward_addr_to_ID, 
								  cond_bit_to_IF => EX_cond_to_IF);
								  
	--Instantiate Memory and I/O stage
	MEMIO_stage: MEMIO port map (clock => main_clock, 
										  reset => reset, 
										  cntl_from_ID => ID_MEMIO_control_to_MEMIO, 
										  ALU_result_from_EX_in => EX_bus_to_MEMIO, 
										  RAM_reg_data_from_ID => ID_RAM_reg_data_to_MEMIO, 
										  ipin_reg_data => ipin_reg_out_to_MEMIO,
										  iprt_data => iprt_reg_out_to_MEMIO, 
										  dRAM_data_in => data_from_dRAM, 
										  dRAM_data_out => data_to_dRAM, 
										  dRAM_WR => WR_to_dRAM, 
										  dRAM_addr => addr_to_dRAM, 
										  dest_reg_addr_to_ID => MEMIO_forward_addr_to_ID,
										  pflag_to_EX => MEMIO_pflag_to_EX, 
										  opin_clk_e => MEMIO_opin_clk_e_to_opin, 
										  opin_select => MEMIO_opin_select_to_opin, 
										  opin_1_0 => MEMIO_opin_1_0_to_opin, 
										  oprt_data => MEMIO_oprt_data_to_oprt, 
										  oprt_reg_clk_e => MEMIO_oprt_reg_clk_e_to_oprt,
										  RAM_reg_addr_to_ID => MEMIO_RAM_reg_addr_to_ID, 
										  data_to_WB => MEMIO_bus_to_WB);						  
										  
	--Instantiate Writeback stage
	WB_stage: WB port map (clock => main_clock, 
								  reset => reset, 
								  data_from_MEM => MEMIO_bus_to_WB, 
								  cntl_from_ID => ID_WB_control_to_WB, 
								  rfile_write_data_to_ID => WB_rfile_write_data_to_ID, 
								  rfile_write_addr_to_ID => WB_rfile_write_addr_to_ID,
								  rfile_write_e_to_ID => WB_rfile_write_e_to_ID);

	--Instantiate the Output Pin Controller--
	Opin : output_pin_cntl port map (clock => main_clock, 
												enable => MEMIO_opin_clk_e_to_opin, 
												reset => reset, 
												data => MEMIO_opin_1_0_to_opin, 
												sel => MEMIO_opin_select_to_opin, 
												pins => output_pins);
	
	--Instantiate Input/Output Registers--
	Ipin : GenReg generic map (size => 16)
					  port map (clock => main_clock, 
									enable => '1', 
									reset => reset, 
									data => input_pins, 
									output => ipin_reg_out_to_MEMIO);
									
	Iport : GenReg generic map (size => 32)
					   port map (clock => main_clock, 
									 enable => '1', 
									 reset => reset, 
									 data => input_port, 
									 output => iprt_reg_out_to_MEMIO);
	
	--Output port stuff	
	output_port <= MEMIO_oprt_data_to_oprt;
	output_port_enable <= MEMIO_oprt_reg_clk_e_to_oprt;

end Behavioral;

