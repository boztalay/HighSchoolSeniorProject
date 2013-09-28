library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity ctl_unit is
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
end ctl_unit;

architecture Behavioral of ctl_unit is

signal instruction : std_logic_vector(11 downto 0);
signal opcode : std_logic_vector(5 downto 0);

signal ALU_flags_r : std_logic_vector(3 downto 0);
signal ALU_flags_en, ALU_flags_en_r : std_logic;
signal stack_e0_r, stack_e1_r : std_logic_vector(31 downto 0);

begin

	--Split the instruction and send addresses out
	instruction_addr <= PC_data_out;
	immediate_addr <= instruction(5 downto 0);
	opcode <= instruction(11 downto 6);
	
	ctl_immediate <= immediate_in;
	
	--Latch in the instruction and other data
	latch : process (clk, rst) is
	begin
		if rst = '1' then
			instruction <= (others => '0');
			ALU_flags_r <= (others => '0');
			stack_e0_r <= (others => '0');
			stack_e1_r <= (others => '0');
		elsif rising_edge(clk) then
			instruction <= instruction_in;
			if ALU_flags_en_r = '1' then
				ALU_flags_r <= ALU_flags;
			end if;
			stack_e0_r <= stack_e0;
			stack_e1_r <= stack_e1;
		end if;
	end process;
	
	--Latch the ALU_flags_en signal on falling
	latch_fall : process(clk, rst) is
	begin
		if rst = '1' then
			ALU_flags_en_r <= '0';
		elsif falling_edge(clk) then
			ALU_flags_en_r <= ALU_flags_en;
		end if;
	end process;
	
	--Decode the instruction
	decode : process (opcode, immediate_in, ALU_flags_r, stack_e0_r, stack_e1_r) is
	begin
		--Default outputs
		ALU_sel <= (others => '0');
		  
	   stack_e0_sel <= (others => '0');
	   stack_e1_sel <= (others => '0');
	   stack_e2_sel <= (others => '0');		  
	   stack_e0_en <= '0';
	   stack_e1_en <= '0';
	   stack_e2_en <= '0';	  
	   stack_push <= '0';
	   stack_pop <= '0';
	   stack_pop2 <= '0';
	  
	   RS_push <= '0';
	   RS_pop <= '0';
	   
	   mem_we <= '0';
	  
	   PC_load <= '0';
	   PC_inc <= '1';
	  
	   IO_oport_en <= '0';
	   IO_opins_en <= '0';
	  
	   stack_MUX_sel <= (others => '0');
		PC_MUX_sel <= '0';
		
		ALU_flags_en <= '0';
		
		if opcode(5 downto 4) = "00" then --Arithmetic/Logic instruction	
			--Update the flags register
			ALU_flags_en <= '1';
		
			--Catch a couple special cases, nop and cp
			if opcode(3 downto 0) = "0000" then --nop
				--do nothing, leave the defaults as defaults
			elsif opcode(3 downto 0) = "0110" then --cp
				--send the operands to the ALU to generate condition flags, but don't manipulate the stack
				ALU_sel <= opcode(3 downto 0) - 1;				
			elsif ((opcode(3 downto 0) >= "0001") and (opcode(3 downto 0) <= "0101"))
					or (opcode(3 downto 0) = "1011") or (opcode(3 downto 0) = "1100") then --Two-operand instructions
				ALU_sel <= opcode(3 downto 0) - 1;
				
				stack_e0_sel <= (others => '0'); --e0 gets data_in
				stack_e1_sel <= "01";				--e1 gets e2
				stack_e2_sel <= "01"; 				--e2 gets the top of the storage elements
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';	  
				stack_push <= '0';
				stack_pop <= '1'; 					--Pop one off the storage elements
				stack_pop2 <= '0';
				
				stack_MUX_sel <= "001"; 			--Data_in gets ALU_result
				
			elsif (opcode(3 downto 0) >= "0111") and (opcode(3 downto 0) <= "1010") then --Single-operand instructions
				ALU_sel <= opcode(3 downto 0) - 1;
				
				stack_e0_sel <= (others => '0'); --e0 gets data_in
				stack_e1_sel <= (others => '0');
				stack_e2_sel <= (others => '0');
				stack_e0_en <= '1';
				stack_e1_en <= '0';
				stack_e2_en <= '0';	  
				stack_push <= '0';
				stack_pop <= '0';
				stack_pop2 <= '0';
				
				stack_MUX_sel <= "001"; 			--Data_in gets ALU_result
			end if;			
		elsif opcode(5 downto 4) = "01" then --Stack manipulation instruction
			--This is just going to have to be brute-force, no real decoding here						
			case opcode(3 downto 0) is			
				when x"0" => --drop
					stack_e0_sel <= "01";
					stack_e1_sel <= "01";
					stack_e2_sel <= "01";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '1';
					stack_pop2 <= '0';
				
				when x"1" => --swap
					stack_e0_sel <= "01";
					stack_e1_sel <= "00";
					stack_e2_sel <= "00";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '0';
					
					stack_push <= '0';
					stack_pop <= '0';
					stack_pop2 <= '0';
					
				when x"2" => --nrot
					stack_e0_sel <= "01";
					stack_e1_sel <= "01";
					stack_e2_sel <= "10";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '0';
					stack_pop2 <= '0';
					
				when x"3" => --rot
					stack_e0_sel <= "10";
					stack_e1_sel <= "00";
					stack_e2_sel <= "00";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '0';
					stack_pop2 <= '0';  
					
				when x"4" => --push
					stack_e0_sel <= "00";
					stack_e1_sel <= "00";
					stack_e2_sel <= "00";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '1';
					stack_pop <= '0';
					stack_pop2 <= '0';
					
					stack_MUX_sel <= "000"; 			--Data_in gets ctl_immediate
					
				when x"5" => --dup
					stack_e0_sel <= "00";
					stack_e1_sel <= "00";
					stack_e2_sel <= "00";	
					
					stack_e0_en <= '0';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '1';
					stack_pop <= '0';
					stack_pop2 <= '0'; 
					
				when x"6" => --nrd
					stack_e0_sel <= "10";
					stack_e1_sel <= "00";
					stack_e2_sel <= "01";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '1';
					stack_pop2 <= '0'; 
					
				when x"7" => --rd
					stack_e0_sel <= "00";
					stack_e1_sel <= "00";
					stack_e2_sel <= "01";	
					
					stack_e0_en <= '0';
					stack_e1_en <= '0';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '1';
					stack_pop2 <= '0'; 
					
				when x"8" => --nrds
					stack_e0_sel <= "00";
					stack_e1_sel <= "01";
					stack_e2_sel <= "01";	
					
					stack_e0_en <= '0';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '1';
					stack_pop2 <= '0';
					
				when x"9" => --rds
					stack_e0_sel <= "01";
					stack_e1_sel <= "00";
					stack_e2_sel <= "01";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '0';
					stack_pop <= '1';
					stack_pop2 <= '0'; 
					
				when x"A" => --over
					stack_e0_sel <= "01";
					stack_e1_sel <= "00";
					stack_e2_sel <= "00";	
					
					stack_e0_en <= '1';
					stack_e1_en <= '1';
					stack_e2_en <= '1';
					
					stack_push <= '1';
					stack_pop <= '0';
					stack_pop2 <= '0';
				when others =>
					--do nothing
			end case;		
		elsif opcode(5 downto 4) = "10" then --Program control instruction
			if opcode(3 downto 0) = "0000" then --JP instruction
				--Pop one from the stack
				stack_e0_sel <= "01";
				stack_e1_sel <= "01";
				stack_e2_sel <= "01";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';
				
				stack_push <= '0';
				stack_pop <= '1';
				stack_pop2 <= '0';
				
				--Set up the PC to take the top element of the data stack
				PC_MUX_sel <= '0';
				PC_load <= '1';
				PC_inc <= '0';
			elsif opcode(3 downto 0) = "0001" then --BRN instruction
				--Pop two from the stack
				stack_e0_sel <= "10";
				stack_e1_sel <= "10";
				stack_e2_sel <= "11";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';
				
				stack_push <= '0';
				stack_pop <= '0';
				stack_pop2 <= '1';
				
				--Check the selected flag to see if it's true
				if ALU_flags_r(conv_integer(unsigned(stack_e1_r(1 downto 0)))) = '1' then
					--Set up the PC to take the top element of the data stack
					PC_MUX_sel <= '0';
					PC_load <= '1';
					PC_inc <= '0';
				end if;
			elsif opcode(3 downto 0) = "0010" then --RET instruction
				--Set up the PC to take the top element of the return stack and pop the return stack
				PC_MUX_sel <= '1';
				PC_load <= '1';
				PC_inc <= '0';
				
				RS_pop <= '1';
			elsif opcode(3 downto 0) = "0011" then --PSHPC instruction
				RS_push <= '1';
			end if;
		elsif opcode(5 downto 4) = "11" then --Memory and I/O instruction
			if opcode(3 downto 0) = "0000" then --RD_MEM instruction
				--Replace the top element of the stack
				stack_e0_sel <= "00";
				stack_e1_sel <= "00";
				stack_e2_sel <= "00";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '0';
				stack_e2_en <= '0';
				
				stack_push <= '0';
				stack_pop <= '0';
				stack_pop2 <= '0';
				
				stack_MUX_sel <= "100"; --Data_in gets mem_data_out
			elsif opcode(3 downto 0) = "0001" then --WR_MEM instruction
				--Pop two from the stack
				stack_e0_sel <= "10";
				stack_e1_sel <= "10";
				stack_e2_sel <= "11";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';
				
				stack_push <= '0';
				stack_pop <= '0';
				stack_pop2 <= '1';
				
				--enable writing
				mem_we <= '1';
			elsif opcode(3 downto 0) = "0010" then --RD_PRT instruction
				--Push data onto the stack
				stack_e0_sel <= "00";
				stack_e1_sel <= "00";
				stack_e2_sel <= "00";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';
				
				stack_push <= '1';
				stack_pop <= '0';
				stack_pop2 <= '0';
				
				stack_MUX_sel <= "011"; 			--Data_in gets IO_iport_data
			elsif opcode(3 downto 0) = "0011" then --WR_PRT instruction
				--Pop one from the stack
				stack_e0_sel <= "01";
				stack_e1_sel <= "01";
				stack_e2_sel <= "01";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';
				
				stack_push <= '0';
				stack_pop <= '1';
				stack_pop2 <= '0';
				
				--enable writing to the port
				IO_oport_en <= '1';
			elsif opcode(3 downto 0) = "0100" then --RD_PIN instruction
				--Replace the top element of the stack
				stack_e0_sel <= "00";
				stack_e1_sel <= "00";
				stack_e2_sel <= "00";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '0';
				stack_e2_en <= '0';
				
				stack_push <= '0';
				stack_pop <= '0';
				stack_pop2 <= '0';
				
				stack_MUX_sel <= "010"; --Data_in gets IO_ipins_data
			elsif opcode(3 downto 0) = "0101" then --WR_PIN instruction
				--Pop two from the stack
				stack_e0_sel <= "10";
				stack_e1_sel <= "10";
				stack_e2_sel <= "11";	
				
				stack_e0_en <= '1';
				stack_e1_en <= '1';
				stack_e2_en <= '1';
				
				stack_push <= '0';
				stack_pop <= '0';
				stack_pop2 <= '1';
				
				--enable writing to the pins
				IO_opins_en <= '1';
			end if;
		end if;
	end process;


end Behavioral;

