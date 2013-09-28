--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:23:47 05/01/2011
-- Design Name:   
-- Module Name:   C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ4_Mandelbrot/Hardware/OZ4_Mandelbrot/mem_control_TB.vhd
-- Project Name:  OZ4_Mandelbrot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mem_control
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
 
ENTITY mem_control_TB IS
END mem_control_TB;
 
ARCHITECTURE behavior OF mem_control_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mem_control
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
         write_addr : IN  std_logic_vector(31 downto 0);
         write_data : IN  std_logic_vector(7 downto 0);
         write_en : IN  std_logic;
         write_clk : IN  std_logic;
         read_addr : IN  std_logic_vector(31 downto 0);
         read_data : OUT  std_logic_vector(7 downto 0);
         read_oe : IN  std_logic;
         read_ce : IN  std_logic;
         mode : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal write_addr : std_logic_vector(31 downto 0) := (others => '0');
   signal write_data : std_logic_vector(7 downto 0) := (others => '0');
   signal write_en : std_logic := '0';
   signal write_clk : std_logic := '0';
   signal read_addr : std_logic_vector(31 downto 0) := (others => '0');
   signal read_oe : std_logic := '0';
   signal read_ce : std_logic := '0';
   signal mode : std_logic := '0';

	--BiDirs
   signal RAM_data_bus : std_logic_vector(15 downto 0);

 	--Outputs
   signal RAM_addr : std_logic_vector(22 downto 0);
   signal RAM_oe : std_logic;
   signal RAM_we : std_logic;
   signal RAM_ub : std_logic;
   signal RAM_lb : std_logic;
   signal RAM_ce : std_logic;
   signal read_data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 40 ns;
   constant write_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mem_control PORT MAP (
          clk => clk,
          rst => rst,
          RAM_addr => RAM_addr,
          RAM_data_bus => RAM_data_bus,
          RAM_oe => RAM_oe,
          RAM_we => RAM_we,
          RAM_ub => RAM_ub,
          RAM_lb => RAM_lb,
          RAM_ce => RAM_ce,
          write_addr => write_addr,
          write_data => write_data,
          write_en => write_en,
          write_clk => write_clk,
          read_addr => read_addr,
          read_data => read_data,
          read_oe => read_oe,
          read_ce => read_ce,
          mode => mode
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   write_clk_process :process
   begin
		write_clk <= '0';
		wait for write_clk_period/2;
		write_clk <= '1';
		wait for write_clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
			rst <= '1';
      wait for 600 ns;
			rst <= '0';
		wait for 100 ns;
			write_data <= x"05";
			write_addr <= x"0000006A";
			mode <= '1';
			write_en <= '1';
		wait for 10 ns;
			write_data <= x"A0";
			write_addr <= x"0000007B";
			mode <= '1';
			write_en <= '1';
		wait for 10 ns;
			write_en <= '0';
			mode <= '1';
		wait for 500 ns;
			mode <= '0';
      wait;
   end process;

END;
