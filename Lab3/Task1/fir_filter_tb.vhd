library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity fir_filter_tb is
generic (
		width : integer :=8;
		tap: integer :=3
	 );
end fir_filter_tb;

architecture behavioral of fir_filter_tb is

component FIR is
generic (
		width : integer :=8;
		tap: integer :=3
	 );
port(	clk, rst: in std_logic;
        valid_in: in std_logic;
		x: in std_logic_vector(width-1 downto 0);
		y: out std_logic_vector(width+width+tap-1 downto 0);
		valid_out: out std_logic );
end component;

signal clk, valid_out: std_logic;
signal rst: std_logic :='0';
signal valid_in: std_logic;
signal x: std_logic_vector(width-1 downto 0);
signal y: std_logic_vector(width+width+tap-1 downto 0);
--signal counter:  std_logic_vector(2 downto 0);

begin

filter: FIR port map(clk => clk, rst => rst, valid_in => valid_in, x => x, y => y, valid_out => valid_out);

rst <= '0', '0' after 10ns, '1' after 400ns, '0' after 450ns;
valid_in <= '1', '0' after 190 ns, '1' after 350ns;
--Clock generator
     clk_generator: PROCESS
     BEGIN
       clk <= '0';
       WAIT FOR 5ns;
       clk <= '1';
       WAIT FOR 5ns;
     END PROCESS;
	 
x <= b"0000_0011", b"0010_0000" after 75ns, b"0000_0100" after 150ns;

end behavioral;

	 
