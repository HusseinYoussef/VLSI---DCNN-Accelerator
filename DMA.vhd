library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DMA is
generic (n : integer := 5;
m : integer := 4
);
port( enDMA,clkDMA,rst : in std_logic;
reg0 : out std_logic_vector ( n-1 downto 0);
reg1 : out std_logic_vector ( n-1 downto 0);
reg2 : out std_logic_vector ( n-1 downto 0);
reg3 : out std_logic_vector ( n-1 downto 0);
reg4 : out std_logic_vector ( n-1 downto 0);
reg5 : out std_logic_vector ( n-1 downto 0);
reg6 : out std_logic_vector ( n-1 downto 0);
reg7 : out std_logic_vector ( n-1 downto 0);
reg8 : out std_logic_vector ( n-1 downto 0);
reg9 : out std_logic_vector ( n-1 downto 0);
reg10 : out std_logic_vector ( n-1 downto 0)
);
end DMA;


architecture DMA_a of DMA is
component nRegister is
generic (n: integer := 16);
port(inputR : in std_logic_vector(n-1 downto 0);
outputR : out std_logic_vector(n-1 downto 0);
enR,clk,rstR : in std_logic
);
end component;

component ram is
generic (n : integer := 16);
port(clkRam : in std_logic;
we : in std_logic;
address : in std_logic_vector(10 downto 0);
dataInRam : in std_logic_vector(n-1 downto 0);
dataOutRam : out std_logic_vector(n-1 downto 0)
);
end component;

signal dest : std_logic_vector(10 downto 0);
signal RAM1output : std_logic_vector(n-1 downto 0);
signal addressToRam1 : std_logic_vector(10 downto 0);

signal RAM2output : std_logic_vector(n-1 downto 0);
signal addressToRam2 : std_logic_vector(10 downto 0);

begin
reg_0 : nRegister generic map(n) port map(RAM1output,reg0,dest(0),clkDMA,rst);
reg_1 : nRegister generic map(n) port map(RAM2output,reg1,dest(1),clkDMA,rst);
reg_2 : nRegister generic map(n) port map(RAM2output,reg2,dest(2),clkDMA,rst);
reg_3 : nRegister generic map(n) port map(RAM2output,reg3,dest(3),clkDMA,rst);
reg_4 : nRegister generic map(n) port map(RAM2output,reg4,dest(4),clkDMA,rst);
reg_5 : nRegister generic map(n) port map(RAM2output,reg5,dest(5),clkDMA,rst);
reg_6 : nRegister generic map(n) port map(RAM2output,reg6,dest(6),clkDMA,rst);
reg_7 : nRegister generic map(n) port map(RAM2output,reg7,dest(7),clkDMA,rst);
reg_8 : nRegister generic map(n) port map(RAM2output,reg8,dest(8),clkDMA,rst);
reg_9 : nRegister generic map(n) port map(RAM2output,reg9,dest(9),clkDMA,rst);
reg_10 : nRegister generic map(n) port map(RAM2output,reg10,dest(10),clkDMA,rst);

my_ram1 : ram generic map(n) port map(clkDMA,'0',addressToRam1,"00000",RAM1output);
my_ram2 : ram generic map(n) port map(clkDMA,'0',addressToRam2,"00000",RAM2output);

process is 
variable x : integer :=0;
variable y : integer :=0;
begin
while enDMA = '1' and x < m loop
dest <= "00000000000";
wait for 0 ns;
dest(0) <= '1';
wait for 0 ns;
addressToRam1 <= std_logic_vector(to_unsigned(x,11));
y := 0;
wait until clkDMA = '1';
while enDMA = '1' and y < 3 loop
dest <= "00000000000";
wait for 0 ns;       
dest(y+1) <= '1';
wait for 0 ns;
addressToRam2 <= std_logic_vector(to_unsigned(x*3+y,11));
wait until clkDMA = '1'; 
y := y+1;
end loop;
x := x+1;
end loop;
wait until clkDMA = '0';
end process;

end DMA_a;