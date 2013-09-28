--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:58:26 05/17/2011
-- Design Name:   
-- Module Name:   C:/Users/Ben/Desktop/Folders/Projects/Personal/Senior Project/FPGA Stuff/OZ3_Mandelbrot/OZ3_Sys_Top_TB.vhd
-- Project Name:  OZ3_Mandelbrot
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: OZ3_Sys_Top
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
 
ENTITY OZ3_Sys_Top_TB IS
END OZ3_Sys_Top_TB;
 
ARCHITECTURE behavior OF OZ3_Sys_Top_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OZ3_Sys_Top
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: OZ3_Sys_Top PORT MAP (
          clk => clk,
          rst => rst
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
      wait for 1000 ns;	
			rst <= '0';

      wait;
   end process;

END;
