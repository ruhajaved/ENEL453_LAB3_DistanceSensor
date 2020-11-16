library IEEE;
use IEEE.std_logic_1164.all;

entity tb_DFF_EN is
end tb_DFF_EN;

architecture tb of tb_DFF_EN is

component DFF_EN is
port ( D           : in std_logic_vector (15 downto 0);
	  RST, EN, clk : in std_logic; -- note, this is an active high enable
	  Q			   : out std_logic_vector (15 downto 0)
	 );
end component;  

       
signal D : std_logic_vector (15 downto 0);
signal Q : std_logic_vector (15 downto 0);
signal clk : std_logic := '0';
signal EN : std_logic := '1';
signal RST : std_logic := '1';

constant TbPeriod : time := 20 ns;
signal TbSimEnded : std_logic := '0'; 

begin

	 clk <= not clk after TbPeriod/2 when TbSimEnded /= '1' else '0';
	
	dut: DFF_EN 
	port map ( D     => D,
			   RST   => RST,
			   EN    => EN,
			   CLK   => CLK,
			   Q     => Q 
			  );
	
	stimulus : process
	begin
	
	-- simulate when EN = 1, RST = 0
	RST <= '0'; wait for 100 * TbPeriod;
	RST <= '1';
	
	-- simulate when EN = 1, RST = 1
	D <= x"01A7"; wait for 100 * TbPeriod;
	D <= x"9710"; wait for 100 * TbPeriod;
	
	-- simulate when EN = 0, RST = 1
	EN <= '0';
	D <= x"02A4"; wait for 100 * TbPeriod;
	D <= x"0010"; wait for 100 * TbPeriod;
	
	-- simulate when EN = 0, RST = 0
	EN <= '0'; 
	RST <= '0';
	D <= x"02A4"; wait for 100 * TbPeriod;
	D <= x"0010"; wait for 100 * TbPeriod;
	
	tbSimEnded <='1';
	wait;
	end process;

end tb;