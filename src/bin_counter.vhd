----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2018 14:35:44
-- Design Name: 
-- Module Name: bin_counter - Behavioral
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

entity bin_counter is
    generic( 
    width: positive := 4);
 Port ( 
    clk: in std_logic;
    reset: in std_logic;
    eneable: in std_logic;
    count: out std_logic_vector(width-1 downto 0);
    salida: out std_logic  
);
end bin_counter;

architecture Behavioral of bin_counter is

signal cuenta: std_logic_vector(count'range);
signal sal: std_logic;

begin
process(clk, reset, eneable)
    begin
    if reset='1' then
        cuenta<=(others=>'0');
        sal<='0';
    elsif clk='1' and clk'event and eneable='1' then
        cuenta <= std_logic_vector(unsigned(cuenta) + 1);
    end if;    
   if cuenta="1111" and eneable='1' then
            sal<='1';
        else 
            sal<='0';
      
    end if;    
    

end process;
salida<=sal;
count<=cuenta; 

end Behavioral;
