library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ram is
generic (n : integer := 16);
port(clkRam : in std_logic;
we : in std_logic;
address : in std_logic_vector(10 downto 0);
dataInRam : in std_logic_vector(n-1 downto 0);
dataOutRam : out std_logic_vector(n-1 downto 0)
);
end entity ram;

architecture ram_a of ram is

component ramCounter is 
port(clk, clr, enRC : in  std_logic;
result : out std_logic_vector(2 downto 0));
end component;

type ram_type is array(0 to 1999) of std_logic_vector(n-1 downto 0);
signal ram : ram_type;
signal tmp : std_logic_vector(2 downto 0) := "000";

begin
Delay : ramCounter port map(clkRam,'0','1',tmp);
process(clkRam,tmp) is
begin
if (clkRam'event and clkRam = '1') then
if we = '1' then
ram(to_integer(unsigned(address))) <= dataInRam;
end if;
end if;
if(tmp = "010" and clkRam'event and clkRam = '0' ) then
dataOutRam <= ram(to_integer(unsigned(address)));
end if;
end process;

end ram_a;
