library IEEE;
use ieee.std_logic_1164.all;        
use ieee.std_logic_unsigned.all;

entity counter is 
port(clk, clr, enC : in  std_logic;
result : out std_logic_vector(3 downto 0));
end counter;

architecture arch_c of counter is

component ramCounter is 
port(clk, clr, enRC : in  std_logic;
result : out std_logic_vector(2 downto 0));
end component;  

signal tmp: std_logic_vector(3 downto 0) := "0000";
signal temp: std_logic_vector(2 downto 0) := "000";

begin

Delay : ramCounter port map(clk,clr,enC,temp); 

process (clk, clr ,enC, temp) 
begin
if (enC = '1') then   
if (clr='1') then   
tmp <= "0000";  
elsif (clk'event and clk='1') then 
if(temp = "010") then
tmp <= tmp + 1;
end if;
if (tmp ="1001" and temp = "010") then
tmp <= "0000";
end if;
end if;
else 
tmp <= tmp;
end if;  
end process;
result <= tmp;

end arch_c;
	
