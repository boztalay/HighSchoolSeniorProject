library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

library UNISIM;
use UNISIM.VComponents.all;
 
ENTITY FPMultiply_TB IS
END FPMultiply_TB;
 
ARCHITECTURE behavior OF FPMultiply_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FPMultiply
    PORT(
         A_in : IN  std_logic_vector(31 downto 0);
         B_in : IN  std_logic_vector(31 downto 0);
         R : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_in : std_logic_vector(31 downto 0) := (others => '0');
   signal B_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal R : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FPMultiply PORT MAP (
          A_in => A_in,
          B_in => B_in,
          R => R
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      A_in <= x"00000000";
		B_in <= x"00000000";
		wait for 50 ns;
		A_in <= x"7FFFFFFF";
		B_in <= x"7FFFFFFF";

      wait;
   end process;

END;
