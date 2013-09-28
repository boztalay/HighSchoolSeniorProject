--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:24:37 05/07/2011
-- Design Name:   
-- Module Name:   C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ4_Mandelbrot/Hardware/OZ4_Mandelbrot/sim_top.vhd
-- Project Name:  OZ4_Mandelbrot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: OZ4_Mandelbrot_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sim_top IS
END sim_top;
 
ARCHITECTURE behavior OF sim_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OZ4_Mandelbrot_top
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         RAM_addr : OUT  std_logic_vector(22 downto 0);
         RAM_data_bus : INOUT  std_logic_vector(15 downto 0);
         RAM_oe : OUT  std_logic;
         RAM_we : OUT  std_logic;
         RAM_ub : OUT  std_logic;
         RAM_lb : OUT  std_logic;
         RAM_ce : OUT  std_logic;
         LEDs : OUT  std_logic_vector(7 downto 0);
         seg7_sigs : OUT  std_logic_vector(6 downto 0);
         anodes : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
	component cellram
	port (
		clk : in STD_LOGIC;
		adv_n : in STD_LOGIC;
		cre : in STD_LOGIC;
		o_wait : out STD_LOGIC;
		ce_n : in STD_LOGIC;
		oe_n : in STD_LOGIC;
		we_n : in STD_LOGIC;
		lb_n : in STD_LOGIC;
		ub_n : in STD_LOGIC;
		addr : in STD_LOGIC_VECTOR(22 downto 0);
		dq : inout STD_LOGIC_VECTOR(15 downto 0));
	end component;

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

	--BiDirs
   signal RAM_data_bus : std_logic_vector(15 downto 0);

 	--Outputs
   signal RAM_addr : std_logic_vector(22 downto 0);
   signal RAM_oe : std_logic;
   signal RAM_we : std_logic;
   signal RAM_ub : std_logic;
   signal RAM_lb : std_logic;
   signal RAM_ce : std_logic;
   signal LEDs : std_logic_vector(7 downto 0);
   signal seg7_sigs : std_logic_vector(6 downto 0);
   signal anodes : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: OZ4_Mandelbrot_top PORT MAP (
          clk => clk,
          rst => rst,
          RAM_addr => RAM_addr,
          RAM_data_bus => RAM_data_bus,
          RAM_oe => RAM_oe,
          RAM_we => RAM_we,
          RAM_ub => RAM_ub,
          RAM_lb => RAM_lb,
          RAM_ce => RAM_ce,
          LEDs => LEDs,
          seg7_sigs => seg7_sigs,
          anodes => anodes
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
			rst <= '1';
      wait for 1 us;	
			rst <= '0';
      wait;
   end process;
	
	Rizzam : cellram
	port map(
		 clk => '0', 
		 adv_n => '0',
		 cre => '0', 
		 o_wait => open,
		 ce_n => RAM_ce,
		 oe_n => RAM_oe,
		 we_n => RAM_we,
		 lb_n => RAM_lb,
		 ub_n => RAM_ub,
		 addr => RAM_addr,
		 dq => RAM_data_bus
	);	

END;
