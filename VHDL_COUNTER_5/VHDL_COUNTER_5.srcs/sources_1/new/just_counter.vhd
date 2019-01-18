library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity just_counter is
    Port ( 
        clk: in std_logic;
        enable: in std_logic;
        reset: in std_logic;
        display_number: out std_logic_vector(6 downto 0);
        display_selection: out std_logic_vector(3 downto 0)
        );
end just_counter;

architecture Behavioral of just_counter is
  
  
--components:
    component clkdivider1 
    Port (
        Clk: in  STD_LOGIC;
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
            display_number: out std_logic_vector(6 downto 0);
            display_selection: out std_logic_vector(3 downto 0)
         );
    end component;
    
    component bin_counter 
        generic( 
               width: positive := 4);
        Port ( 
               clk: in std_logic;
               reset: in std_logic;
               eneable: in std_logic;
               count: out std_logic_vector(width-1 downto 0);
               salida: out std_logic  
        );
    end component;
    
    
    signal reloj1: std_logic;
    signal reloj2:std_logic;
    signal unid: std_logic_vector(3 downto 0);
    signal dec: std_logic_vector(3 downto 0);
    signal salida_unid: std_logic;
    signal bcd_unid: std_logic_vector(6 downto 0);
    signal bcd_dec: std_logic_vector(6 downto 0);
    --Para evitar que cuando el counter se quede parado en unidades F, siga contando las decenas se ha creado
    --esta señal suma_decenas, que sera un and de la salida de unidades y el enable para contar.
    signal suma_decenas: std_logic; 
  
    
    begin
    
    
    clk1: clkdivider1000 port map(
                Clk => Clk,
                Reset  => reset,
                Clk_out1000 => reloj1
            );
    clk2: clkdivider1 port map(
                            Clk => clk,
                            Reset  => reset,
                            Clk_out1 => reloj2
                        );
    
    countunid: bin_counter port map(
        clk => reloj2,
        reset=>reset,
        eneable=>enable,
        count=>unid,
        salida=>salida_unid
        );  
    
    countdec: bin_counter port map(
                clk => reloj2,
                reset=>reset,
                eneable=>suma_decenas,
                count=>dec               
                );  
    
    decodificadorunidades: bcd7seg port map(
                code => unid,
                led => bcd_unid
    );
    
    decodificadordecenas: bcd7seg port map(
                    code => dec,
                    led => bcd_dec
        );
    
    displayRe: DisplayRefresh Port map (
                    clk => reloj1,
                    segment_unid => bcd_unid,
                    segment_dec => bcd_dec,
                    display_number => display_number,
                    display_selection => display_selection
                 ); 
 
 
    suma_decenas<=salida_unid and enable;
    
    end;
