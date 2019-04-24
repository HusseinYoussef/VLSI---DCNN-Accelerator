library IEEE;
use IEEE.std_logic_1164.all;

entity FC is
generic (n : integer := 16;
         m : integer := 4
    );
port(start,clk,rst: in std_logic;
Done: out std_logic;
index : out std_logic_vector (3 downto 0)
    );
end FC;


architecture flow of FC is 

component DMA is
generic (n : integer := 16;
m : integer := 2
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
reg10 : out std_logic_vector ( n-1 downto 0);
dmfin,ramFinish : out std_logic
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
          ff   :out std_logic_vector(n-1 downto 0);
	  c_cout : out std_logic
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

component tri_state is
	generic (n: integer := 32); 
port( inputTS : in std_logic_vector(n-1 downto 0);
outputTS : out std_logic_vector(n-1 downto 0);
enTS : in std_logic
);
end component;

signal DMA_CNN,DMA_w1,DMA_w2,DMA_w3,DMA_w4,DMA_w5,DMA_w6,DMA_w7,DMA_w8,DMA_w9,DMA_w10: std_logic_vector(n-1 downto 0);

signal CNNNeuron,w1,w2,w3,w4,w5,w6,w7,w8,w9,w10: std_logic_vector(n-1 downto 0);

signal dum,Multiplied_w1,Multiplied_w2,Multiplied_w3,Multiplied_w4,Multiplied_w5,Multiplied_w6,Multiplied_w7,Multiplied_w8,Multiplied_w9,Multiplied_w10: std_logic_vector(n+n-1 downto 0);

signal signalMultipReg1,signalMultipReg2,signalMultipReg3,signalMultipReg4,signalMultipReg5,signalMultipReg6,signalMultipReg7,signalMultipReg8,signalMultipReg9,signalMultipReg10: std_logic_vector(n+n-1 downto 0);

signal input_prob1,input_prob2,input_prob3,input_prob4,input_prob5,input_prob6,input_prob7,input_prob8,input_prob9,input_prob10: std_logic_vector(n+n-1 downto 0);

signal prob_value1,prob_value2,prob_value3,prob_value4,prob_value5,prob_value6,prob_value7,prob_value8,prob_value9,prob_value10: std_logic_vector(n+n-1 downto 0);

signal DMASt,DMAF,MultipSt,MultipF,AddSt,ProcessF,MemF,RegcpySt,RegcpyF : std_logic;
signal cout,dummy,last_proc : std_logic;


begin

DMAmacro : DMA generic map(n,m) port map(DMASt,clk,rst,DMA_CNN,DMA_w1,DMA_w2,DMA_w3,DMA_w4,DMA_w5,DMA_w6,DMA_w7,DMA_w8,DMA_w9,DMA_w10,DMAF,MemF);

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
    
multip1 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w1,Multiplied_w1,dummy);
multip2 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w2,Multiplied_w2,dummy);
multip3 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w3,Multiplied_w3,dummy);
multip4 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w4,Multiplied_w4,dummy);
multip5 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w5,Multiplied_w5,dummy);
multip6 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w6,Multiplied_w6,dummy);
multip7 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w7,Multiplied_w7,dummy);
multip8 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w8,Multiplied_w8,dummy);
multip9 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w9,Multiplied_w9,dummy);
multip10 : Multiplier generic map(n) port map(MultipSt,CNNNeuron,w10,Multiplied_w10,dummy);

mulreg1 : nRegister generic map(n+n) port map(Multiplied_w1,signalMultipReg1,MultipF,clk,rst);
mulreg2 : nRegister generic map(n+n) port map(Multiplied_w2,signalMultipReg2,MultipF,clk,rst);
mulreg3 : nRegister generic map(n+n) port map(Multiplied_w3,signalMultipReg3,MultipF,clk,rst);
mulreg4 : nRegister generic map(n+n) port map(Multiplied_w4,signalMultipReg4,MultipF,clk,rst);
mulreg5 : nRegister generic map(n+n) port map(Multiplied_w5,signalMultipReg5,MultipF,clk,rst);
mulreg6 : nRegister generic map(n+n) port map(Multiplied_w6,signalMultipReg6,MultipF,clk,rst);
mulreg7 : nRegister generic map(n+n) port map(Multiplied_w7,signalMultipReg7,MultipF,clk,rst);
mulreg8 : nRegister generic map(n+n) port map(Multiplied_w8,signalMultipReg8,MultipF,clk,rst);
mulreg9 : nRegister generic map(n+n) port map(Multiplied_w9,signalMultipReg9,MultipF,clk,rst);
mulreg10 : nRegister generic map(n+n) port map(Multiplied_w10,signalMultipReg10,MultipF,clk,rst);

adder1 : my_nadder generic map(n+n) port map(prob_value1,signalMultipReg1,'0',input_prob1,cout);
adder2 : my_nadder generic map(n+n) port map(prob_value2,signalMultipReg2,'0',input_prob2,cout);
adder3 : my_nadder generic map(n+n) port map(prob_value3,signalMultipReg3,'0',input_prob3,cout);
adder4 : my_nadder generic map(n+n) port map(prob_value4,signalMultipReg4,'0',input_prob4,cout);
adder5 : my_nadder generic map(n+n) port map(prob_value5,signalMultipReg5,'0',input_prob5,cout);
adder6 : my_nadder generic map(n+n) port map(prob_value6,signalMultipReg6,'0',input_prob6,cout);
adder7 : my_nadder generic map(n+n) port map(prob_value7,signalMultipReg7,'0',input_prob7,cout);
adder8 : my_nadder generic map(n+n) port map(prob_value8,signalMultipReg8,'0',input_prob8,cout);
adder9 : my_nadder generic map(n+n) port map(prob_value9,signalMultipReg9,'0',input_prob9,cout);
adder10 : my_nadder generic map(n+n) port map(prob_value10,signalMultipReg10,'0',input_prob10,cout);

prob1 : nRegister generic map(n+n) port map(input_prob1,prob_value1,AddSt,clk,rst);
prob2 : nRegister generic map(n+n) port map(input_prob2,prob_value2,AddSt,clk,rst);
prob3 : nRegister generic map(n+n) port map(input_prob3,prob_value3,AddSt,clk,rst);
prob4 : nRegister generic map(n+n) port map(input_prob4,prob_value4,AddSt,clk,rst);
prob5 : nRegister generic map(n+n) port map(input_prob5,prob_value5,AddSt,clk,rst);
prob6 : nRegister generic map(n+n) port map(input_prob6,prob_value6,AddSt,clk,rst);
prob7 : nRegister generic map(n+n) port map(input_prob7,prob_value7,AddSt,clk,rst);
prob8 : nRegister generic map(n+n) port map(input_prob8,prob_value8,AddSt,clk,rst);
prob9 : nRegister generic map(n+n) port map(input_prob9,prob_value9,AddSt,clk,rst);
prob10 : nRegister generic map(n+n) port map(input_prob10,prob_value10,AddSt,clk,rst);

maxer : max generic map(n+n) port map(prob_value1,prob_value2,prob_value3,prob_value4,prob_value5,prob_value6,prob_value7,prob_value8,prob_value9,prob_value10,index);

process (clk) 
begin
if (clk'event and clk='1') then

    if ((RegcpyF='1' and ProcessF='1') or start='1' or DMAF='0') then
	DMASt<='1';
    else DMASt<='0';
    end if;

    if(DMAF='1') then 
	RegCpyF<='1'; 
    else RegCpyF<='0';
    end if;

    if ((RegcpyF='1' and ProcessF='1') or MultipSt='1' or MultipF='1') then 
        ProcessF<='0';
    else ProcessF<='1';
    end if;

    if(RegcpyF='1' and ProcessF='1' and MemF='1') then
	last_proc<='1';
    end if;

    if((RegcpyF='1' and ProcessF='1') or start='1') then
        MultipSt<='1';
    else MultipSt<='0';
    end if;

    if(MultipSt='1') then
        MultipF<='1';
    else MultipF<='0';
    end if;

    if(MultipF='1') then
        AddSt<='1';
    else AddSt<='0';
    end if;

    if(ProcessF='1' and last_proc='1') then
        Done<='1';
    end if;

end if;

end process;

end flow;
