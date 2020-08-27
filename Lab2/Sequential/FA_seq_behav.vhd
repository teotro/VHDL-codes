library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity FAdder_seq is
Port ( clk, rst: in STD_LOGIC;
       FA, FB, FC : in STD_LOGIC;
       FS, FCA : out STD_LOGIC);
end FAdder_seq;



architecture behavioral of FAdder_seq is

signal result: STD_LOGIC_VECTOR(1 downto 0);
signal a,b,ci: STD_LOGIC;

begin

    U1: process(clk)
    begin
    if(clk'event and clk='1') then
        a<=FA;
        b<=FB;
        ci<=FC;
    end if;
    end process;
    result <= ('0'&a)+('0'&b)+('0'&ci);
    U2: process(clk)
    begin
    if(clk'event and clk='1') then
        if(rst='1') then 
            FS <= '0';
            FCA <= '0';
         elsif(rst='0') then
            FS <= result(0);
            FCA <= result(1);
         end if;
     end if;
    end process;
    
 end behavioral;
