library IEEE;
use IEEE.std_logic_1164.all;

entity tb_top_level is
end tb_top_level;

architecture tb of tb_top_level is

component top_level
    Port ( clk                           : in  STD_LOGIC;
           reset_n                       : in  STD_LOGIC;
		   SW                            : in  STD_LOGIC_VECTOR (9 downto 0);
		   PB2						     : in std_logic; 
           LEDR                          : out STD_LOGIC_VECTOR (9 downto 0);
           HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : out STD_LOGIC_VECTOR (7 downto 0)
          );         
end component;

-- any of the below that are initialized are done so to replicate how the system would power on 
signal clk : STD_LOGIC := '0';
signal reset_n, PB2 : STD_LOGIC := '1';
signal SW : STD_LOGIC_VECTOR (9 downto 0) := "00"&"0000"&"0000";
signal LEDR : STD_LOGIC_VECTOR (9 downto 0);
signal HEX0,HEX1,HEX2,HEX3,HEX4,HEX5 : STD_LOGIC_VECTOR (7 downto 0);

signal TbSimEnded : std_logic := '0';
constant TbPeriod : time := 20 ns;

begin

	dut : top_level
	port map (clk     => clk,
              reset_n => reset_n,
              SW      => SW,
	          PB2     => PB2,
              LEDR    => LEDR,
              HEX0    => HEX0,
              HEX1    => HEX1,
              HEX2    => HEX2,
              HEX3    => HEX3,
              HEX4    => HEX4,
              HEX5    => HEX5
			 );
	
	clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';
	
	stimulus : process
	begin
	
	reset_n <= '0'; wait for 1000000 * TbPeriod;
	reset_n <= '1'; wait for 1000000 * TbPeriod;
	
	SW(7 downto 0) <= "1100"&"0110";
	
	-- test when S = 00, should see hex value of switch inputs at output
	SW(9 downto 8) <= "00"; wait for 1000000 * TbPeriod; 		 
	
	-- test hold behaviour
	PB2 <= '0'; wait for 35 ms; 								    -- wait for debounce result to update
	SW(7 downto 0) <= "0111"&"0111"; wait for 1000000 * TbPeriod;   -- output should not change with this
	PB2 <= '1';	wait for 45 ms; 									-- when we release PB2, we should see the new SW combo at the output after debounce has updated
	
	-- test when S = 01, should see distance value at output in cm
	SW(9 downto 8) <= "01"; wait for 1000000 * TbPeriod;	

	-- test when S = 10, should see voltage value at output in volts	
	SW(9 downto 8) <= "10"; wait for 1000000 * TbPeriod;			
	
	-- test reset behaviour
	reset_n <= '0'; wait for 1000000 * TbPeriod;
	reset_n <= '1'; wait for 70 ms;
	
	-- test when S = 11, should see hex value of moving average at output in volts
	SW(9 downto 8) <= "11"; wait for 1000000 * TbPeriod;		
	
	TbSimEnded <= '1';
	assert false report "simulation ended" severity failure;
	end process;

end tb;