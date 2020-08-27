library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity two_par_fir_component is
generic(
    N: integer :=8;
    M: integer :=8;
    tap: integer :=3);
port(
    valid_in: in std_logic;
    x0, x1: in std_logic_vector(N-1 downto 0);
    clk, rst: in std_logic;
    y: out std_logic_vector(N+N+tap-1 downto 0));
end two_par_fir_component;

architecture behavioral of two_par_fir_component is

    type rom_type is array (M-1 downto 0) of std_logic_vector (N-1 downto 0);                 
    signal rom : rom_type:= ("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", "00000010",
                             "00000001");
                             
    type ram_type is array (M-2-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal ram : ram_type := (others => (others => '0'));  
    
    type k_type is array (M-1 downto 0) of std_logic_vector(2*N-1 downto 0);
    signal k: k_type := (others => (others => '0'));
    
    type z_type is array(tap downto 0) of std_logic_vector(2*N+tap-1 downto 0);
    signal z: z_type := (others => (others => '0'));
    
    --type lag_type is array(tap downto 0) of std_logic_vector(2*N+tap-1 downto 0);
    --signal lag: lag_type := (others => (others => '0'));  
    
    signal buff1,buff2,buff3,buff4,buff5,buff6: std_logic_vector(2*N+tap-1 downto 0) := (others => '0');
    constant all_zeros: std_logic_vector(tap-1 downto 0) := (others =>'0');

begin

    process(clk, rst) 
    begin
    
    if(rst='1') then
        ram <= (others => (others => '0'));
        z <= (others => (others => '0'));
        k <= (others => (others => '0'));
        y <= (others => '0');
        
    elsif(rst='0') then
        if(clk'event and clk='1') then
            if(valid_in='1') then
                ram(0) <= x1;
                ram(1) <= x0;
                for i in 2 to M-2-1 loop
                    ram(i) <= ram(i-2);
                end loop;
                
                k(0) <= rom(0)*x1;
                k(1) <= rom(1)*x0;
                for i in 2 to M-1 loop
                    k(i) <= rom(i)*ram(i-2);
                end loop;
                
                z(0) <= (all_zeros & k(0)) + (all_zeros & k(1));
                --z(1) <= z(0);
                buff1 <= (all_zeros & k(2)) + (all_zeros & k(3)); 
                z(1) <= buff1 + z(0);
                --z(3) <= z(2); 
                
                buff2 <= (all_zeros & k(4)) + (all_zeros & k(5));
                buff3 <= buff2;
                z(2) <= buff3 + z(1);
                --z(5) <= z(4); 
                
                buff4 <= (all_zeros & k(6)) + (all_zeros & k(7));
                buff5 <= buff4;
                buff6<= buff5;
                z(3) <= buff6 + z(2);
                              
--                for i in 1 to M-1 loop
--                    z(i) <= z(i-1)+(all_zeros & k(i));
--                    z(i) <= 
--                end loop;
                
                y <= z(3);
            end if;
        end if;
    end if;
    
    end process;
    
end behavioral;
