----------------------------------------------------------------------------------
-- Engineer: Giancarlo Marin Hernandez
-- 
-- Create Date: 12/14/2018 02:20:03 PM
-- Design Name: Contador_Hexadecimal
-- Module Name: top_tb - Behavioral
-- Project Name: Contador_Hexadecimal
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench de la máquina de estados que controla al contador hexadecimal
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

entity top_tb is
end top_tb;

architecture Behavioral of top_tb is

    component top
        Port ( 
            Clk: in std_logic;
            Reset: in std_logic;
            StartStop: in std_logic;
            display_number: out std_logic_vector(6 downto 0);
            display_selection: out std_logic_vector(3 downto 0)
        );
    end component;

    --inputs
    signal clk: std_logic := '0';
    signal Reset: std_logic := '0';
    signal StartStop: std_logic := '0';
    --outputs
    signal display_number: std_logic_vector(6 downto 0);
    signal display_selection: std_logic_vector(3 downto 0); 
    
    begin
    
    -- Inicializacion de la unidad por testear
        uut: top port map(
            Clk => Clk,
            Reset => Reset,
            StartStop => StartStop,
            display_number => display_number,
            display_selection => display_selection
        );
    -- clock definition    
        clk <= not clk after 50ns;    
    -- Estimulos basicos transicion de estados
        stim1: process
        begin
            wait for 10ns; 
            StartStop <= '1';
            wait for 10ns; 
            StartStop <= '0';
            wait for 300ns;
            Reset <= '1', '0' after 10ns;
            wait for 100ns;
            StartStop <= '1';
            wait for 10ns; 
            StartStop <= '0';
            wait for 200ns;
            StartStop <= '1';
            wait for 10ns; 
            StartStop <= '0';
            wait for 200ns;
     end process; 
end Behavioral;
