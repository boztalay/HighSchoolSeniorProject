library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity OZ4_Mandelbrot_top is
	port( clk : in std_logic;
		   rst : in std_logic;
			
			trippy : in std_logic;
			
			--Memory
			RAM_addr : out std_logic_vector(22 downto 0);
			RAM_data_bus : inout std_logic_vector(15 downto 0);
			RAM_oe : out std_logic;
			RAM_we : out std_logic;
			RAM_ub : out std_logic;
			RAM_lb : out std_logic;
			RAM_ce : out std_logic;
			
			--Video
			hsync : out STD_LOGIC;
			vsync : out STD_LOGIC;
			red : out std_logic_vector(2 downto 0);
			green : out std_logic_vector(2 downto 0);
			blue : out std_logic_vector(1 downto 0);
		  
			--Basic IO
		   LEDs : out std_logic_vector(7 downto 0);
		   seg7_sigs : out std_logic_vector(6 downto 0);
		   anodes : out std_logic_vector(3 downto 0));
end OZ4_Mandelbrot_top;

architecture Behavioral of OZ4_Mandelbrot_top is

component clk_mgt is
	port(clk50 : in std_logic;
		  rst : in std_logic;
		  clk12 : out std_logic;
		  clk25 : out std_logic);
end component;

component OZ4_top is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  --Basic IO
		  iport : in std_logic_vector(31 downto 0);
		  ipins : in std_logic_vector(7 downto 0);
		  
		  oport : out std_logic_vector(31 downto 0);
		  opins : out std_logic_vector(7 downto 0);
		  
		  --Instruction Memory
		  instruction_in : in std_logic_vector(11 downto 0);
		  instruction_addr : out std_logic_vector(31 downto 0);
		  immediate_in : in std_logic_vector(31 downto 0);
		  immediate_addr : out std_logic_vector(5 downto 0);
		  
		  --Data Memory
		  mem_addr : out std_logic_vector(31 downto 0);
		  mem_write_data : out std_logic_vector(31 downto 0);
		  mem_read_data : in std_logic_vector(31 downto 0);
		  mem_we_out : out std_logic;
		  mem_clk : out std_logic);
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
    douta : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
  );
END COMPONENT;

component immediate_memory is
	port(immediate_addr : in std_logic_vector(5 downto 0);
		  immediate_out : out std_logic_vector(31 downto 0));
end component;

component four_dig_7seg is
    Port ( clock : in  STD_LOGIC;
           display_data : in  STD_LOGIC_VECTOR (15 downto 0);
           anodes : out  STD_LOGIC_VECTOR (3 downto 0);
           to_display : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

component vga_640x480 is
			Port ( clk, clr : in STD_LOGIC;
					 hsync : out STD_LOGIC;
					 vsync : out STD_LOGIC;
					 hc : out STD_LOGIC_VECTOR(9 downto 0);
					 vc : out STD_LOGIC_VECTOR(9 downto 0);
					 pix : out std_logic_vector(22 downto 0);
					 vidon : out STD_LOGIC);
end component;

component video_controller is
	port(
		clk : in std_logic;
		rst : in std_logic;
		
		trippy : in std_logic;
		
		red : out std_logic_vector(2 downto 0);
		green : out std_logic_vector(2 downto 0);
		blue : out std_logic_vector(1 downto 0);
		
		vidon : in std_logic;
		
		RAM_data_in : in std_logic_vector(15 downto 0);
		RAM_addr : out std_logic_vector(31 downto 0));
end component;

component mem_control is
	port(
		clk : in std_logic;
		rst : in std_logic;
		
		RAM_addr : out std_logic_vector(22 downto 0);
		RAM_data_bus : inout std_logic_vector(15 downto 0);
		RAM_oe : out std_logic;
		RAM_we : out std_logic;
		RAM_ub : out std_logic;
		RAM_lb : out std_logic;
		RAM_ce : out std_logic;
		
		write_data : in std_logic_vector(31 downto 0);
		pix1_we: in std_logic;
		pix2_we: in std_logic;
		addr_we: in std_logic;
		big_we: in std_logic;
		write_clk : in std_logic;
		
		read_addr : in std_logic_vector(31 downto 0);
		read_data : out std_logic_vector(15 downto 0);
		
		mode : in std_logic		
		);
end component;

signal clk12, clk25 : std_logic;

signal OZ4_iport, OZ4_oport : std_logic_vector(31 downto 0);
signal OZ4_ipins, OZ4_opins : std_logic_vector(7 downto 0);

signal instruction_mem_out : std_logic_vector(11 downto 0);
signal instruction_addr : std_logic_vector(31 downto 0);
signal immediate_mem_out : std_logic_vector(31 downto 0);
signal immediate_addr : std_logic_vector(5 downto 0);

signal data_mem_addr, data_mem_in, data_mem_out: std_logic_vector(31 downto 0);
signal data_mem_we : std_logic;

signal seg7_data : std_logic_vector(15 downto 0);

signal MC_data : std_logic_vector(31 downto 0);
signal MC_mode, MC_pix1we, MC_pix2we, MC_addrwe, MC_bigwe, MC_wclk : std_logic;
signal MC_raddr : std_logic_vector(31 downto 0);
signal MC_rdata : std_logic_vector(15 downto 0);

signal vidon : std_logic;

begin
	
	--Assigning OZ4 ports and pins
	OZ4_iport <= x"00000000";
	OZ4_ipins <= x"00";
	
	LEDs(0) <= OZ4_opins(0);
	LEDs(1) <= MC_mode;
	LEDs(7 downto 2) <= (others => '0');
	
	MC_mode <= OZ4_opins(1);
	MC_pix1we <= OZ4_opins(2);
	MC_pix2we <= OZ4_opins(3);
	MC_addrwe <= OZ4_opins(4);
	MC_bigwe <= OZ4_opins(5);
	
	MC_data <= OZ4_oport;
	
	clkr : clk_mgt
	port map(clk50 => clk,
				rst => rst,
				clk12 => clk12,
				clk25 => clk25
				);
	
	OZ4 : OZ4_top
	port map(clk => clk25,
				rst => rst,
				
				iport => OZ4_iport,
				ipins => OZ4_ipins,
				
				oport => OZ4_oport,
				opins => OZ4_opins,
				
				instruction_in => instruction_mem_out,
				instruction_addr => instruction_addr,
				immediate_in => immediate_mem_out,
				immediate_addr => immediate_addr,
				
				mem_addr => data_mem_addr,
				mem_write_data => data_mem_in,
				mem_read_data => data_mem_out,
				mem_we_out => data_mem_we,
				mem_clk => MC_wclk
				);
				
	data_mem : data_memory
	port map(clk => clk25,
				rst => rst,
				
				address => data_mem_addr,
				data_in => data_mem_in,
				data_out => data_mem_out,
				we => data_mem_we
			   );
				
	prog_mem : program_memory
   PORT MAP (
		clka => (not clk25),
		addra => instruction_addr(8 downto 0),
		douta => instruction_mem_out
   );
	
	imm_mem : immediate_memory
	port map (
		immediate_addr => immediate_addr,
		immediate_out => immediate_mem_out
		);
				
	mem_ctr : mem_control
	port map(clk => clk25,
				rst => rst,
				
				RAM_addr => RAM_addr,
				RAM_data_bus => RAM_data_bus,
				RAM_oe => RAM_oe,
				RAM_ce => RAM_ce,
				RAM_we => RAM_we,
				RAM_ub => RAM_ub,
				RAM_lb => RAM_lb,
				
				write_data => MC_data,
				pix1_we => MC_pix1we,
				pix2_we => MC_pix2we,
				addr_we => MC_addrwe,
				big_we => MC_bigwe,
				write_clk => MC_wclk,
				
				read_addr => MC_raddr,
				read_data => MC_rdata,
				
				mode => MC_mode
				);

	vid_ctl : video_controller
	port map(clk => clk25,
				rst => rst,
				trippy => trippy,
				red => red,
				green => green,
				blue => blue,
				vidon => vidon,
				RAM_data_in => MC_rdata,
				RAM_addr => MC_raddr
				);

	vig_gen : vga_640x480
	port map(clk => clk25,
				clr => rst,
				hsync => hsync,
				vsync => vsync,
				hc => open,
				vc => open,
				pix => open,
				vidon => vidon
				);
				
	seg7_data <= MC_rdata;
	display : four_dig_7seg
	port map(clock => clk,
				display_data => seg7_data,
				anodes => anodes,
				to_display => seg7_sigs
				);

end Behavioral;

