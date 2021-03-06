library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity just_counter is
    Port ( 
        clk: in std_logic;
        enable: in std_logic;
        down_n: in std_logic;
        fast_n: in std_logic;
        reset: in std_logic;
        display_number: out std_logic_vector(6 downto 0);
        display_selection: out std_logic_vector(7 downto 0)
        );
end just_counter;

architecture Behavioral of just_counter is
  
--components:
    component clkdivider1 
    Port (
        Clk: in  STD_LOGIC;
        fast_n: in std_logic;
        Reset  : in  STD_LOGIC;
        Clk_out1 : out STD_LOGIC
        );
    end component;
    
    component clkdivider1000 
        Port (
            Clk: in  STD_LOGIC;
            Reset  : in  STD_LOGIC;
            Clk_out1000 : out STD_LOGIC
        );
    end component;
    
    component bcd7seg 
        Port ( 
            code : in std_logic_vector (3 downto 0);
            led : out std_logic_vector (6 downto 0)
            );
    end component;
    
    component DisplayRefresh 
        Port (
            clk: in std_logic;
            segment_unid: in std_logic_vector(6 downto 0);
            segment_dec: in std_logic_vector(6 downto 0);
            segment_cent: in std_logic_vector(6 downto 0);
            segment_mil: in std_logic_vector(6 downto 0);
            display_number: out std_logic_vector(6 downto 0);
            display_selection: out std_logic_vector(7 downto 0)
         );
    end component;
    
    component bin_counter 
        generic( 
               width: positive := 4);
        Port ( 
               clk: in std_logic;
               reset: in std_logic;
               eneable: in std_logic;
               down_n: in std_logic;
               count: out std_logic_vector(width-1 downto 0);
               salida: out std_logic  
        );
    end component;
    
    
    signal reloj1: std_logic;
    signal reloj2:std_logic;
    signal unid: std_logic_vector(3 downto 0);
    signal dec: std_logic_vector(3 downto 0);
    signal cent: std_logic_vector(3 downto 0);
    signal mil: std_logic_vector(3 downto 0);
    signal salida_unid: std_logic;
    signal salida_dec: std_logic;
    signal salida_cent: std_logic;
    signal bcd_unid: std_logic_vector(6 downto 0);
    signal bcd_dec: std_logic_vector(6 downto 0);
    signal bcd_cent: std_logic_vector(6 downto 0);
    signal bcd_mil: std_logic_vector(6 downto 0);
    
    --Para evitar que cuando el counter se quede parado en unidades F, siga contando las decenas se ha creado
    --esta se�al suma_decenas, que sera un and de la salida de unidades y el enable para contar.
    signal suma_decenas: std_logic;
    signal suma_centenas: std_logic;
    signal suma_miles: std_logic; 
  
    
    begin
    
    
    clk1: clkdivider1000 port map(
                Clk => Clk,
                Reset  => reset,
                Clk_out1000 => reloj1
            );
    clk2: clkdivider1 port map(
                            Clk => clk,
                            fast_n=>fast_n,
                            Reset  => reset,
                            Clk_out1 => reloj2
                        );
    
    countunid: bin_counter port map(
        clk => reloj2,
        reset=>reset,
        eneable=>enable,
        down_n=>down_n,
        count=>unid,
        salida=>salida_unid
        );  
    
    countdec: bin_counter port map(
                clk => reloj2,
                reset=>reset,
                eneable=>suma_decenas,
                down_n=>down_n,
                count=>dec, 
                salida=>salida_dec             
                );  
    countcent: bin_counter port map(
                        clk => reloj2,
                        reset=>reset,
                        eneable=>suma_centenas,
                        down_n=>down_n,
                        count=>cent,
                        salida=>salida_cent
                        );  
    countmil: bin_counter port map(
                        clk => reloj2,
                        reset=>reset,
                        eneable=>suma_miles,
                        down_n=>down_n,
                        count=>mil
                        );                      
    decodificadorunidades: bcd7seg port map(
                code => unid,
                led => bcd_unid
    );
    
    decodificadordecenas: bcd7seg port map(
                    code => dec,
                    led => bcd_dec
        );
        
    decodificadorcentenas: bcd7seg port map(
                            code => cent,
                            led => bcd_cent
           );
    decodificadormillares: bcd7seg port map(
                               code => mil,
                               led => bcd_mil
     );       
    
    displayRe: DisplayRefresh Port map (
                    clk => reloj1,
                    segment_unid => bcd_unid,
                    segment_dec => bcd_dec,
                    segment_cent => bcd_cent,
                    segment_mil => bcd_mil,
                    display_number => display_number,
                    display_selection => display_selection
                 ); 
 
 
    suma_decenas<=salida_unid and enable;
    suma_centenas<=salida_dec and enable;
    suma_miles<=salida_cent and enable;
    
    end;
