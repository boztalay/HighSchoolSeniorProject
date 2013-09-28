library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity OZ3_Sys_Top is
	port(clk : in std_logic;
		  rst : in std_logic);
end OZ3_Sys_Top;

architecture Behavioral of OZ3_Sys_Top is

component OZ3 is
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
end component;

component data_memory is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  address : in std_logic_vector(31 downto 0);
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  we : in std_logic);		  
end component;

COMPONENT program_memory
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

signal OZ3_ipins, OZ3_opins : std_logic_vector(15 downto 0);
signal OZ3_iport, OZ3_oport : std_logic_vector(31 downto 0);
signal OZ3_oport_we : std_logic;

signal prog_mem_addr : std_logic_vector(22 downto 0);
signal prog_mem_out : std_logic_vector(31 downto 0);

signal data_mem_addr : std_logic_vector(22 downto 0);
signal data_mem_real_addr : std_logic_vector(31 downto 0);
signal data_mem_out, data_mem_in : std_logic_vector(31 downto 0);
signal data_mem_we : std_logic;

begin

	CPU : OZ3
	port map(
		main_clock => clk,
		reset => rst,
		input_pins => OZ3_ipins,
		input_port => OZ3_iport,
		instruction_from_iROM => prog_mem_out,
		data_from_dRAM => data_mem_out,
		output_pins => OZ3_opins,
		output_port => OZ3_oport,
		output_port_enable => OZ3_oport_we,
		addr_to_iROM => prog_mem_addr,
		data_to_dRAM => data_mem_in,
		addr_to_dRAM => data_mem_addr,
		WR_to_dRAM => data_mem_we
		);
		
	data_mem_real_addr <= "000000000" & data_mem_addr;

	dmem : data_memory
	port map(
		clk => clk,
		rst => rst,
		address => data_mem_real_addr,
		data_in => data_mem_in,
		data_out => data_mem_out,
		we => data_mem_we
		);
		
	pmem : program_memory
	port map(
		clka => clk,
		addra => prog_mem_addr(8 downto 0),
		douta => prog_mem_out
		);

end Behavioral;

