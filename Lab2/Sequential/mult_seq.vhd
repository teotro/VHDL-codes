--
-- Carry Propagate Unsigned Multiplier
--
-- p <= a * b;
--
library IEEE;
use IEEE.std_logic_1164.all;

entity mul_u_cp is
	generic
	(
		NA : positive := 4;
		NB : positive := 4
	);
	port
	(
		clk, rst: in std_logic;
		a : in  std_logic_vector(NA-1 downto 0);
		b : in  std_logic_vector(NB-1 downto 0);
		p : out std_logic_vector(NA+NB-1 downto 0)
	);
end mul_u_cp;

architecture structural of mul_u_cp is
	subtype a_word is std_logic_vector(NA-1 downto 0);
	type a_word_array is array(natural range <>) of a_word;
	signal ai,ao,bi,bo,si,so,ci,co : a_word_array(NB-1 downto 0);
	
	signal a1, p5: std_logic;
    signal a2, b1, p4: std_logic_vector(1 downto 0);
    signal a3, p3: std_logic_vector(2 downto 0);
    signal b2: std_logic_vector(3 downto 0);
    signal p2: std_logic_vector(4 downto 0);
    signal b3: std_logic_vector(5 downto 0);
    signal p0: std_logic_vector(8 downto 0);
    signal p1: std_logic_vector(6 downto 0);
    
	component mul_cell
		port
		(
			clk, rst: in std_logic;
			ai : in  std_logic;
			bi : in  std_logic;
			si : in  std_logic;
			ci : in  std_logic;
			ao : out std_logic;
			bo : out std_logic;
			so : out std_logic;
			co : out std_logic
		);
	end component;
begin

    --buffers
	process(clk)
    begin
       if(clk'event and clk='1') then
       ai(0)(0) <= a(0);
       
       a1 <= a(1);
       ai(0)(1) <= a1;
       
       a2(0) <= a(2);
       a2(1) <= a2(0);
       ai(0)(2) <= a2(1);
       
       a3(0) <= a(3);
       a3(1) <= a3(0);
       a3(2) <= a3(1);
       ai(0)(3) <= a3(2);
       end if;
    end process;    
    
    process(clk)
        begin
        if(clk'event and clk='1') then
            bi(0)(0) <= b(0);
            
           b1(0) <= b(1);
           b1(1) <= b1(0);
           bi(1)(0) <= b1(1);
           
           b2(0) <= b(2);
           b2(1) <= b2(0);
           b2(2) <= b2(1);
           b2(3) <= b2(2);
           bi(2)(0) <= b2(3);
           
           b3(0) <= b(3);
           b3(1) <= b3(0);
           b3(2) <= b3(1);
           b3(3) <= b3(2);
           b3(4) <= b3(3);
           b3(5) <= b3(4);
           bi(3)(0) <= b3(5);
         end if;  
        end process;
        
	-- cell generation
gcb:	for i in 0 to NB-1 generate
gca:		for j in 0 to NA-1 generate
gc:			mul_cell port map
			(
				clk => clk,
				rst => rst,
				ai => ai(i)(j),
				bi => bi(i)(j),
				si => si(i)(j),
				ci => ci(i)(j),
				ao => ao(i)(j),
				bo => bo(i)(j),
				so => so(i)(j),
				co => co(i)(j)
			);
		end generate;
	end generate;
	-- intermediate wires generation
	--process(clk)
	--begin
gasw:	for i in 1 to NB-1 generate
        --if(clk'event and clk='1') then
		ai(i) <= ao(i-1);
		si(i) <= co(i-1)(NA-1) & so(i-1)(NA-1 downto 1);
		--end if;
	end generate;
gbciw:	for i in 0 to NB-1 generate
gbcjw:		for j in 1 to NA-1 generate
            --if(clk'event and clk='1') then
			bi(i)(j) <= bo(i)(j-1);
			ci(i)(j) <= co(i)(j-1);
			--end if;
		end generate;
	end generate;
	
	--end process;
	-- input connections
--gai:	ai(0)(0) <= a(0);
--        ai(0)(1) <= a1;
--        ai(0)(2) <= a2(1);
--        ai(0)(3) <= a3(2);
gsi:    si(0) <= (others => '0');

--gbi:   bi(0)(0) <= b(0);
--	   bi(1)(0) <= b1(1);
--	   bi(2)(0) <= b2(3);
--	   bi(3)(0) <= b3(5);
--gbi:	for i in 0 to NB-1 generate
--		bi(i)(0) <= b(i);
--	end generate;
gci:	for i in 0 to NB-1 generate
		ci(i)(0) <= '0';
	end generate;
	-- output connections
--gpa:	p(NA+NB-1 downto NB) <= co(NB-1)(NA-1) & so(NB-1)(NA-1 downto 1);
--gpb:	for i in 0 to NB-1 generate
--		p(i) <= so(i)(0);
--	end generate;

	process(clk)
	begin
	if(clk'event and clk='1') then
	   p0(0) <= so(0)(0);
	   for i in 1 to 8 loop
	       p0(i) <= p0(i-1);
	   end loop;
	   p(0) <= p0(8);
	   
	   p1(0) <= so(1)(0);
	   for i in 1 to 6 loop
	       p1(i) <= p1(i-1);
	   end loop;
	   p(1) <= p1(6);
	   
	   p2(0) <= so(2)(0);
	   for i in 1 to 4 loop
	       p2(i) <= p2(i-1);
	   end loop;
	   p(2) <= p2(4);
	   
	   p3(0) <= so(3)(0);
	   for i in 1 to 2 loop
	       p3(i) <= p3(i-1);
	   end loop;
	   p(3) <= p3(2);
	   
	   p4(0) <= so(3)(1);
	   p4(1) <= p4(0);
	   p(4) <= p4(1);
	   
	   p5 <= so(3)(2);
	   --p5(1) <= p5(0);
	   p(5) <= p5;
	   
	   p(6) <= so(3)(3);
	   p(7) <= co(3)(3);
	 end if;  
	end process;
	
end structural;

