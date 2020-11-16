library IEEE;
use IEEE.std_logic_1164.all;

entity tb_blank_edit is
end tb_blank_edit;

architecture tb of tb_blank_edit is

component blank_edit
	port ( blank_in             : in  std_logic_vector(5 downto 0);
		   value_in             : in  std_logic_vector(15 downto 0);
		   s                    : in  std_logic_vector(1 downto 0);
		   reset_n              : in std_logic; 
		   blank_out            : out std_logic_vector(5 downto 0)
		  );
end component;

signal blank_in : std_logic_vector(5 downto 0);
signal value_in : std_logic_vector(15 downto 0);
signal s : std_logic_vector(1 downto 0);
signal reset_n : std_logic;
signal blank_out: std_logic_vector(5 downto 0);
constant wait_time : time := 500 ns;

begin

	dut : blank_edit
		port map (  blank_in => blank_in,
					value_in => value_in,
					s => s,
					reset_n => reset_n,
					blank_out => blank_out);

	stimulus : process
	begin
		blank_in <= "110000"; -- set to a 6- bit value for entire operation due to design choices
		wait for wait_time;
		
		reset_n <= '0'; wait for wait_time; -- note reset here is not being used to reset sequential logic, but rather as an indicator that if we're trying to reset, display 4 zeros
		reset_n <= '1';
		
		s <= "00"; value_in <= x"0FA5"; wait for wait_time; -- hex output for SW[7:0]
				   value_in <= x"A387"; wait for wait_time;
				   value_in <= x"0080"; wait for wait_time;
				   
		s <= "01"; value_in <= "0000"&"0100"&"1001"&"0101"; wait for wait_time; -- since distance is only valid for {4:30] cm so smallest value in is 400, largest is 3000
				   value_in <= "0101"&"0011"&"0000"&"0111"; wait for wait_time; 
				  
		s <= "10"; value_in <= "0000"&"0000"&"0000"&"0101"; wait for wait_time; -- voltage will be in range [0:5] V, smallest number in is 1, largest out is 5000
				   value_in <= "0000"&"0000"&"0110"&"0111"; wait for wait_time; 
				   value_in <= "0000"&"0010"&"0110"&"0111"; wait for wait_time;
				   value_in <= "0101"&"0011"&"0000"&"0111"; wait for wait_time; 
		
		s <= "11"; value_in <= x"0F84"; wait for wait_time; -- ADC 12-bit moving average in hex, smallest is 0 and largest it can be is 4095 (in decimal)
				   value_in <= x"0011"; wait for wait_time; 
				   value_in <= x"000A"; wait for wait_time; 
	
	wait;
	end process;

end tb;
