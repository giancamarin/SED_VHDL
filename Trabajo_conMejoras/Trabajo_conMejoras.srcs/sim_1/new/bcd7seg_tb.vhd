---------------------------------------------------------------------------------- 
-- Engineer: Giancarlo Marín Hernández
-- 
-- Create Date: 12/01/2018 06:59:51 PM
-- Design Name: Contador_Hexadecimal
-- Module Name: bcd7seg_tb - Behavioral
-- Project Name: Contador_Hexadecimal
-- Description: Test bench del decodificador bcd a 7 segmentos
-- 
-- Dependencies: 
-- 
-- Revision: 1
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd7seg_tb is
end bcd7seg_tb;

architecture Behavioral of bcd7seg_tb is
component bcd7seg
    Port ( 
        code : in std_logic_vector (3 downto 0);
        led : out std_logic_vector (6 downto 0)
        );
end component;

-- inputs
signal code : std_logic_vector (3 downto 0) := (others => '0');
-- outputs
signal led : std_logic_vector (6 downto 0); 

begin
-- Inicializacion de la unidad por testear
uut: bcd7seg port map(
    code => code,
    led => led
);

-- Estimulos
stim_proc: process
    begin
        code <= "0000";
        wait for 100ns;
        code <= "0001";
        wait for 100ns;
        code <= "0010";
        wait for 100ns;
        code <= "0011";
        wait for 100ns;
        code <= "0100";
        wait for 100ns;
        code <= "0101";
        wait for 100ns;
        code <= "0110";
        wait for 100ns;
        code <= "0111";
        wait for 100ns;
        code <= "1000";
        wait for 100ns;
        code <= "1001";
        wait for 100ns;
        code <= "1010";
        wait for 100ns;
        code <= "1011";
        wait for 100ns;
        code <= "1100";
        wait for 100ns;
        code <= "1101";
        wait for 100ns;
        code <= "1110";
        wait for 100ns;
        code <= "1111";
        wait for 100ns;
        code <= "XXXX";
        wait for 100ns;
    end process;
end Behavioral;
