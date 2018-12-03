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
    type STATE_T is (S0_RESET, S1_COUNT, S2_STOP);
    signal state_register: STATE_T;
    signal next_state: STATE_T;
--components:
    component clkdivider1 is
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
    
    
    
begin

-- Interconexión de bloques
--    div1:  
    
    
        
    sr: process(Clk, Reset)
    begin   
        if Reset = '1' then
            state_register <= S0_RESET;
        elsif rising_edge(Clk) then
            state_register <= next_state;
        end if;
    end process;
    
    next_state_dec: process(state_register, StartStop)
    begin
        next_state <= state_register;
        case state_register is
            when S0_RESET =>
                if StartStop = '1' then
                    next_state <= S1_COUNT;
                end if;
            when S1_COUNT =>
                if StartStop = '1' then
                    next_state <= S2_STOP;
                end if;
            when S2_STOP =>
                if StartStop = '1' then
                    next_state <= S1_COUNT;
                end if;
        end case;
    end process;
          
    output_dec: process(state_register)
        begin
            
    end process;
end Behavioral;
