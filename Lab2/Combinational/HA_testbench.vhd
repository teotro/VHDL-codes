library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY half_adder_tb IS
END half_adder_tb;
ARCHITECTURE half_adder_tb OF half_adder_tb IS 
    COMPONENT HA
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         s : OUT  std_logic;
         c : OUT  std_logic
        );
    END COMPONENT;
    
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal s : std_logic;
   signal c : std_logic;
  
BEGIN
  uut: HA PORT MAP (
          a => a,
          b => b,
          s => s,
          c => c
        );

   stim_proc: process
   begin  
 
 a <= '0';
 b <= '0';
      wait for 50 ns; 

 a <= '0';
 b <= '1';
      wait for 50 ns; 

 a <= '1';
 b <= '0';
      wait for 50 ns; 

 a <= '1';
 b <= '1';
      wait;
  
 end process;

END;