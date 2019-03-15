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
type ram_type is array(0 to 1999) of std_logic_vector(n-1 downto 0);
signal ram : ram_type;
begin
process(clkRam) is
begin
if rising_edge(clkRam) then
if we = '1' then
ram(to_integer(unsigned(address))) <= dataInRam;
end if;
end if;
end process;
dataOutRam <= ram(to_integer(unsigned(address)));
end ram_a;
