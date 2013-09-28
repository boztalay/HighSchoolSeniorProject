library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity return_stack is
	port(clk : in std_logic;
		  rst : in std_logic;
		  
		  data_in : in std_logic_vector(31 downto 0);
		  data_out : out std_logic_vector(31 downto 0);
		  
		  push : in std_logic;
		  pop : in std_logic
		 );
end return_stack;

architecture behavioral of return_stack is

type stack_array is array(15 downto 0) of std_logic_vector(31 downto 0);
signal stg_elements : stack_array; --The storage elements of the stack
signal stg_elements_next : stack_array; --The next values to be taken on in the storage stack

begin

	--The process that synchronously writes new values to the elements
	sync : process (clk, rst) is
	begin
		if rst = '1' then
			stg_elements <= (others => (others => '0'));
		elsif falling_edge(clk) then
			stg_elements <= stg_elements_next;				
		end if;	
	end process;
	
	--Selects what goes on the stg_elements_next signal, depending on the operation
	stg_el_sel : process (rst, stg_elements, push, pop, data_in) is
	begin
		if rst = '1' then
			stg_elements_next <= (others => (others => '0'));
		else
			if push = '1' then --Pusing a value onto to storage elements from data_in
				stg_elements_next(0) <= (data_in + 2); --Add two so that it returns to a point beyond the jp
				stg_elements_next(1) <= stg_elements(0);
				stg_elements_next(2) <= stg_elements(1);
				stg_elements_next(3) <= stg_elements(2);
				stg_elements_next(4) <= stg_elements(3);
				stg_elements_next(5) <= stg_elements(4);
				stg_elements_next(6) <= stg_elements(5);
				stg_elements_next(7) <= stg_elements(6);
				stg_elements_next(8) <= stg_elements(7);
				stg_elements_next(9) <= stg_elements(8);
				stg_elements_next(10) <= stg_elements(9);
				stg_elements_next(11) <= stg_elements(10);
				stg_elements_next(12) <= stg_elements(11);
				stg_elements_next(13) <= stg_elements(12);
				stg_elements_next(14) <= stg_elements(13);
				stg_elements_next(15) <= stg_elements(14);
			elsif pop = '1' then --Popping a value off the storage elements
				stg_elements_next(0) <= stg_elements(1);
				stg_elements_next(1) <= stg_elements(2);
				stg_elements_next(2) <= stg_elements(3);
				stg_elements_next(3) <= stg_elements(4);
				stg_elements_next(4) <= stg_elements(5);
				stg_elements_next(5) <= stg_elements(6);
				stg_elements_next(6) <= stg_elements(7);
				stg_elements_next(7) <= stg_elements(8);
				stg_elements_next(8) <= stg_elements(9);
				stg_elements_next(9) <= stg_elements(10);
				stg_elements_next(10) <= stg_elements(11);
				stg_elements_next(11) <= stg_elements(12);
				stg_elements_next(12) <= stg_elements(13);
				stg_elements_next(13) <= stg_elements(14);
				stg_elements_next(14) <= stg_elements(15);
				stg_elements_next(15) <= (others => '0');
			else
				stg_elements_next <= stg_elements;
			end if;
		end if;
	end process;
	
	data_out <= stg_elements(0);

end Behavioral;

