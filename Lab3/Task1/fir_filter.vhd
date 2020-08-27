library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity FIR is
generic (
		width : integer :=8;      --width of input data
		tap: integer :=3          --for 8-tap FIR => 7 adds => 2^3 adds => +3 bits
	 );
port(	clk, rst: in std_logic;
        valid_in: in std_logic;
		x: in std_logic_vector(width-1 downto 0);
		y: out std_logic_vector(width+width+tap-1 downto 0);
		valid_out: out std_logic );
end FIR;

architecture structural of FIR is

component controller
generic(addr_width: integer);
port(	clk, rst: in std_logic;
        valid_in: in std_logic;
	mac_init: out std_logic;
	we: out std_logic;
	en: out std_logic;
	rom_addres, ram_addres: out std_logic_vector(addr_width-1 downto 0);
	valid_out: out std_logic );
end component;

component mlab_ram
	 generic (
		data_width : integer  				--- width of data (bits)
	 );
    port (clk, rst  : in std_logic;
          we   : in std_logic;						--- memory write enable
		  en   : in std_logic;				--- operation enable
          addr : in std_logic_vector(2 downto 0);			-- memory address
          di   : in std_logic_vector(data_width-1 downto 0);		-- input data
          do   : out std_logic_vector(data_width-1 downto 0));		-- output data
end component;

component mlab_rom
	 generic (
		coeff_width : integer  				--- width of coefficients (bits)
	 );
    Port ( clk : in  STD_LOGIC;
	   		en : in  STD_LOGIC;				--- operation enable
           addr : in  STD_LOGIC_VECTOR (2 downto 0);			-- memory address
           rom_out : out  STD_LOGIC_VECTOR (coeff_width-1 downto 0));	-- output data
end component;

component MAC
generic (
		width : integer;
		tap: integer          --for 8-tap FIR => 7 adds => 2^3 adds => +3 bits
	 );
port(	clk, rst: in std_logic;
		mac_init: in std_logic;
		en: in std_logic;
		ram_out, rom_out: in std_logic_vector(width-1 downto 0);
		--valid_out: out std_logic;
		y: out std_logic_vector(width+width+tap-1 downto 0));
end component;


signal en, we, mac_init: std_logic;
--signal clk, rst: std_logic;
signal rom_addr, ram_addr: std_logic_vector(2 downto 0);
signal rom_out, ram_out: std_logic_vector(width-1 downto 0);

begin

cont: controller generic map (tap) port map (clk => clk, rst => rst, valid_in => valid_in, we => we, en => en, mac_init => mac_init, rom_addres => rom_addr, ram_addres => ram_addr, valid_out => valid_out);

rom: mlab_rom generic map (width) port map (clk => clk, en => en, addr => rom_addr, rom_out => rom_out);

ram: mlab_ram generic map (width) port map (clk => clk, rst => rst, en => en, we => we, addr => ram_addr, di => x, do => ram_out);

macc: MAC generic map (width, tap) port map (clk => clk, rst => rst, mac_init => mac_init, en => en, ram_out => ram_out, rom_out => rom_out, y => y);

end structural;

