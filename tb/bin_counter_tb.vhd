----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2018 14:55:30
-- Design Name: 
-- Module Name: bin_counter_tb - Behavioral
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

entity bin_counter_tb is
--  Port ( );
end bin_counter_tb;

architecture Behavioral of bin_counter_tb is
component bin_counter 
     
      
    port(
        clk: in std_logic;
        reset: in std_logic;
        enable: in std_logic;
        count: out std_logic_vector(3 downto 0);
        salida: out std_logic   
    );
end component;

signal clk: std_logic:='0';
signal enable: std_logic:='0';
signal reset: std_logic;
signal count: std_logic_vector(3 downto 0);
signal salida: std_logic;

begin
utt: bin_counter
    port map(
    clk=>clk,
    enable=>enable,
    reset=>reset,
    count=>count,
    salida=>salida
    );
    
    clk <= not clk after 1ms;
    enable<='1'after 8ms;
    process
        begin
        wait for 2ms;
        reset<='1';
        wait for 1.5ms;
        reset<='0';
        wait for 1000 ms;
    end process;
       
end Behavioral;
