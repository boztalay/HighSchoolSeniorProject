library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_640x480 is
			Port ( clk, clr : in STD_LOGIC;
					 hsync : out STD_LOGIC;
					 vsync : out STD_LOGIC;
					 hc : out STD_LOGIC_VECTOR(9 downto 0);
					 vc : out STD_LOGIC_VECTOR(9 downto 0);
					 pix : out std_logic_vector(22 downto 0);
					 vidon : out STD_LOGIC);
end vga_640x480;

architecture Behavioral of vga_640x480 is

constant hpixels: STD_LOGIC_VECTOR(9 downto 0) := "1100100000";
		--Pixels in a horizontal line = 800
constant vlines : STD_LOGIC_VECTOR(9 downto 0) := "1000001001";
		--Lines in the image = 521
constant hbp : STD_LOGIC_VECTOR(9 downto 0) := "0010010000";
		--Horizontal back porch = 144
constant hfp : STD_LOGIC_VECTOR(9 downto 0) := "1100010000";
		--Horiztonal front porch = 748
constant vbp : STD_LOGIC_VECTOR(9 downto 0) := "0000011111";
		--Vertical back porch = 31
constant vfp : STD_LOGIC_VECTOR(9 downto 0) := "0111111111";
		--Vertical front porch = 511
signal hcs, vcs: STD_LOGIC_VECTOR(9 downto 0);
		--Horiztonal and vertical counters
signal vsenable : STD_LOGIC;
--Enable for the vertical counter
	
signal hsync_s, vsync_s, vidon_s : STD_LOGIC;  

signal pix_count, pix_count_next : std_logic_vector(22 downto 0);
signal pix_count_clr : std_logic;

begin
	--Counter for the horizontal sync signal
	process(clk, clr)
	begin
		if clr = '1' then
			hcs <= "0000000000";
			pix_count <= (others => '0');
			pix_count_next <= (others => '0');
		elsif(clk'event and clk = '1') then
			if hcs = hpixels - 1 then
				--The counter has reached the end of pixel count, reset
					hcs <= "0000000000";
				--Enable the vertical counter
					vsenable <= '1';
			else
				--Increment the horizontal counter
				hcs <= hcs + 1;	 
				--Increment the pixel counter
				if pix_count_clr = '1' then
					pix_count_next <= (others => '0');
				elsif vidon_s = '1' then
					pix_count_next <= pix_count_next + 1;	   
				end if;
				--Leave vsenable off
				vsenable <= '0'; 
				
				pix_count <= pix_count_next;
			end if;
		end if;
	end process;
	
	--Horizontal sync pulse is low when hc is 0-127
	hsync_s <= '0' when hcs < 128 else '1';
	
	--Counter for the vertical sync signal
	process(clk, clr)
	begin
		if clr = '1' then
			vcs <= "0000000000";
			pix_count_clr <= '0';
		elsif(clk'event and clk = '1' and vsenable = '1') then
			--Increment when enabled
			if vcs = vlines - 1 then
				--Reset when the number of lines is reached
				vcs <= "0000000000";
				pix_count_clr <= '1';
			else
				--Increment vertical counter
				vcs <= vcs + 1;	 
				pix_count_clr <= '0';
			end if;
		end if;
	end process;
	
	--Vertical sync pulse is low when vc is 0 or 1
	vsync_s <= '0' when vcs < 2 else '1';
	
	--Enable video out when within the porches
	vidon_s <= '1' when (((hcs < hfp) and (hcs >= hbp)) and ((vcs < vfp) and (vcs >= vbp))) else '0';
	--vidon_s <= (vsync_s and hsync_s); 
	vidon <= vidon_s;
						
	--Output horizontal and vertical counters
	hc <= hcs;
	vc <= vcs; 
	
	hsync <= hsync_s;
	vsync <= vsync_s;
	
	pix <= pix_count;

end Behavioral;

