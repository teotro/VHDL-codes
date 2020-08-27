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
component two_par_fir_component is
generic(
    N: integer :=8;
    M: integer :=8;
    tap: integer :=3);
port(
    x0, x1: in std_logic_vector(N-1 downto 0);
    clk, rst: in std_logic;
    y: out std_logic_vector(N+N+tap-1 downto 0));
end component;

signal clk, valid_out: std_logic;
signal rst: std_logic :='0';
signal x0, x1: std_logic_vector(N-1 downto 0);
signal y: std_logic_vector(N+N+tap-1 downto 0);

begin
filter: two_par_fir_component port map(clk => clk, rst => rst, x0 => x0, x1 => x1, y => y);

--Clock generator
     clk_generator: PROCESS
     BEGIN
       clk <= '0';
       WAIT FOR 5ns;
       clk <= '1';
       WAIT FOR 5ns;
     END PROCESS;
     
x0 <= b"0000_0011", b"0010_0000" after 10ns, b"0000_0100" after 20ns;
x1 <= b"0000_0011", b"0010_0000" after 10ns, b"0000_0100" after 20ns;

end behavioral;