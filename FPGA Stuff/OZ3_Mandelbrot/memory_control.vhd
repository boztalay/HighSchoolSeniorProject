library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;   

entity memory_control is
	port (clk : in std_logic;
		  rst : in std_logic;
	
		  cpu_vid : in std_logic;
		  
		  cpu_data : in std_logic_vector(15 downto 0);
		  cpu_addr : in std_logic_vector(22 downto 0);
		  cpu_valid : in std_logic;
		  
		  vid_data : out std_logic_vector(15 downto 0);
		  vid_addr : in std_logic_vector(22 downto 0);
		  
		  RAM_addr : out std_logic_vector(22 downto 0);
		  RAM_data_bus : inout std_logic_vector(15 downto 0);
		  RAM_oe : out std_logic;
		  RAM_we : out std_logic;  
		  RAM_ub : out std_logic;
		  RAM_lb : out std_logic;
		  RAM_ce : out std_logic);	    
end memory_control;

architecture behavioral of memory_control is

type state_type is (start, check_cpu_vid, check_cpu_valid, write_cpu_data_setup, write_cpu_data_write);				  
signal state, next_state : state_type;

signal latency_cnt : std_logic_vector(3 downto 0);

signal RAM_data_bus_in : std_logic_vector(15 downto 0);
signal RAM_data_bus_out : std_logic_vector(15 downto 0);

signal wr_RAM_oe : std_logic;
signal wr_RAM_we : std_logic; 
signal wr_RAM_ce : std_logic; 

begin
	
	next_state_sync: process (clk, rst) is
	begin
		if rst = '1' then
			state <= start;
			latency_cnt <= "0001"; 
		else
			state <= next_state;
			if state = next_state then
				latency_cnt <= latency_cnt + 1;
			else
				latency_cnt <= "0001";
			end if;
		end if;
	end process;
	
	next_state_logic: process (state, cpu_vid, cpu_valid, vid_addr, latency_cnt) is
	begin
		case (state) is
			when start =>
				next_state <= check_cpu_vid;
			when check_cpu_vid =>
				if cpu_vid = '0' then
					next_state <= check_cpu_vid; --Stay here if it's just reading memory
				else
					next_state <= check_cpu_valid; --Else, go write some data
				end if;
			when check_cpu_valid =>
				if cpu_valid = '0' then
					next_state <= check_cpu_valid;
				else
					next_state <= write_cpu_data_setup;
				end if;
			when write_cpu_data_setup =>
				if latency_cnt > 2 then
					next_state <= write_cpu_data_write;
				else
					next_state <= write_cpu_data_setup;
				end if;
			when write_cpu_data_write =>
				if latency_cnt > 2 then
					next_state <= check_cpu_vid;
				else
					next_state <= write_cpu_data_write;
				end if;
		end case;
	end process;
	
	in_state : process (state, cpu_vid, RAM_data_bus_in) is
	begin
		RAM_data_bus_out <= (others => '0');
		wr_RAM_ce <= '1';
		wr_RAM_oe <= '1';
		wr_RAM_we <= '1';
		
		case (state) is
			when start =>
				--Reset/default state for all signals
			when check_cpu_vid =>
				--Taken care of in defaults and MUX for read signals
			when check_cpu_valid =>
				--Default signals, wating for data to be valid from the CPU
			when write_cpu_data_setup =>
				wr_RAM_ce <= '0';
				wr_RAM_oe <= '1';
				wr_RAM_we <= '0';
			when write_cpu_data_write =>
				wr_RAM_ce <= '0';
				wr_RAM_oe <= '1';
				wr_RAM_we <= '0';
				RAM_data_bus_out <= cpu_data;
		end case;
	end process;
	
	RAM_data_bus <= RAM_data_bus_out when cpu_vid = '1' else (others => 'Z');
	RAM_data_bus_in <= RAM_data_bus;
	
	--MUX FOR SIGNALS (LB/UB ALWAYS) (controlled by cpu/vid)
	RAM_sigs_MUX: process (wr_RAM_ce, wr_RAM_oe, wr_RAM_we, cpu_vid) is
	begin
		--Always zero
		RAM_lb <= '0';
		RAM_ub <= '0';
		
		--Defaults
		RAM_ce <= '1';
		RAM_oe <= '1';
		RAM_we <= '1';
		
		if cpu_vid = '0' then --Video control, read memory
			RAM_ce <= '0';
			RAM_oe <= '0';
			RAM_we <= '1';
			RAM_addr <= vid_addr;
		else
			RAM_ce <= wr_RAM_ce;
			RAM_oe <= wr_RAM_oe;
			RAM_we <= wr_RAM_we;
			RAM_addr <= cpu_addr;
		end if;			
	end process;
			
end behavioral;