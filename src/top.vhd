---------------------------------------------------------------------------------- 
-- Engineer: Giancarlo Marin H.
-- 
-- Create Date: 12/03/2018 02:11:41 PM
-- Design Name: Contador_Hexadecimal
-- Module Name: top - Behavioral
-- Project Name:  Contador_Hexadecimal 
-- Target Devices: 
-- Tool Versions: 
-- Description: Arquitectura de la máquina de estados que controla al contador hexadecimal
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( 
        Clk: in std_logic;
        Reset: in std_logic;
        StartStop: in std_logic;
        display_number: out std_logic_vector(6 downto 0);
        display_selection: out std_logic_vector(3 downto 0)
        );
end top;

architecture Behavioral of top is

-- Definicion de variables para Maquina de Estados
    type STATE_T is (S0_RESET, S1_COUNT, S2_STOP);
    signal state_register: STATE_T;
    signal next_state: STATE_T;
    
--components:
    component clk_divider1
        Port (
            Clk: in  STD_LOGIC;
            Reset  : in  STD_LOGIC;
            Clk_out1 : out STD_LOGIC
        );
    end component;
    
    component clk_divider1000
        Port (
            Clk: in  STD_LOGIC;
            Reset  : in  STD_LOGIC;
            Clk_out1000 : out STD_LOGIC
        );
    end component;
    
    component PulsadorAntiRebotes
        port (
            clk    : in std_logic;
            boton_in    : in std_logic;
            boton_out    : out std_logic
        );
    end component;
    
    component bin_counter
        generic( 
            width: positive := 4
            );
        Port ( 
            clk: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            count: out std_logic_vector(width-1 downto 0);
            salida: out std_logic  
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
    
-- Señales de interconexión
    signal Clk_out1: std_logic;
    signal Clk_out1000: std_logic;
    signal boton_out: std_logic;
    signal enable: std_logic;            
    signal salida: std_logic;
    signal unidades: std_logic_vector(3 downto 0);
    signal decenas: std_logic_vector(3 downto 0);
    signal seg_unid: std_logic_vector(6 downto 0);
    signal seg_dec: std_logic_vector(6 downto 0);
    signal display_num_out: std_logic_vector(6 downto 0);
    signal display_sel_out: std_logic_vector(3 downto 0);
    
    begin

-- Interconexión de bloques
    div1: clk_divider1 port map(
        Clk => Clk,
        Reset => Reset,
        Clk_out1 => Clk_out1
    );   
    
    div1000: clk_divider1000 port map(
        Clk => Clk,
        Reset => Reset,
        Clk_out1000 => Clk_out1000
     );
     
     puls: PulsadorAntiRebotes port map(
        Clk => Clk_out1000,
        boton_in => StartStop,
        boton_out => boton_out         
     );
        
    count_units: bin_counter port map(
        clk => Clk_out1,
        reset => Reset,
        enable => enable,
        count => unidades,
        salida => salida
    );
    
    count_dec: bin_counter port map(
        clk => Clk_out1,
        reset => Reset,
        enable => salida,
        count => decenas
    );
    
    dec1: bcd7seg port map(
        code => unidades,
        led => seg_unid  
    );
    
    dec2: bcd7seg port map(
        code => decenas,
        led => seg_dec  
    );    
    
    dr: DisplayRefresh port map(
        Clk => Clk_out1000,
        segment_unid => seg_unid,
        segment_dec => seg_dec,
        display_number => display_num_out,
        display_selection => display_sel_out          
    );
    
    display_number <= display_num_out;
    display_selection <= display_sel_out;
    
    sr: process(Clk, Reset)
    begin   
        if Reset = '1' then
            state_register <= S0_RESET;
        elsif rising_edge(Clk) then
            state_register <= next_state;
        end if;
    end process;
    
    next_state_dec: process(state_register, boton_out)
    begin
        next_state <= state_register;
        case state_register is
            when S0_RESET =>
                if boton_out = '1' then
                    next_state <= S1_COUNT;
                end if;
            when S1_COUNT =>
                if boton_out = '1' then
                    next_state <= S2_STOP;
                end if;
            when S2_STOP =>
                if boton_out = '1' then
                    next_state <= S1_COUNT;
                end if;
        end case;
    end process;
          
    output_dec: process(state_register)
        begin
        case state_register is
            when S0_RESET =>
                enable <= '0';
            when S1_COUNT =>
                enable <= '1';
            when S2_STOP =>
                enable <= '0';
        end case;    
    end process;
end Behavioral;