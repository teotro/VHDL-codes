LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FAdder_comb is

Port ( FA, FB, FC : in STD_LOGIC;

          FS, FCA : out STD_LOGIC);

end FAdder_comb;

architecture behavioral of FAdder_comb is

signal result: STD_LOGIC_VECTOR(1 downto 0);

begin
    process(FA, FB, FC)
    begin
        result <= ('0'&FA)+('0'&FB)+('0'&FC);
    end process;
    
    FS <= result(0);
    FCA <= result(1);
    
 end behavioral;