library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity two_parallel_fir is
generic(
    N: integer :=8;
    M: integer :=8;
    tap: integer :=3);
port(
    valid_in: in std_logic;
    x0, x1: in std_logic_vector(N-1 downto 0);
    clk, rst: in std_logic;
    y0, y1: out std_logic_vector(N+N+tap-1 downto 0);
    valid_out: out std_logic);
end two_parallel_fir;

architecture behavioral of two_parallel_fir is

component two_par_fir_component is
generic(
    N: integer :=8;
    M: integer :=8;
    tap: integer :=3);
port(
    valid_in: in std_logic;
    x0, x1: in std_logic_vector(N-1 downto 0);
    clk, rst: in std_logic;
    y: out std_logic_vector(N+N+tap-1 downto 0));
end component;

signal x_buff: std_logic_vector(N-1 downto 0) := (others => '0');
signal val_out: std_logic_vector(5 downto 0) := (others => '0');

begin

fir_2k_1:   two_par_fir_component port map(clk=>clk, rst=>rst, valid_in=>valid_in, x0=>x0, x1=>x1, y=>y1);
fir_2k:     two_par_fir_component port map(clk=>clk, rst=>rst, valid_in=>valid_in, x0=>x_buff, x1=>x0, y=>y0);

process(clk, rst)
    begin
    if(rst='1') then
        x_buff <= (others => '0');
        --valid_out <= '0';
        val_out <= (others => '0');
    elsif(rst='0') then
        if(clk'event and clk='1') then
            x_buff <= x1;
            val_out(0) <= valid_in;
            for i in 1 to 5 loop
                val_out(i) <= val_out(i-1);
            end loop;
            
        end if;
    end if;
end process;
valid_out <= val_out(5);
end behavioral;

