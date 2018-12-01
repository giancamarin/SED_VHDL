---------------------------------------------------------------------------------- 
-- Engineer: Giancarlo Marín Hernández
-- 
-- Create Date: 12/01/2018 06:35:21 PM
-- Design Name: Contador_HEX
-- Module Name: bcd7seg - Behavioral
-- Project Name: Contador_HEX
-- Target Devices: NEXYS4 DDR
-- Description: Codigo que describe el decodificador de bcd a 7 segmentos 
-- 
-- Dependencies: 
-- 
-- Revision: 01
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd7seg is
    Port ( 
        code : in std_logic_vector (3 downto 0);
        led : out std_logic_vector (6 downto 0)
        );
end bcd7seg;

architecture Behavioral of bcd7seg is

begin
    process(code)
    begin
        case code is
            when "0000" => 
                led <= "0000001"; -- digito 0
            when "0001" => 
                led <= "1001111"; -- digito 1 
            when "0010" => 
                led <= "0010010"; -- digito 2
            when "0011" => 
                led <= "0000110"; -- digito 3
            when "0100" => 
                led <= "1001100"; -- digito 4
            when "0101" => 
                led <= "0100100"; -- digito 5
            when "0110" => 
                led <= "0100000"; -- digito 6
            when "0111" => 
                led <= "0001111"; -- digito 7
            when "1000" => 
                led <= "0000000"; -- digito 8
            when "1001" => 
                led <= "0000100"; -- digito 9
            when "1010" => 
                led <= "0001000"; -- digito A
            when "1011" => 
                led <= "1100000"; -- digito B
            when "1100" => 
                led <= "0110001"; -- digito C
            when "1101" => 
                led <= "1000010"; -- digito D
            when "1110" => 
                led <= "0110000"; -- digito E
            when "1111" => 
                led <= "0111000"; -- digito F
            when others =>
                led <= "1111111"; -- digito nulo
        end case;
    end process;
end Behavioral;
