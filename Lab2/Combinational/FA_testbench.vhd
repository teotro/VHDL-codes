LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Testbench_full_adder IS
END Testbench_full_adder;
 
ARCHITECTURE behavior OF Testbench_full_adder IS
 
 COMPONENT FAdder is
 
 Port ( FA, FB, FC : in STD_LOGIC;
 
           FS, FCA : out STD_LOGIC);
 
 END COMPONENT;
 
 --Inputs
 signal FA : std_logic := '0';
 signal FB : std_logic := '0';
 signal FC : std_logic := '0';
 
 --Outputs
 signal FS : std_logic;
 signal FCA : std_logic;
 
BEGIN
 
 uut: FAdder PORT MAP (
 FA => FA,
 FB => FB,
 FC => FC,
 FS => FS,
 FCA => FCA
 );
 
 -- Stimulus process
 stim_proc: process
 begin

 wait for 100 ns;
 
 -- insert stimulus here
 FA <= '0';
 FB <= '0';
 FC <= '1';
 wait for 10 ns;
 
 FA <= '0';
 FB <= '1';
 FC <= '0';
 wait for 10 ns;
 
 FA <= '0';
 FB <= '1';
 FC <= '1';
 wait for 10 ns;
 
 FA <= '1';
 FB <= '0';
 FC <= '0';
 wait for 10 ns;
 
 FA <= '1';
 FB <= '0';
 FC <= '1';
 wait for 10 ns;
 
 FA <= '1';
 FB <= '1';
 FC <= '0';
 wait for 10 ns;
 
 FA <= '1';
 FB <= '1';
 FC <= '1';
 wait for 10 ns;
 
 end process;
 
END;