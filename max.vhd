library IEEE;
use IEEE.std_logic_1164.all;

entity max is
generic ( n : integer := 32);
port(reg0 : in std_logic_vector (n-1 downto 0);
reg1 : in std_logic_vector (n-1 downto 0);
reg2 : in std_logic_vector (n-1 downto 0);
reg3 : in std_logic_vector (n-1 downto 0);
reg4 : in std_logic_vector (n-1 downto 0);
reg5 : in std_logic_vector (n-1 downto 0);
reg6 : in std_logic_vector (n-1 downto 0);
reg7 : in std_logic_vector (n-1 downto 0);
reg8 : in std_logic_vector (n-1 downto 0);
reg9 : in std_logic_vector (n-1 downto 0);
index : out std_logic_vector (3 downto 0)
);
end max;

architecture max_a of max is

component comparator is
generic ( n : integer := 5);
port( R0 : in std_logic_vector(n-1 downto 0);
R1 : in std_logic_vector(n-1 downto 0);
result : out std_logic
);
end component;

signal selector1 : std_logic;
signal tempindex1 : std_logic_vector (3 downto 0);
signal tempvalue1 : std_logic_vector (n-1 downto 0);

signal selector2 : std_logic;
signal tempindex2 : std_logic_vector (3 downto 0);
signal tempvalue2 : std_logic_vector (n-1 downto 0);

signal selector3 : std_logic;
signal tempindex3 : std_logic_vector (3 downto 0);
signal tempvalue3 : std_logic_vector (n-1 downto 0);

signal selector4 : std_logic;
signal tempindex4 : std_logic_vector (3 downto 0);
signal tempvalue4 : std_logic_vector (n-1 downto 0);

signal selector5 : std_logic;
signal tempindex5 : std_logic_vector (3 downto 0);
signal tempvalue5 : std_logic_vector (n-1 downto 0);

signal selector6 : std_logic;
signal tempindex6 : std_logic_vector (3 downto 0);
signal tempvalue6 : std_logic_vector (n-1 downto 0);

signal selector7 : std_logic;
signal tempindex7 : std_logic_vector (3 downto 0);
signal tempvalue7 : std_logic_vector (n-1 downto 0);

signal selector8 : std_logic;
signal tempindex8 : std_logic_vector (3 downto 0);
signal tempvalue8 : std_logic_vector (n-1 downto 0);

signal selector9 : std_logic;
signal tempindex9 : std_logic_vector (3 downto 0);
signal tempvalue9 : std_logic_vector (n-1 downto 0);

begin


C1 : comparator generic map (n) port map (reg0,reg1,selector1);
tempindex1 <= "0000" when selector1 = '1' else "0001" when selector1 = '0';
tempvalue1 <= reg0 when selector1 = '1' else reg1 when selector1 = '0';

C2 : comparator generic map (n) port map (reg2,reg3,selector2);
tempindex2 <= "0010" when selector2 = '1' else "0011" when selector2 = '0';
tempvalue2 <= reg2 when selector2 = '1' else reg3 when selector2 = '0';

C3 : comparator generic map (n) port map (reg4,reg5,selector3);
tempindex3 <= "0100" when selector3 = '1' else "0101" when selector3 = '0';
tempvalue3 <= reg4 when selector3 = '1' else reg5 when selector3 = '0';

C4 : comparator generic map (n) port map (reg6,reg7,selector4);
tempindex4 <= "0110" when selector4 = '1' else "0111" when selector4 = '0';
tempvalue4 <= reg6 when selector4 = '1' else reg7 when selector4 = '0';

C5 : comparator generic map (n) port map (reg8,reg9,selector5);
tempindex5 <= "1000" when selector5 = '1' else "1001" when selector5 = '0';
tempvalue5 <= reg8 when selector5 = '1' else reg9 when selector5 = '0';

C6 : comparator generic map (n) port map (tempvalue1,tempvalue2,selector6);
tempindex6 <= tempindex1 when selector6 = '1' else tempindex2 when selector6 = '0';
tempvalue6 <= tempvalue1 when selector6 = '1' else tempvalue2 when selector6 = '0';

C7 : comparator generic map (n) port map (tempvalue3,tempvalue4,selector7);
tempindex7 <= tempindex3 when selector7 = '1' else tempindex4 when selector7 = '0';
tempvalue7 <= tempvalue3 when selector7 = '1' else tempvalue4 when selector7 = '0';

C8 : comparator generic map (n) port map (tempvalue6,tempvalue7,selector8);
tempindex8 <= tempindex6 when selector8 = '1' else tempindex7 when selector8 = '0';
tempvalue8 <= tempvalue6 when selector8 = '1' else tempvalue7 when selector8 = '0';

C9 : comparator generic map (n) port map (tempvalue8,tempvalue5,selector9);
tempindex9 <= tempindex8 when selector9 = '1' else tempindex5 when selector9 = '0';
tempvalue9 <= tempvalue8 when selector9 = '1' else tempvalue5 when selector9 = '0';

index <= tempindex9;

end max_a;