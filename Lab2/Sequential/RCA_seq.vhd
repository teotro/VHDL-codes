LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FA4bit_seq is
Port (clk, rst: in STD_LOGIC;
		FA, FB: in STD_LOGIC_VECTOR(3 downto 0);
		FC: in STD_LOGIC;
		FS: out STD_LOGIC_VECTOR(3 downto 0);
		FCA: out STD_LOGIC);
end FA4bit_seq;

architecture structural of FA4bit_seq is

component FAdder_seq is
Port(clk, rst: in STD_LOGIC;
	FA, FB, FC: in STD_LOGIC;
	FS, FCA: out STD_LOGIC);
end component;

SIGNAL a1,b1, a20,b20, a21, b21, a30, b30, a31, b31, a32, b32: STD_LOGIC;
SIGNAL C1, C2, C3: STD_LOGIC;
SIGNAL s01, s02, s03, s12, s13, s23: STD_LOGIC;

begin

	process(clk)
	begin
	if(rising_edge(clk)) then
	   if(rst='0') then
            a1 <= FA(1);
            b1 <= FB(1);
            
            a20 <= FA(2);
            b20 <= FB(2);
            
            a30 <= FA(3);
            b30 <= FB(3);

	   elsif(rst='1') then
            a1 <= '0';
            b1 <= '0';
            
            a20 <= '0';
            b20 <= '0';
            
            a30 <= '0';
            b30 <= '0';
       end if;  
	end if;
	end process;
	
	U1: FAdder_seq port map(clk=>clk, rst=> rst, FA=>FA(0), FB=>FB(0), FC=>FC, FS=>s01, FCA=>C1);
	
	process(clk)
	begin
	if(rising_edge(clk)) then
	   if(rst='0') then
            s02 <= s01;
            
            a21 <= a20;
            b21 <= b20;
            
            a31 <= a30;
            b31 <= b30;

	   elsif(rst='1') then
            s02 <= '0';
            
            a21 <= '0';
            b21 <= '0';
            
            a31 <= '0';
            b31 <= '0';
       end if;
	end if;
	end process;
		
	U2: FAdder_seq port map(clk=>clk, rst=> rst, FA=>a1, FB=>b1, FC=>C1, FS=>s12, FCA=>C2);
	
	process (clk)
	begin
	if(rising_edge(clk)) then
		
		if (rst='1') then
		  s03 <= '0';
          s13 <= '0';
          
		  a32 <= '0';
		  b32 <= '0';
		elsif(rst='0') then
		  s03 <= s02;
          s13 <= s12;
          
		  a32 <= a31;
		  b32 <= b31;
		end if;
	end if;
	end process;
	
	U3: FAdder_seq port map(clk=>clk, rst=> rst, FA=>a21, FB=>b21, FC=>C2, FS=>s23, FCA=>C3);
	
	process (clk)
	begin
	if(rising_edge(clk)) then
	   if(rst='1') then
	       FS(0) <= '0';
           FS(1) <= '0';
           FS(2) <= '0';

           
        elsif(rst='0') then
            FS(0) <= s03;
            FS(1) <= s13;
            FS(2) <= s23;
        end if;
	end if;
	end process;
	
	U4: FAdder_seq port map(clk=>clk, rst=> rst, FA=>a32, FB=>b32, FC=>C3, FS=>FS(3), FCA=>FCA);
	
end structural;
