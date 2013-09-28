library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity OZ4_top is
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
end OZ4_top;

architecture Behavioral of OZ4_top is

component ctl_unit is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  instruction_in : in std_logic_vector(11 downto 0);
		  instruction_addr : out std_logic_vector(31 downto 0);
		  immediate_in : in std_logic_vector(31 downto 0);
		  immediate_addr : out std_logic_vector(5 downto 0);
		  
		  ctl_immediate : out std_logic_vector(31 downto 0);
		  
		  PC_data_out : in std_logic_vector(31 downto 0);
		  
		  ALU_flags : in std_logic_vector(3 downto 0);
		  stack_e0 : in std_logic_vector(31 downto 0);
		  stack_e1 : in std_logic_vector(31 downto 0);
		  
		  --Control signals
		  ALU_sel : out std_logic_vector(3 downto 0);
		  
		  stack_e0_sel : out std_logic_vector(1 downto 0);
		  stack_e1_sel : out std_logic_vector(1 downto 0);
		  stack_e2_sel : out std_logic_vector(1 downto 0);		  
		  stack_e0_en : out std_logic;
		  stack_e1_en : out std_logic;
		  stack_e2_en : out std_logic;	  
		  stack_push : out std_logic;
		  stack_pop : out std_logic;
		  stack_pop2 : out std_logic;
		  
		  RS_push : out std_logic;
		  RS_pop : out std_logic;
		  
		  mem_we : out std_logic;
		  
		  PC_load : out std_logic;
		  PC_inc : out std_logic;
		  
		  IO_oport_en : out std_logic;
		  IO_opins_en : out std_logic;
		  
		  stack_MUX_sel : out std_logic_vector(2 downto 0);
		  PC_MUX_sel : out std_logic);
end component;

component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
           flags : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component data_stack is
	port(
		clk : in std_logic;
		rst : in std_logic;
		
		e0_sel : in std_logic_vector(1 downto 0);
		e1_sel : in std_logic_vector(1 downto 0);
		e2_sel : in std_logic_vector(1 downto 0); 
		
		e0_en : in std_logic;
		e1_en : in std_logic;
		e2_en : in std_logic;	
		
		push : in std_logic;
		pop : in std_logic;
		pop2 : in std_logic;
		
		data_in : in std_logic_vector(31 downto 0);
		e0_out : out std_logic_vector(31 downto 0);
		e1_out : out std_logic_vector(31 downto 0)
	);
end component;

component return_stack is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  
		  push : in std_logic;
		  pop : in std_logic
		 );
end component;

component prog_counter is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  
		  load : in std_logic;
		  increment : in std_logic
		 );		  
end component;

component memory_control is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  address : in std_logic_vector(31 downto 0);
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  we : in std_logic;
		  
		  mem_addr : out std_logic_vector(31 downto 0);
		  mem_write_data : out std_logic_vector(31 downto 0);
		  mem_read_data : in std_logic_vector(31 downto 0);
		  mem_we : out std_logic;
		  mem_clk : out std_logic
		 );
end component;

component IO_ctl is
	port(clk : in std_logic;
		 rst : in std_logic;
		 
		 iport : in std_logic_vector(31 downto 0);
		 iport_data : out std_logic_vector(31 downto 0);
		 
		 ipins : in std_logic_vector(7 downto 0);
		 ipins_data : out std_logic_vector(31 downto 0);
		 ipins_sel : in std_logic_vector(2 downto 0);
		 
		 oport : out std_logic_vector(31 downto 0);
		 oport_data : in std_logic_vector(31 downto 0);
		 oport_en : in std_logic;
		 
		 opins : out std_logic_vector(7 downto 0);
		 opins_data : in std_logic_vector(31 downto 0);
		 opins_sel : in std_logic_vector(2 downto 0);
		 opins_en : in std_logic
	);
end component;

component stack_in_MUX is
	port(sel : in std_logic_vector(2 downto 0);
		
		  ctl_immediate : in std_logic_vector(31 downto 0);
		  ALU_result : in std_logic_vector(31 downto 0);
		  IO_ipins_data : in std_logic_vector(31 downto 0);
		  IO_iport_data : in std_logic_vector(31 downto 0);
		  mem_data_out : in std_logic_vector(31 downto 0);
		  
		  output : out std_logic_vector(31 downto 0));
end component;

component PC_MUX is
	port(sel : in std_logic;
		
		  RS_top : in std_logic_vector(31 downto 0);
		  stack_e0 : in std_logic_vector(31 downto 0);
		  
		  output : out std_logic_vector(31 downto 0));		  
end component;

--Signals

--From the control unit
signal ctl_immediate : std_logic_vector(31 downto 0);

--ALU
signal ALU_sel : std_logic_vector(3 downto 0);
signal ALU_result : std_logic_vector(31 downto 0);
signal ALU_flags : std_logic_vector(3 downto 0);

--Data Stack
signal stack_e0_sel, stack_e1_sel, stack_e2_sel: std_logic_vector(1 downto 0);
signal stack_e0_en, stack_e1_en, stack_e2_en : std_logic;
signal stack_push, stack_pop, stack_pop2 : std_logic;
signal stack_e0, stack_e1 : std_logic_vector(31 downto 0);

--Return Stack
signal RS_top : std_logic_vector(31 downto 0);
signal RS_push, RS_pop : std_logic;

--Memory Controller
signal mem_data_out : std_logic_vector(31 downto 0);
signal mem_we : std_logic;

--Program Counter
signal PC_data_out, PC_data_out_2 : std_logic_vector(31 downto 0);
signal PC_load, PC_inc : std_logic;

--I/O Controller
signal IO_iport_data, IO_ipins_data : std_logic_vector(31 downto 0);
signal IO_oport_en, IO_opins_en : std_logic;

--Multiplexers
signal stack_MUX_sel : std_logic_vector(2 downto 0);
signal stack_MUX_out : std_logic_vector(31 downto 0);

signal PC_MUX_sel : std_logic;
signal PC_MUX_out : std_logic_vector(31 downto 0);

begin

	--The control unit
	ctl : ctl_unit
	port map(
			clk => clk,
			rst => rst,
			
			instruction_in => instruction_in,
			instruction_addr => instruction_addr,
			immediate_in => immediate_in,
			immediate_addr => immediate_addr,
			
			ctl_immediate => ctl_immediate,
			
			PC_data_out => PC_data_out,
			
			ALU_flags => ALU_flags,
			stack_e0 => stack_e0,
			stack_e1 => stack_e1,
			
			ALU_sel => ALU_sel,
			
			stack_e0_sel => stack_e0_sel,
		   stack_e1_sel => stack_e1_sel,
		   stack_e2_sel => stack_e2_sel,		  
		   stack_e0_en => stack_e0_en,
		   stack_e1_en => stack_e1_en,
		   stack_e2_en => stack_e2_en,	  
		   stack_push => stack_push,
		   stack_pop => stack_pop,
		   stack_pop2 => stack_pop2,
			
			RS_push => RS_push,
			RS_pop => RS_pop,
			
			mem_we => mem_we,
			
			PC_load => PC_load,
			PC_inc => PC_inc,
			
			IO_oport_en => IO_oport_en,
			IO_opins_en => IO_opins_en,
			
			stack_MUX_sel => stack_MUX_sel,
			PC_MUX_sel => PC_MUX_sel
		);
	
	--The ALU
	arith : ALU
	port map(
		A => stack_e0,
		B => stack_e1,
		sel => ALU_sel,
		result => ALU_result,
		flags => ALU_flags
		);
		
	--The data stack
	DS : data_stack
	port map(
		clk => clk,
		rst => rst,
		
		e0_sel => stack_e0_sel,
		e1_sel => stack_e1_sel,
		e2_sel => stack_e2_sel,
		
		e0_en => stack_e0_en,
		e1_en => stack_e1_en,
		e2_en => stack_e2_en,
		
		push => stack_push,
		pop => stack_pop,
		pop2 => stack_pop2,
		
		data_in => stack_MUX_out,
		e0_out => stack_e0,
		e1_out => stack_e1
		);
		
	--The return stack
	RS : return_stack
	port map(
		clk => clk,
		rst => rst,
		
		data_in => PC_data_out_2,
		data_out => RS_top,
		
		push => RS_push,
		pop => RS_pop
		);
		
	--The memory controller
	mem_ctl : memory_control
	port map(
		clk => clk,
		rst => rst,
		
		address => stack_e0,
		data_in => stack_e1,
		data_out => mem_data_out,
		we => mem_we,
		
		mem_addr => mem_addr,
		mem_write_data => mem_write_data,
		mem_read_data => mem_read_data,
		mem_we => mem_we_out,
		mem_clk => mem_clk
		);
	
	--The program counter
	PC : prog_counter
	port map(
		clk => clk,
		rst => rst,
		
		data_in => PC_MUX_out,
		data_out => PC_data_out,
		
		load => PC_load,
		increment => PC_inc
		);
	PC_data_out_2 <= PC_data_out + 2; --For pushing the program counter
		
	--I/O controller
	IO : IO_ctl
	port map(
		clk => clk,
		rst => rst,
		
		iport => iport,
		iport_data => IO_iport_data,
		
		ipins => ipins,
		ipins_data => IO_ipins_data,
		ipins_sel => stack_e0(2 downto 0),
		
		oport => oport,
		oport_data => stack_e0,
		oport_en => IO_oport_en,
		
		opins => opins,
		opins_data => stack_e1,
		opins_sel => stack_e0(2 downto 0),
		opins_en => IO_opins_en
		);
		
	--MUX that selects which bus goes onto the stack
	DS_MUX : stack_in_MUX
	port map(
		sel => stack_MUX_sel,
		
		ctl_immediate => ctl_immediate,
		ALU_result => ALU_result,
		IO_ipins_data => IO_ipins_data,
		IO_iport_data => IO_iport_data,
		mem_data_out => mem_data_out,
		
		output => stack_MUX_out
		);

	--MUX that selects whether the top of the return stack or data stack goes to the PC
	prog_MUX : PC_MUX
	port map(
		sel => PC_MUX_sel,
		
		RS_top => RS_top,
		stack_e0 => stack_e0,
		
		output => PC_MUX_out
		);

end Behavioral;

