library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity fir_filter_tb is
generic (
		N : integer :=8;
		M : integer :=8;
		tap: integer :=3
	 );
end fir_filter_tb;

architecture behavioral of fir_filter_tb is

component pip_fir is
generic (
		N : integer :=8;
		M : integer :=8;
		tap: integer :=3
	 );
port(
         x: in std_logic_vector(N-1 downto 0);
         valid_in: in std_logic;
         clk, rst: in std_logic;
         y: out std_logic_vector(N+N+tap-1 downto 0);
         valid_out: out std_logic);
end component;

signal clk, valid_out: std_logic;
signal rst: std_logic :='0';
signal valid_in: std_logic;
signal x: std_logic_vector(N-1 downto 0);
signal y: std_logic_vector(N+N+tap-1 downto 0);
--signal counter:  std_logic_vector(2 downto 0);

begin

filter: pip_fir port map(clk => clk, rst => rst, valid_in => valid_in, x => x, y => y, valid_out => valid_out);

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
	 
x <= b"0010_1000", b"1111_1000" after 10ns, b"1111_0101" after 20ns, b"0111_1100" after 30ns, b"1100_1100" after 40ns, b"0010_0100" after 50ns, b"0110_1011" after 60ns, b"1110_1010" after 70ns, b"1100_1010" after 80ns, b"1111_0101" after 90ns, b"0000_0000" after 100ns, b"0000_0000" after 110ns, b"0000_0000" after 120ns, b"0000_0000" after 130ns, b"0000_0000" after 140ns, b"0000_0000" after 150ns, b"0000_0000" after 160ns, b"0000_0000" after 170ns, b"0000_0000" after 180ns, b"0000_0000" after 190ns, b"0000_0000' after 200ns,      b"0000_0000" after 210ns, b"0000_0000" after 220ns, b"0000_0000" after 230ns, b"0000_0000" after 240 ns  ;

end behavioral;

	 
