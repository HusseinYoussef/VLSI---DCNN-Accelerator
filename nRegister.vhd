library IEEE;
use IEEE.std_logic_1164.all;

entity nRegister is
generic (n: integer := 16);
port(inputR : in std_logic_vector(n-1 downto 0);
outputR : out std_logic_vector(n-1 downto 0);
enR,clk,rstR : in std_logic
);
end nRegister;

architecture a_nRegister of nRegister is
begin
process (clk) 
begin
if((clk'event and clk = '1')) then
if(rstR = '1') then
outputR <= (others => '0');
elsif(enR = '1') then
outputR <= inputR;
end if;
end if;
end process;
end a_nRegister;
