library IEEE;
use ieee.std_logic_1164.all;        
use ieee.std_logic_unsigned.all;

entity ramCounter is 
port(clk, clr, enRC : in  std_logic;
result : out std_logic_vector(2 downto 0));
end ramCounter;

architecture arch_rc of ramCounter is  

signal tmp: std_logic_vector(2 downto 0) := "000";

begin
process (clk, clr ,enRC) 
begin
if (enRC = '1') then   
if (clr='1') then   
tmp <= "000";  
elsif (clk'event and clk='1') then 
tmp <= tmp + 1;
end if;
if (clk'event and clk ='1' and tmp ="010") then
tmp <= "000";
end if;
else 
tmp <= tmp;
end if;  
end process;
result <= tmp;

end arch_rc;
	
