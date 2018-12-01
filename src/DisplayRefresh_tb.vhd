----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2018 17:32:45
-- Design Name: 
-- Module Name: DisplayRefresh_tb - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DisplayRefresh_tb is

end DisplayRefresh_tb;

architecture Behavioral of DisplayRefresh_tb is
component DisplayRefresh is
    port(
        clk: in std_logic;
        segment_unid: in std_logic_vector(6 downto 0);
        segment_dec: in std_logic_vector(6 downto 0);
        display_number: out std_logic_vector(6 downto 0);
        display_selection: out std_logic_vector(3 downto 0)
        );
end component;

    signal clk: std_logic:='0';
    signal segment_unid: std_logic_vector(6 downto 0):="0000000";
    signal segment_dec: std_logic_vector(6 downto 0):="0000000";
    signal display_number: std_logic_vector(6 downto 0);
    signal display_selection: std_logic_vector(3 downto 0);
    
    constant k: time := 1 ms;
    
begin
    utt: DisplayRefresh port map (
        clk=>clk,
        segment_unid=> segment_unid,
        segment_dec=>segment_dec,
        display_number=>display_number,
        display_selection=>display_selection
        );
        
    clk<=not clk after k;  
    segment_unid<=std_logic_vector(unsigned(segment_unid)+1) after 8*k;
    segment_dec<=std_logic_vector(unsigned(segment_dec)+1) after 64*k;
      


end Behavioral;
