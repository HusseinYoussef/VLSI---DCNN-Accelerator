library IEEE;
use ieee.std_logic_1164.all;        
use ieee.std_logic_unsigned.all;

entity tenClkCounter is 
generic (n: integer := 16);
port(Clock, Clear, enTC : in  std_logic;
Output1 : out std_logic_vector(n-1 downto 0);
Output2 : out std_logic_vector(3 downto 0));
end tenClkCounter;

architecture arch_tc of tenClkCounter is  

component counter is 
port(clk, clr, enC : in  std_logic;
result : out std_logic_vector(3 downto 0));
end component;

component ramCounter is 
port(clk, clr, enRC : in  std_logic;
result : out std_logic_vector(2 downto 0));
end component;

signal tmp: std_logic_vector(3 downto 0) := "0000";
signal tmp2: std_logic_vector(2 downto 0) := "000";
signal temp : std_logic_vector(n-1 downto 0) := (Others=>'0');
begin

count : counter port map(Clock,Clear,enTC,tmp);
Delay : ramCounter port map(Clock,Clear,enTC,tmp2);

process (Clock, Clear, enTC,tmp2) 
begin
if(enTC = '1') then   
if (Clear='1') then   
temp <= (others => '0');  
elsif (Clock'event and Clock='1' and tmp = "1001" and tmp2 = "010") then 
temp <= temp + 1;
end if;
else
temp <= temp;
end if;
end process;
output1 <= temp;
output2 <= tmp;
end arch_tc;
	
