library IEEE;
use ieee.std_logic_1164.all;        
use ieee.std_logic_unsigned.all;

entity addCounter is
generic (n: integer := 16); 
port(clk, clr, enAC : in  std_logic;
result : out std_logic_vector(n-1 downto 0));
end addCounter;

architecture arch_ac of addCounter is

component ramCounter is 
port(clk, clr, enRC : in  std_logic;
result : out std_logic_vector(2 downto 0));
end component;  

signal temp: std_logic_vector(n-1 downto 0) := (Others=>'0');
signal tmp: std_logic_vector(2 downto 0) := "000";

begin

Delay : ramCounter port map(clk,clr,enAC,tmp);

process (clk, clr ,enAC, tmp) 
begin
if (enAC = '1') then   
if (clr='1') then   
temp <= (Others=>'0');  
elsif (clk'event and clk='1' and tmp = "010") then 
temp <= temp + 1;
end if;
else 
temp <= temp;
end if;  
end process;
result <= temp;

end arch_ac;
	
