library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity clk_mgt is
	port(clk50 : in std_logic;
		  rst : in std_logic;
		  clk12 : out std_logic;
		  clk25 : out std_logic);
end clk_mgt;

architecture Behavioral of clk_mgt is

signal clk_count : std_logic_vector(7 downto 0);

begin
--
--	DCM_1 : DCM
--    generic map (
--      CLKDV_DIVIDE => 2.0, --  Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
--                           --     7.0,7.5,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0 or 16.0
--      CLKFX_DIVIDE => 10,   --  Can be any interger from 1 to 32
--	   CLKFX_MULTIPLY => 2, --  Can be any integer from 1 to 32
--      CLKIN_DIVIDE_BY_2 => FALSE, --  TRUE/FALSE to enable CLKIN divide by two feature
--      CLKIN_PERIOD => 20.0,          --  Specify period of input clock
--      CLKOUT_PHASE_SHIFT => "NONE", --  Specify phase shift of NONE, FIXED or VARIABLE
--      CLK_FEEDBACK => "NONE",         --  Specify clock feedback of NONE, 1X or 2X
--      DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS", --  SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or
--                                             --     an integer from 0 to 15
--      DFS_FREQUENCY_MODE => "LOW",     --  HIGH or LOW frequency mode for frequency synthesis
--      DLL_FREQUENCY_MODE => "LOW",     --  HIGH or LOW frequency mode for DLL
--      DUTY_CYCLE_CORRECTION => TRUE, --  Duty cycle correction, TRUE or FALSE
--      FACTORY_JF => X"C080",          --  FACTORY JF Values
--      PHASE_SHIFT => 0,        --  Amount of fixed phase shift from -255 to 255
--      STARTUP_WAIT => FALSE) --  Delay configuration DONE until DCM LOCK, TRUE/FALSE
--    port map (
--      CLKFX => clk10,   -- DCM CLK synthesis out (M/D)
--      CLKIN => clk50
--	);

	clk_ctr : process (clk50, rst) is
	begin
		if rst = '1' then
			clk_count <= (others => '0');
		elsif rising_edge(clk50) then
			clk_count <= clk_count + 1;
		end if;	
	end process;
	
	clk25 <= clk_count(0);
	clk12 <= clk_count(1);

end Behavioral;

