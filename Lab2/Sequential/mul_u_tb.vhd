library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb_mul_u_cp is
end tb_mul_u_cp;

architecture tb_arch of tb_mul_u_cp is
	component mul_u_cp
		port
    (
        a : in  std_logic_vector(3 downto 0);
        b : in  std_logic_vector(3 downto 0);
        p : out std_logic_vector(7 downto 0);
        clk, rst: in std_logic
    );
end component;

	signal a : std_logic_vector(3 downto 0);
	signal b : std_logic_vector(3 downto 0);
	signal p : std_logic_vector(7 downto 0);
	signal rst: std_logic:='0';
	signal clk: std_logic;
	
begin
uut: mul_u_cp port map(a=>a, b=>b, p=>p, clk=>clk, rst=>rst);
--Clock generator
     clk_generator: PROCESS
     BEGIN
       clk <= '0';
       WAIT FOR 7ns;
       clk <= '1';
       WAIT FOR 7ns;
     END PROCESS;
 
 a <= "0101", "1100" after 50 ns;
 b <= "0010", "1001" after 50 ns;
 
 end tb_arch;
