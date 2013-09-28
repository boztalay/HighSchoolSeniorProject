library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity mem_control is
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
end mem_control;

architecture Behavioral of mem_control is

type state_type is (reset, check_mode, check_data, setup_sigs, we_low1, we_low2, we_high);				  
signal state, next_state : state_type;

signal smRAM_ce, smRAM_we, smRAM_oe : std_logic;
signal smRAM_addr : std_logic_vector(22 downto 0);
signal smRAM_data : std_logic_vector(15 downto 0);

signal pix1_reg, pix2_reg : std_logic_vector(7 downto 0);
signal addr_reg : std_logic_vector(22 downto 0);
signal big_reg : std_logic_vector(38 downto 0);
signal big_reg_full, big_reg_clr : std_logic;

begin

	RAM_lb <= '0';
	RAM_ub <= '0';
	
	dataregs : process (clk, rst) is
	begin
		if rst = '1' then
			pix1_reg <= (others => '0');
			pix2_reg <= (others => '0');
			addr_reg <= (others => '0');
			big_reg <= (others => '0');
			big_reg_full <= '0';
		elsif falling_edge(clk) then
			if big_we = '1' then
				big_reg <= addr_reg & pix2_reg & pix1_reg;
				big_reg_full <= '1';
			end if;
			
			if pix1_we = '1' then
				pix1_reg <= write_data(7 downto 0);
			end if;
			
			if pix2_we = '1' then
				pix2_reg <= write_data(7 downto 0);
			end if;
			
			if addr_we = '1' then
				addr_reg <= write_data(22 downto 0);
			end if;
			
			if big_reg_clr = '1' then
				big_reg <= (others => '0');
				big_reg_full <= '0';
			end if;
		end if;
	end process;

	SM_sync : process (clk, rst) is
	begin
		if rst = '1' then
			state <= reset;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process;
	
	SM_next : process (state, mode) is
	begin
		case (state) is
			when reset =>
				next_state <= check_mode;
			when check_mode =>
				if mode = '1' then
					next_state <= check_data;
				else
					next_state <= check_mode;
				end if;
			when check_data =>
				if big_reg_full = '1' then
					next_state <= setup_sigs;
				else
					next_state <= check_mode;
				end if;
			when setup_sigs =>
				next_state <= we_low1;
			when we_low1 =>
				next_state <= we_low2;
			when we_low2 =>
				next_state <= we_high;
			when we_high =>
				next_state <= check_mode;
			when others =>
				next_state <= reset;
		end case;	
	end process;
	
	SM_guts : process (state) is
	begin
		--Default outputs
		smRAM_ce <= '1';
		smRAM_oe <= '1';
		smRAM_we <= '1';
		smRAM_data <= (others => '0');
		smRAM_addr <= (others => '0');
		big_reg_clr <= '0';
	
		case (state) is
			when reset =>
				--Defaults
			when check_mode =>
				--Defaults
			when check_data =>
				--Defaults
			when setup_sigs =>
				smRAM_ce <= '0';
				smRAM_oe <= '1';
				smRAM_we <= '1';
				smRAM_data <= big_reg(15 downto 0);
				smRAM_addr <= big_reg(38 downto 16);
			when we_low1 =>
				smRAM_ce <= '0';
				smRAM_oe <= '1';
				smRAM_we <= '0';
				smRAM_data <= big_reg(15 downto 0);
				smRAM_addr <= big_reg(38 downto 16);
			when we_low2 =>
				smRAM_ce <= '0';
				smRAM_oe <= '1';
				smRAM_we <= '0';
				smRAM_data <= big_reg(15 downto 0);
				smRAM_addr <= big_reg(38 downto 16);
			when we_high =>
				big_reg_clr <= '1';
			when others =>
				--Defaults
		end case;	
	end process;
	
	--Tri-state for the RAM data bus
	RAM_data_bus <= smRAM_data when mode = '1' else (others => 'Z');
	read_data <= RAM_data_bus;
	
	RAM_mux : process (smRAM_ce, smRAM_oe, smRAM_we, smRAM_addr, read_addr, mode, rst) is
	begin
		if rst = '1' then
			RAM_ce <= '1';
			RAM_oe <= '1';
			RAM_we <= '1';
			RAM_addr <= (others => '0');
		else
			if mode = '1' then --In write mode, CPU has control
				RAM_ce <= smRAM_ce;
				RAM_oe <= smRAM_oe;
				RAM_we <= smRAM_we;
				RAM_addr <= smRAM_addr;
			else					--In read mode, video controller has control
				RAM_ce <= '0';
				RAM_oe <= '0';
				RAM_we <= '1';
				RAM_addr <= read_addr(22 downto 0);
			end if;
		end if;
	end process;

end Behavioral;




--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;  
--
--library UNISIM;
--use UNISIM.VComponents.all;
--
--entity mem_control is
--	port(
--		clk : in std_logic;
--		rst : in std_logic;
--		
--		RAM_addr : out std_logic_vector(22 downto 0);
--		RAM_data_bus : inout std_logic_vector(15 downto 0);
--		RAM_oe : out std_logic;
--		RAM_we : out std_logic;
--		RAM_ub : out std_logic;
--		RAM_lb : out std_logic;
--		RAM_ce : out std_logic;
--		
--		write_data : in std_logic_vector(30 downto 0);
--		write_en : in std_logic;
--		write_clk : in std_logic;
--		
--		read_addr : in std_logic_vector(31 downto 0);
--		read_data : out std_logic_vector(15 downto 0);
--		
--		mode : in std_logic		
--		);
--end mem_control;
--
--architecture Behavioral of mem_control is
--
--component FIFO30x16
--  PORT (
--    rst : IN STD_LOGIC;
--    wr_clk : IN STD_LOGIC;
--    rd_clk : IN STD_LOGIC;
--    din : IN STD_LOGIC_VECTOR(30 DOWNTO 0);
--    wr_en : IN STD_LOGIC;
--    rd_en : IN STD_LOGIC;
--    dout : OUT STD_LOGIC_VECTOR(30 DOWNTO 0);
--    full : OUT STD_LOGIC;
--    empty : OUT STD_LOGIC
--  );
--end component;
--
--type state_type is (reset, check_mode, check_data, read_out1, data1write, read_out2, setup_sigs, we_low1, we_low2, we_high);				  
--signal state, next_state : state_type;
--
--signal smRAM_ce, smRAM_we, smRAM_oe : std_logic;
--signal smRAM_addr : std_logic_vector(22 downto 0);
--signal smRAM_data : std_logic_vector(15 downto 0);
--signal wrFIFO_rd_clk, wrFIFO_wr_clk, wrFIFO_re, wrFIFO_we, wrFIFO_empty : std_logic;
--signal wrFIFO_dout, wrFIFO_din : std_logic_vector(30 downto 0);
--
--signal smRAM_data1 : std_logic_vector(7 downto 0);
--signal smRAM_data1_we : std_logic;
--
--begin
--
--	RAM_lb <= '0';
--	RAM_ub <= '0';
--	
--	wrFIFO_rd_clk <= not clk;
--	wrFIFO_wr_clk <= write_clk;
--	wrFIFO_din <= write_data;
--	wrFIFO_we <= write_en;
--
--	writeFIFO : FIFO30x16
--	PORT MAP (
--		 rst => rst,
--		 wr_clk => wrFIFO_wr_clk,
--		 rd_clk => wrFIFO_rd_clk,
--		 din => wrFIFO_din,
--		 wr_en => wrFIFO_we,
--		 rd_en => wrFIFO_re,
--		 dout => wrFIFO_dout,
--		 full => open,
--		 empty => wrFIFO_empty
--	);
--	
--	datareg : process (clk, rst) is
--	begin
--		if rst = '1' then
--			smRAM_data1 <= (others => '0');
--		elsif falling_edge(clk) then
--			if smRAM_data1_we = '1' then
--				smRAM_data1 <= wrFIFO_dout(7 downto 0);
--			end if;
--		end if;
--	end process;
--
--	SM_sync : process (clk, rst) is
--	begin
--		if rst = '1' then
--			state <= reset;
--		elsif rising_edge(clk) then
--			state <= next_state;
--		end if;
--	end process;
--	
--	SM_next : process (state, mode, wrFIFO_empty) is
--		variable gotfirst : std_logic := '0';
--	begin
--		case (state) is
--			when reset =>
--				next_state <= check_mode;
--				gotfirst := '0';
--			when check_mode =>
--				if mode = '1' then--and wrFIFO_empty = '0' then
--					next_state <= check_data;
--				else
--					next_state <= check_mode;
--				end if;
--			when check_data =>
--				if gotfirst = '1' then
--					next_state <= read_out2;
--				else
--					next_state <= read_out1;
--				end if;
--			when read_out1 =>
--				next_state <= data1write;
--			when data1write =>
--				next_state <= check_mode;
--				gotfirst := '1';
--			when read_out2 =>
--				next_state <= setup_sigs;
--			when setup_sigs =>
--				next_state <= we_low1;
--			when we_low1 =>
--				next_state <= we_low2;
--			when we_low2 =>
--				next_state <= we_high;
--			when we_high =>
--				next_state <= check_mode;
--				gotfirst := '0';
--			when others =>
--				next_state <= reset;
--		end case;	
--	end process;
--	
--	SM_guts : process (state, wrFIFO_dout, smRAM_data1) is
--	begin
--		--Default outputs
--		smRAM_ce <= '1';
--		smRAM_oe <= '1';
--		smRAM_we <= '1';
--		smRAM_data <= (others => '0');
--		smRAM_addr <= (others => '0');
--		wrFIFO_re <= '0';	
--		smRAM_data1_we <= '0';
--	
--		case (state) is
--			when reset =>
--				--Defaults
--			when check_mode =>
--				--Defaults
--			when check_data =>
--				--Defaults
--			when read_out1 =>
--				wrFIFO_re <= '1';
--			when data1write =>
--				smRAM_data1_we <= '1';
--			when read_out2 =>
--				wrFIFO_re <= '1';
--			when setup_sigs =>
--				smRAM_ce <= '0';
--				smRAM_oe <= '1';
--				smRAM_we <= '1';
--				smRAM_data <= smRAM_data1 & wrFIFO_dout(7 downto 0);
--				smRAM_addr <= wrFIFO_dout(30 downto 8);
--			when we_low1 =>
--				smRAM_ce <= '0';
--				smRAM_oe <= '1';
--				smRAM_we <= '0';
--				smRAM_data <= smRAM_data1 & wrFIFO_dout(7 downto 0);
--				smRAM_addr <= wrFIFO_dout(30 downto 8);
--			when we_low2 =>
--				smRAM_ce <= '0';
--				smRAM_oe <= '1';
--				smRAM_we <= '0';
--				smRAM_data <= smRAM_data1 & wrFIFO_dout(7 downto 0);
--				smRAM_addr <= wrFIFO_dout(30 downto 8);
--			when we_high =>
--				--Defaults
--			when others =>
--				--Defaults
--		end case;	
--	end process;
--	
--	--Tri-state for the RAM data bus
--	RAM_data_bus <= smRAM_data when mode = '1' else (others => 'Z');
--	read_data <= RAM_data_bus;
--	
--	RAM_mux : process (smRAM_ce, smRAM_oe, smRAM_we, smRAM_addr, read_addr, mode, rst) is
--	begin
--		if rst = '1' then
--			RAM_ce <= '1';
--			RAM_oe <= '1';
--			RAM_we <= '1';
--			RAM_addr <= (others => '0');
--		else
--			if mode = '1' then --In write mode, CPU has control
--				RAM_ce <= smRAM_ce;
--				RAM_oe <= smRAM_oe;
--				RAM_we <= smRAM_we;
--				RAM_addr <= smRAM_addr;
--			else					--In read mode, video controller has control
--				RAM_ce <= '0';
--				RAM_oe <= '0';
--				RAM_we <= '1';
--				RAM_addr <= read_addr(22 downto 0);
--			end if;
--		end if;
--	end process;
--
--end Behavioral;
--
