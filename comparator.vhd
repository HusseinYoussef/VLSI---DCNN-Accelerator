library IEEE;
use IEEE.std_logic_1164.all;

entity comparator is
generic ( n : integer := 5);
port( R0 : in std_logic_vector(n-1 downto 0);
R1 : in std_logic_vector(n-1 downto 0);
result : out std_logic
);
end comparator;

architecture compare_a of comparator is
component twoComp is
generic (n : integer := 5);
port (input : in std_logic_vector(n-1 downto 0);
output : out std_logic_vector(n-1 downto 0)
);
end component;

component my_nadder is
      generic (n : integer := 8);
port(a,b : in std_logic_vector(n-1 downto 0);
cin: in std_logic;
s : out std_logic_vector(n-1 downto 0);
cout : out std_logic
);
end component;

signal reg : std_logic_vector (n-1 downto 0);
signal temp : std_logic_vector (n-1 downto 0);
signal carry : std_logic;

begin
TC : twoComp generic map(5) port map(R1,reg);
FA : my_nadder generic map(5) port map(R0,reg,'0',temp,carry);

result <= '1' when (R0(n-1) = '0') and (R1(n-1) = '1')
else  '0' when (R0(n-1) = '1') and (R1(n-1) = '0')
else carry;


end compare_a;