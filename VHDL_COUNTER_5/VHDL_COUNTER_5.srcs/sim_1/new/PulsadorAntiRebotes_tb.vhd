-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2018 10:56:26
-- Design Name: 
-- Module Name: PulsadorAntiRebotes_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PulsadorAntiRebotes_tb is
--  Port ( );
end PulsadorAntiRebotes_tb;

architecture Behavioral of PulsadorAntiRebotes_tb is
component PulsadorAntiRebotes
port(
        clk	: in std_logic;
        boton_in    : in std_logic;
        boton_out    : out std_logic;
        counter : out std_logic_vector(3 downto 0));
end component;    

signal clk : std_logic:='0';
signal boton_in: std_logic:='0';
signal boton_out:std_logic;
signal counter : std_logic_vector(3 downto 0);
constant clk_time: time:= 1 ms;

begin
uut: PulsadorAntiRebotes
    port map(
        clk=> clk,
        boton_in=> boton_in,
        boton_out=> boton_out,
        counter=>counter
        );
        
    clk<= not clk after clk_time;
   stimulate: process 
        begin
          wait for 10  ms;
          wait for clk_time*10;
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 2 ms; 
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 3 ms; 
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 4 ms; 
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 3 ms;  
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 40 ms;  
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 2 ms; 
          boton_in <= '0';
          wait for 1 ms; 
          boton_in <= '1';
          wait for 3 ms; 
          boton_in <= '0';
              wait;
    end process; 
end Behavioral;
