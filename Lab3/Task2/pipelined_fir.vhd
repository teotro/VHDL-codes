library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity pip_fir is
generic(
    N: integer :=8;
    M: integer :=8;
    tap: integer :=3);
port(
    x: in std_logic_vector(N-1 downto 0);
    valid_in: in std_logic;
    clk, rst: in std_logic;
    y: out std_logic_vector(N+N+tap-1 downto 0);
    valid_out: out std_logic);
end pip_fir;

architecture behavioral of pip_fir is

    type rom_type is array (M-1 downto 0) of std_logic_vector (N-1 downto 0);                 
    signal rom : rom_type:= ("00001000", "00000111", "00000110", "00000101", "00000100", "00000011", "00000010",
                             "00000001");
                             
    type ram_type is array (2*M-2 downto 0) of std_logic_vector(N-1 downto 0);
    signal ram : ram_type := (others => (others => '0'));
    
    type k_type is array (M-1 downto 0) of std_logic_vector(2*N-1 downto 0);
    signal k: k_type := (others => (others => '0'));
    
    type z_type is array(M-1 downto 0) of std_logic_vector(2*N+tap-1 downto 0);
    signal z: z_type := (others => (others => '0'));
    
    signal val_out1, val_out0: std_logic_vector(M downto 0) := (others => '0');
    signal counter: std_logic_vector(tap-1 downto 0) := (others => '1');
    
    constant all_zeros: std_logic_vector(tap-1 downto 0) := (others =>'0');
    
    begin
    
    process(clk, rst) 
    begin
    
    if(rst='1') then
        ram <= (others => (others => '0'));
        z <= (others => (others => '0'));
        k <= (others => (others => '0'));
        y <= (others => '0');
        valid_out <= '0';
        val_out1 <= (others => '0');
        val_out0 <= (others => '0');
        
    elsif(rst='0') then
        if(clk'event and clk='1') then
        
            if(valid_in='1') then
            
            
                val_out0(0) <= valid_in;
                for i in 1 to M loop
                    val_out0(i) <= val_out0(i-1);
                end loop;
                
                
                val_out1(0) <= valid_in;
                for i in 1 to M loop
                    val_out1(i) <= val_out1(i-1);
                end loop;
                valid_out <= val_out1(M);
                
                ram(0) <= x;
                for i in 1 to 2*M-2 loop
                    ram(i) <= ram(i-1);
                end loop;
                k(0) <= rom(0)*x;
                for i in 1 to M-1 loop
                    k(i) <= rom(i)*ram(2*i-1);
                end loop;
                z(0) <= all_zeros & k(0);
                for i in 1 to M-1 loop
                   z(i) <= z(i-1)+(all_zeros & k(i));
                end loop;
                y <= z(M-1);
                
            elsif(valid_in='0') then
            val_out0(0) <= valid_in;
             for i in 1 to M loop
                 val_out0(i) <= val_out0(i-1);
             end loop;
             valid_out <= val_out0(M);
             
            end if;
            
        end if;
        
    end if;
    
    end process;
    
    end behavioral;