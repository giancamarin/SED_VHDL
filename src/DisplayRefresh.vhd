----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2018 18:31:39
-- Design Name: 
-- Module Name: DisplayRefresh - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DisplayRefresh is
    Port (
    clk: in std_logic;
    segment_unid: in std_logic_vector(6 downto 0);
    segment_dec: in std_logic_vector(6 downto 0);
    segment_cent: in std_logic_vector(6 downto 0);
    segment_mil: in std_logic_vector(6 downto 0);
    display_number: out std_logic_vector(6 downto 0);
    display_selection: out std_logic_vector(7 downto 0)
     );
end DisplayRefresh;

architecture Behavioral of DisplayRefresh is

    signal estado_refresco: std_logic_vector(2 downto 0):="000";
    signal display_sel: std_logic_vector(7 downto 0);
    signal display_num: std_logic_vector(6 downto 0);
begin

    process(clk)
        subtype cont is integer range 0 to 4;
        variable contador: cont:=0;
        
    begin
        if clk'event and clk='1' then
         contador:=contador+1;   
                if contador > 3 then
                 estado_refresco <= std_logic_vector(unsigned(estado_refresco) + 1)  ;
                 contador:=0;
                  end if; 
                  
                     case estado_refresco is
                    when "000"=>
                       display_sel<="11111110";
                       display_number<=segment_unid; 
                    when "001"=>
                        display_sel<="11111101";
                        display_number<=segment_dec; 
                    when "010"=>
                        display_sel<="11111011";
                        display_number<=segment_cent;
                    when "011"=>
                        display_sel<="11110111";
                        display_number<=segment_mil;
                    when "100"=>
                        display_sel<="11101111";
                        display_number<="1111111"; 
                    when "101"=>
                        display_sel<="11011111";
                        display_number<="1111111"; 
                    when "110"=>
                        display_sel<="10111111";
                        display_number<="1111111";
                    when "111"=>
                        display_sel<="01111111";
                        display_number<="1111111";
                                        
               end case;
             
   
       
       
     end if;      
    end process;
    
    
    display_selection<=display_sel;
   
end Behavioral;
