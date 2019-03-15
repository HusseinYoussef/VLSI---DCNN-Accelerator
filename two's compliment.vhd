library IEEE;
use IEEE.std_logic_1164.all;

entity twoComp is
generic (n : integer := 5);
port (input : in std_logic_vector(n-1 downto 0);
output : out std_logic_vector(n-1 downto 0)
);
end twoComp;

architecture Comp_a of twoComp is
component my_nadder is
      generic (n : integer := 8);
port(a,b : in std_logic_vector(n-1 downto 0);
cin: in std_logic;
s : out std_logic_vector(n-1 downto 0);
cout : out std_logic
);
end component;
signal temp1 : std_logic_vector(n-1 downto 0);
signal temp2 : std_logic_vector(n-1 downto 0);
signal c : std_logic;
begin
temp1 <= (not input);
temp2 <= (others=>'0');
adder : my_nadder generic map(5) port map (temp1,temp2,'1',output,c); 

end Comp_a;
