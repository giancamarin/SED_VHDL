----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2019 09:16:14
-- Design Name: 
-- Module Name: maquina_contador - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maquina_contador is
    Port ( 
     clk: in std_logic;
     reset: in std_logic;
     startstop: in std_logic;
     display_number: out std_logic_vector(6 downto 0);
     display_selection: out std_logic_vector(3 downto 0)
    );
end maquina_contador;

architecture structural of maquina_contador is

-- Definicion de variables para Maquina de Estados
    type STATE_T is (S0_RESET, S1_COUNT, S2_STOP);
        signal state_register: STATE_T := S0_RESET;
        signal next_state: STATE_T := S1_COUNT;
        
--Componentes:
    component PulsadorAntiRebotes
        port (
            clk    : in std_logic;
            boton_in    : in std_logic;
            boton_out    : out std_logic
        );
    end component;
    
    component just_counter
        Port ( 
            clk: in std_logic;
            enable: in std_logic;
            reset: in std_logic;
            display_number: out std_logic_vector(6 downto 0);
            display_selection: out std_logic_vector(3 downto 0)
            );
    end component;
    
    --señales de interconexion de la maquina:
    signal reloj: std_logic;   
    signal salida_antirrebotes: std_logic;
    signal display_num:  std_logic_vector(6 downto 0);
    signal display_sel: std_logic_vector(3 downto 0);
    signal enable: std_logic;
    
 begin    
    --Conexionado de los componentes: 
   
    pulsador: PulsadorAntiRebotes port map(
    Clk => clk,
    boton_in => StartStop,
    boton_out => salida_antirrebotes
    );  
    
    modulo_contador: just_counter port map(
    clk=>clk,
    enable=>enable,
    reset=>reset,
    display_number=>display_num,
    display_selection=>display_sel
    ); 
    
    --entradas y salidas del modulo contador al global:
    display_number<=display_num;
    display_selection<=display_sel;

    estados: process(reset)
    begin   
        
     --Programacion de los estados:  
        if state_register = S0_RESET then
            next_state <= S1_COUNT;
            
        elsif state_register = S1_COUNT then
            next_state<=S2_STOP;
          
        elsif state_register= S2_STOP then
            next_state<=S1_COUNT;
           
        end if;
     
     --Cuando se produce el cambio entre estados:  
        if reset ='1' then
            state_register <= S0_RESET;
        else                             
            if rising_edge(salida_antirrebotes) then
                state_register<=next_state;
            end if;    
        end if;
        
     -- Accion en cada estado:   
        case state_register is
            when S0_RESET => enable <='0';
            when S1_COUNT => enable <='1';
            when S2_STOP => enable <='0';
        end case;
        
         
    end process;
        

end structural;
