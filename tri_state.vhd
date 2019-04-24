library IEEE;
use IEEE.std_logic_1164.all;

entity tri_state is
	generic (n: integer := 32); 
port( inputTS : in std_logic_vector(n-1 downto 0);
outputTS : out std_logic_vector(n-1 downto 0);
enTS : in std_logic
);
end tri_state;

architecture a_tri_state of tri_state is

signal temp : std_logic_vector(n-1 downto 0);

begin
temp <= inputTS when enTS = '1'
else temp;
outputTS <= temp;

end a_tri_state;
