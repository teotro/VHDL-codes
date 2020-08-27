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
component two_parallel_fir is
generic(
    N: integer :=8;
    M: integer :=8;
    tap: integer :=3);
port(
    valid_in: in std_logic;
    x0, x1: in std_logic_vector(N-1 downto 0);
    clk, rst: in std_logic;
    y0,y1: out std_logic_vector(N+N+tap-1 downto 0);
    valid_out: out std_logic);
end component;

signal clk, valid_out, valid_in: std_logic;
signal rst: std_logic :='0';
signal x0, x1: std_logic_vector(N-1 downto 0);
signal y0, y1: std_logic_vector(N+N+tap-1 downto 0);

begin
filter: two_parallel_fir port map(clk => clk, rst => rst, valid_in => valid_in, x0 => x0, x1 => x1, y0 => y0, y1 => y1, valid_out => valid_out);

--Clock generator
     clk_generator: PROCESS
     BEGIN
       clk <= '0';
       WAIT FOR 5ns;
       clk <= '1';
       WAIT FOR 5ns;
     END PROCESS;
  
rst <= '0', '0' after 10ns, '1' after 300ns, '0' after 350ns;  
valid_in <= '1','0' after 100 ns, '1' after 150ns;
x0 <= b"0000_0011", b"0010_0000" after 10ns, b"0000_0100" after 20ns;
x1 <= b"0000_0011", b"0010_0000" after 10ns, b"0000_0100" after 20ns;

end behavioral;