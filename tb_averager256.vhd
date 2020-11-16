library IEEE;
use IEEE.std_logic_1164.all;

entity tb_averager256 is
end tb_averager256;

architecture tb of tb_averager256 is

component averager256
   generic ( N    : INTEGER := 8; -- 8; -- log2(number of samples to average over), e.g. N=8 is 2**8 = 256 samples 
			X    : INTEGER := 4; -- X = log4(2**N), e.g. log4(2**8) = log4(4**4) = log4(256) = 4 (bit of resolution gained)
			bits : INTEGER := 11 -- number of bits in the input data to be averaged
		   );    
   port ( clk     : in  std_logic;
		  EN      : in  std_logic; -- takes a new sample when high for each clock cycle
          reset_n : in  std_logic; -- active-low
          Din     : in  std_logic_vector(bits downto 0); -- input sample for moving average calculation
          Q       : out std_logic_vector(bits downto 0)  -- 12-bit moving average of 256 samples
        -- Q_high_res :  out std_logic_vector(X+bits downto 0) -- (4+11 downto 0) -- first add (i.e. X) must match X constant in ADC_Data  
        ); 
end component;

signal clk, EN, TbSimEnded : std_logic := '0';
signal reset_n : std_logic := '1';
signal Din, Q : std_logic_vector(11 downto 0);

constant TbPeriod : time := 20 ns;

begin

	dut : averager256
		generic map ( N => 4,
					  X => 2
					)
		port map ( clk => clk,
				   EN => EN,
				   reset_n => reset_n,
				   Din => Din,
				   Q => Q
				 );
				 
	clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';

	simulation : process
	begin

		reset_n <= '0'; wait for 5 * TbPeriod;
		reset_n <= '1'; --wait for 100 * TbPeriod;
		EN <= '1'; -- note that EN will not always be 1 but for the sake of the simulation and unit testing, it is here
		
		
		for i in 1 to 2**4 loop -- after this loop, Q should be 2 (since all 16 samples are 2)
			wait until rising_edge(clk);
				Din <= x"002"; wait for TbPeriod;
				report "here";
		end loop;
		
		for i in 1 to (2**4)/2 loop -- after this loop, Q should be (2*8 + 4*8) / 16
			wait until rising_edge(clk);
				Din <= x"004"; wait for TbPeriod;
				report "here";
		end loop;
		
		for i in 1 to (2**4)/2 loop -- after this loop, Q should be (6*8 + 4*8) / 16
			wait until rising_edge(clk);
				Din <= x"006"; wait for TbPeriod;
				report "here";
		end loop;
		
		TbSimEnded <= '1';
		wait;
	end process;

end tb;