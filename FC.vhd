library IEEE;
use IEEE.std_logic_1164.all;

entity FC is
generic (n : integer := 16;
         m : integer := 20
    );
port(start,clk,rst: in std_logic;
Done: out std_logic;
index : out std_logic_vector (3 downto 0)
    );
end FC;


architecture flow of FC is 

component DMA is
    generic (n : integer := 16;
    m : integer := 20
    );
    port( enDMA,clkDMA,rst : in std_logic;
    done : out std_logic;
    ramFinish : out std_logic;
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
end component;


component nRegister is
    generic (n: integer := 16);
    port(inputR : in std_logic_vector(n-1 downto 0);
    outputR : out std_logic_vector(n-1 downto 0);
    enR,clk,rstR : in std_logic
    );
end component;

component Multiplier is
    generic(n:integer :=16);
     port( start : in std_logic; 
        A,B :in std_logic_vector(n-1 downto 0);
          F  :out std_logic_vector(n+n-1 downto 0);
          done: out std_logic
     );
end component;



component my_nadder is
    generic(n:integer :=32);
    port( aa,bb :in std_logic_vector(n-1 downto 0);
          c_cin:in std_logic; 
          ff   :out std_logic_vector(n-1 downto 0)
          );
end component;

component max is
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
end component;

signal DMA_CNN,DMA_w1,DMA_w2,DMA_w3,DMA_w4,DMA_w5,DMA_w6,DMA_w7,DMA_w8,DMA_w9,DMA_w10: std_logic_vector(n-1 downto 0);

signal CNNNeuron,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10: std_logic_vector(n-1 downto 0);

signal Multiplied_w1,Multiplied_w2,Multiplied_w3,Multiplied_w4,Multiplied_w5,Multiplied_w6,Multiplied_w7,Multiplied_w8,Multiplied_w9,Multiplied_w10: std_logic_vector(n+n-1 downto 0);

signal input_prob1,input_prob2,input_prob3,input_prob4,input_prob5,input_prob6,input_prob7,input_prob8,input_prob9,input_prob10: std_logic_vector(n+n-1 downto 0);

signal prob_value1,prob_value2,prob_value3,prob_value4,prob_value5,prob_value6,prob_value7,prob_value8,prob_value9,prob_value10: std_logic_vector(n+n-1 downto 0);

signal DMASt,DMAF,MultipSt,MultipF,AddSt,AddF,MemF,RegcpySt,RegcpyF : std_logic;


begin

DMAmacro : DMA generic map(n) port map(DMASt,clk,rst,DMAF,MemF,DMA_CNN,DMA_w1,DMA_w2,DMA_w3,DMA_w4,DMA_w5,DMA_w6,DMA_w7,DMA_w8,DMA_w9,DMA_w10);

Neuron : nRegister generic map(n) port map(DMA_CNN,CNNNeuron,DMAF,clk,rst);
Weight1 : nRegister generic map(n) port map(DMA_w1,w1,DMAF,clk,rst);
Weight2 : nRegister generic map(n) port map(DMA_w2,w2,DMAF,clk,rst);
Weight3 : nRegister generic map(n) port map(DMA_w3,w3,DMAF,clk,rst);
Weight4 : nRegister generic map(n) port map(DMA_w4,w4,DMAF,clk,rst);
Weight5 : nRegister generic map(n) port map(DMA_w5,w5,DMAF,clk,rst);
Weight6 : nRegister generic map(n) port map(DMA_w6,w6,DMAF,clk,rst);
Weight7 : nRegister generic map(n) port map(DMA_w7,w7,DMAF,clk,rst);
Weight8 : nRegister generic map(n) port map(DMA_w8,w8,DMAF,clk,rst);
Weight9 : nRegister generic map(n) port map(DMA_w9,w9,DMAF,clk,rst);
Weight10 : nRegister generic map(n) port map(DMA_w10,w10,DMAF,clk,rst);
    
multip1 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w1,Multiplied_w1,MultipF);
multip2 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w2,Multiplied_w2,MultipF);
multip3 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w3,Multiplied_w3,MultipF);
multip4 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w4,Multiplied_w4,MultipF);
multip5 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w5,Multiplied_w5,MultipF);
multip6 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w6,Multiplied_w6,MultipF);
multip7 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w7,Multiplied_w7,MultipF);
multip8 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w8,Multiplied_w8,MultipF);
multip9 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w9,Multiplied_w9,MultipF);
multip10 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w10,Multiplied_w10,MultipF);

adder1 : my_nadder generic map(n+n) port map(prob_value1,Multiplied_w1,'0',input_prob1);
adder2 : my_nadder generic map(n+n) port map(prob_value2,Multiplied_w2,'0',input_prob2);
adder3 : my_nadder generic map(n+n) port map(prob_value3,Multiplied_w3,'0',input_prob3);
adder4 : my_nadder generic map(n+n) port map(prob_value4,Multiplied_w4,'0',input_prob4);
adder5 : my_nadder generic map(n+n) port map(prob_value5,Multiplied_w5,'0',input_prob5);
adder6 : my_nadder generic map(n+n) port map(prob_value6,Multiplied_w6,'0',input_prob6);
adder7 : my_nadder generic map(n+n) port map(prob_value7,Multiplied_w7,'0',input_prob7);
adder8 : my_nadder generic map(n+n) port map(prob_value8,Multiplied_w8,'0',input_prob8);
adder9 : my_nadder generic map(n+n) port map(prob_value9,Multiplied_w9,'0',input_prob9);
adder10 : my_nadder generic map(n+n) port map(prob_value10,Multiplied_w10,'0',input_prob10);

prob1 : nRegister generic map(n) port map(input_prob1,prob_value1,AddF,clk,rst);
prob2 : nRegister generic map(n) port map(input_prob2,prob_value2,AddF,clk,rst);
prob3 : nRegister generic map(n) port map(input_prob3,prob_value3,AddF,clk,rst);
prob4 : nRegister generic map(n) port map(input_prob4,prob_value4,AddF,clk,rst);
prob5 : nRegister generic map(n) port map(input_prob5,prob_value5,AddF,clk,rst);
prob6 : nRegister generic map(n) port map(input_prob6,prob_value6,AddF,clk,rst);
prob7 : nRegister generic map(n) port map(input_prob7,prob_value7,AddF,clk,rst);
prob8 : nRegister generic map(n) port map(input_prob8,prob_value8,AddF,clk,rst);
prob9 : nRegister generic map(n) port map(input_prob9,prob_value9,AddF,clk,rst);
prob10 : nRegister generic map(n) port map(input_prob10,prob_value10,AddF,clk,rst);

maxer : max generic map(n+n) port map(prob_value1,prob_value2,prob_value3,prob_value4,prob_value5,prob_value6,prob_value7,prob_value8,prob_value9,prob_value10,index);

process (clk) 
begin

if (clk'event and clk = '1') then

    if(start='1' or (RegcpyF='1' and AddF='1')) then
        DMASt<='1';
        RegcpyF<='0';
	RegcpySt<='0';
        AddF<='0';
    end if;

    if(DMAF='1') then
        RegcpyF<='1';
        DMAF<='0';
    end if;

    if(RegcpyF='1' and AddF='1') then
        MultipSt<='1';
        MultipF<='0';
    end if;

    if(MultipF='1') then
        MultipSt<='0';
        MultipF<='0';
        AddSt<='1';
    end if;

    if(AddSt='1') then
        AddSt<='0';
        AddF<='1';
    end if;

    if(AddF='1' and MemF='1') then
        Done<='1';
    end if;

end if;

end process;

end flow;