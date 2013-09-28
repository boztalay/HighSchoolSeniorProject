library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

library UNISIM;
use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           sel : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0);
           flags : out  STD_LOGIC_VECTOR (3 downto 0));
end ALU;

architecture Behavioral of ALU is

component FPMultiply is
	port( A_in : in std_logic_vector(31 downto 0);
			B_in : in std_logic_vector(31 downto 0);
			R : out std_logic_vector(31 downto 0));
end component;

signal output, normal_output : std_logic_vector(32 downto 0); 
signal fixed_output : std_logic_vector(31 downto 0);

begin

	main: process(A, B, sel, fixed_output, normal_output, output) is
	begin
		--Set flags to 0 as default
		flags <= "0000";	   
		
		--This actually performs the operation chosen by the select lines
		--The reason the output variable is 33 bits wide is to accomodate for
		--the carry bit, and it also helps a lot with shifting operations. By
		--the way, I did try the built-in shift operations, but without much
		--luck.
		case sel is 
			when "0000" => --add
				normal_output <= ('0' & A(31 downto 0)) + ('0' & B(31 downto 0));
			when "0001" => --sub
				normal_output <= ('0' & A(31 downto 0)) - ('0' & B(31 downto 0));
			when "0010" => --and
				normal_output <= '0' & (A and B);
			when "0011" => --or
				normal_output <= '0' & (A or B);
			when "0100" => --xor
				normal_output <= '0' & (A xor B);
			when "0101" => --cp
				normal_output <= ('0' & A);
			when "0110" => --sll
				normal_output <= (A(31 downto 0) & '0');
			when "0111" => --srl
				normal_output <= ("00" & A(31 downto 1));
			when "1000" => --rol
				normal_output <= (A(0) & A(0) & A(31 downto 1));
			when "1001" => --ror
				normal_output <= (A(30) & A(30 downto 0) & A(31));
			when others =>
			    normal_output <= ('0' & A);
		end case;
		
		if sel(3 downto 1) = "101" then
			output <= '0' & fixed_output;
		else
			output <= normal_output;
		end if;
			
		--This if statement generates the flags
		if (A > B) then --Greater than
			flags(1) <= '1';
		elsif (A = B) then --Equal to
			flags(2) <= '1';
		elsif (A < B) then --Less than
			flags(3) <= '1';
		end if;
		flags(0) <= output(32); --Carry flag (33rd bit)
		
		result <= output(31 downto 0);
	end process;
	
	fpmul : FPMultiply
		port map(
			A_in => A,
			B_in => B,
			R => fixed_output
		);

end Behavioral;

