----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2018 13:15:26
-- Design Name: 
-- Module Name: just_count_tb - Behavioral
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

entity just_counter_tb is
--  Port ( );
end just_counter_tb;

architecture Behavioral of just_counter_tb is
component just_counter 
    port(
            Clk: in std_logic;
            start: in std_logic;
            reset: in std_logic;
            display_number: out std_logic_vector(6 downto 0);
            display_selection: out std_logic_vector(3 downto 0)
         );
end component;

        signal clk_master: std_logic:='0';
        signal enable: std_logic;
        signal rst: std_logic:='1';
        signal display_num: std_logic_vector(6 downto 0);
        signal display_sel: std_logic_vector(3 downto 0);
        
        constant k: time:=0.001 ms;
        
begin       

utt: just_counter port map(
            Clk=>clk_master,
            start=> enable,
            reset=>rst,
            display_number=>display_num,
            display_selection=>display_sel 
); 

clk_master<= not clk_master after k;
rst<= '0' after 1500*k;
enable<= '1' after 1500*k;
        
end Behavioral;
