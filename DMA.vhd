library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DMA is
generic (n : integer := 16;
m : integer := 2
);
port( enDMA,clkDMA,rst : in std_logic;
done : out std_logic;
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

component tenClkCounter is 
generic (n: integer := 16);
port(Clock, Clear : in  std_logic;
Output1 : out std_logic_vector(n-1 downto 0);
Output2 : out std_logic_vector(3 downto 0));
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

signal dest : std_logic_vector(9 downto 0) := (others => '0');
signal RAM1output : std_logic_vector(n-1 downto 0);
signal addressToRam1 : std_logic_vector(10 downto 0);

signal RAM2output : std_logic_vector(n-1 downto 0);
signal addressToRam2 : std_logic_vector(10 downto 0);

signal count1 : std_logic_vector(10 downto 0) := (others => '0');
signal count2 : std_logic_vector(3 downto 0) := (others => '0');
signal calculate : std_logic_vector(21 downto 0) := (others => '0');


begin
reg_0 : nRegister generic map(n) port map(RAM1output,reg0,enDMA,clkDMA,rst);
reg_1 : nRegister generic map(n) port map(RAM2output,reg1,dest(0),clkDMA,rst);
reg_2 : nRegister generic map(n) port map(RAM2output,reg2,dest(1),clkDMA,rst);
reg_3 : nRegister generic map(n) port map(RAM2output,reg3,dest(2),clkDMA,rst);
reg_4 : nRegister generic map(n) port map(RAM2output,reg4,dest(3),clkDMA,rst);
reg_5 : nRegister generic map(n) port map(RAM2output,reg5,dest(4),clkDMA,rst);
reg_6 : nRegister generic map(n) port map(RAM2output,reg6,dest(5),clkDMA,rst);
reg_7 : nRegister generic map(n) port map(RAM2output,reg7,dest(6),clkDMA,rst);
reg_8 : nRegister generic map(n) port map(RAM2output,reg8,dest(7),clkDMA,rst);
reg_9 : nRegister generic map(n) port map(RAM2output,reg9,dest(8),clkDMA,rst);
reg_10 : nRegister generic map(n) port map(RAM2output,reg10,dest(9),clkDMA,rst);

my_ram1 : ram generic map(n) port map(clkDMA,'0',addressToRam1,"0000000000000000",RAM1output);
my_ram2 : ram generic map(n) port map(clkDMA,'0',addressToRam2,"0000000000000000",RAM2output);

my_counter : tenClkCounter generic map(11) port map(clkDMA,rst,count1,count2);

addressToRam1 <= count1;
calculate <= std_logic_vector(unsigned(count1)*10+unsigned(count2));
addressToRam2 <= calculate(10 downto 0);

dest(0) <= '1' when count2 = "0000" and enDMA = '1' else '0';
dest(1) <= '1' when count2 = "0001" and enDMA = '1' else '0';
dest(2) <= '1' when count2 = "0010" and enDMA = '1' else '0';
dest(3) <= '1' when count2 = "0011" and enDMA = '1' else '0';
dest(4) <= '1' when count2 = "0100" and enDMA = '1' else '0';
dest(5) <= '1' when count2 = "0101" and enDMA = '1' else '0';
dest(6) <= '1' when count2 = "0110" and enDMA = '1' else '0';
dest(7) <= '1' when count2 = "0111" and enDMA = '1' else '0';
dest(8) <= '1' when count2 = "1000" and enDMA = '1' else '0';
dest(9) <= '1' when count2 = "1001" and enDMA = '1' else '0';

done <= '1' when count2 = "0000" and count1 /= "00000000000" else '0';

end DMA_a;