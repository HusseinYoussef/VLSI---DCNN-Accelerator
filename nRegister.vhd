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
outputR <= (others => '0') when rstR = '1'
else inputR when enR = '1' and rising_edge(clk);

end a_nRegister;
