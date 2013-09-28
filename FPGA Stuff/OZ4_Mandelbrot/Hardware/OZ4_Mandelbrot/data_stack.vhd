library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity data_stack is
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
end data_stack;

architecture behavioral of data_stack is

type stack_array is array(12 downto 0) of std_logic_vector(31 downto 0);
signal stg_elements : stack_array; --The storage elements of the stack
signal stg_elements_next : stack_array; --The next values to be taken on in the storage stack

signal e0_r : std_logic_vector(31 downto 0); --The working elements
signal e1_r : std_logic_vector(31 downto 0);
signal e2_r : std_logic_vector(31 downto 0);

signal e0_next : std_logic_vector(31 downto 0);	--The values to be taken by the working elements
signal e1_next : std_logic_vector(31 downto 0); --at the next falling edge
signal e2_next : std_logic_vector(31 downto 0);

begin
	
	--The process that synchronously writes new values to the elements
	sync : process (clk, rst, e0_r, e1_r) is
	begin
		if rst = '1' then
			stg_elements <= (others => (others => '0'));
			e0_r <= (others => '0'); 
			e1_r <= (others => '0');
			e2_r <= (others => '0');
		elsif falling_edge(clk) then
			stg_elements <= stg_elements_next;
			
			if e0_en = '1' then
				e0_r <= e0_next;
			end if;	
			
			if e1_en = '1' then
				e1_r <= e1_next;
			end if;
			
			if e2_en = '1' then
				e2_r <= e2_next;
			end if;				
		end if;	
		
		e0_out <= e0_r;
		e1_out <= e1_r;
	end process;
	
	--Selects what will go on the eX_next signals	
	wkg_el_mux : process (rst, e0_sel, e1_sel, e2_sel, e0_r, e1_r, e2_r, stg_elements, data_in) is
	begin
		if rst = '1' then
			e0_next <= (others => '0');	
			e1_next <= (others => '0');
			e2_next <= (others => '0');
		else
			case (e0_sel) is
				when "00" =>
					e0_next <= data_in;
				when "01" =>
					e0_next <= e1_r;
				when "10" =>
					e0_next <= e2_r;
				when others =>
					e0_next <= (others => '0');	
			end case;
			
			case (e1_sel) is
				when "00" =>
					e1_next <= e0_r;
				when "01" =>
					e1_next <= e2_r;
				when "10" =>
					e1_next <= stg_elements(0);
				when others =>
					e1_next <= (others => '0');	
			end case; 
			
			case (e2_sel) is
				when "00" =>
					e2_next <= e1_r;
				when "01" =>
					e2_next <= stg_elements(0);
				when "10" =>
					e2_next <= e0_r;
				when others =>
					e2_next <= stg_elements(1);	
			end case;
		end if;
	end process;
	
	--Selects what goes on the stg_elements_next signal, depending on the operation
	stg_el_sel : process (rst, stg_elements, push, pop, pop2, e2_r) is
	begin
		if rst = '1' then
			stg_elements_next <= (others => (others => '0'));
		else
			if push = '1' then --Pusing a value onto to storage elements from e2
				stg_elements_next(0) <= e2_r;
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
				stg_elements_next(12) <= (others => '0');
			elsif pop2 = '1' then --Popping two values off the storage elements
				stg_elements_next(0) <= stg_elements(2);
				stg_elements_next(1) <= stg_elements(3);
				stg_elements_next(2) <= stg_elements(4);
				stg_elements_next(3) <= stg_elements(5);
				stg_elements_next(4) <= stg_elements(6);
				stg_elements_next(5) <= stg_elements(7);
				stg_elements_next(6) <= stg_elements(8);
				stg_elements_next(7) <= stg_elements(9);
				stg_elements_next(8) <= stg_elements(10);
				stg_elements_next(9) <= stg_elements(11);
				stg_elements_next(10) <= stg_elements(12);
				stg_elements_next(11) <= (others => '0');
				stg_elements_next(12) <= (others => '0');
			else
				stg_elements_next <= stg_elements;
			end if;
		end if;
	end process;
	
end behavioral;