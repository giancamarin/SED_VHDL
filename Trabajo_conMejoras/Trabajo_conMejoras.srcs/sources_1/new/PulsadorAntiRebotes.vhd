----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2018 10:47:00
-- Design Name: 
-- Module Name: PulsadorAntiRebotes - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity PulsadorAntiRebotes is
    port (
        clk	: in std_logic;
	boton_in	: in std_logic;
	boton_out	: out std_logic;
	counter : out std_logic_vector(3 downto 0)
	);
	
end PulsadorAntiRebotes;

architecture behavioral of PulsadorAntiRebotes is
    constant CNT_SIZE : integer := 3;
    signal boton_prev   : std_logic := '0';
    signal counter_i    : std_logic_vector(CNT_SIZE downto 0) := (others => '0');

begin
    process(clk)
    begin
	if (clk'event and clk='1') then
		if (boton_prev xor boton_in) = '1' then
			counter_i <= (others => '0');
			boton_prev <= boton_in;
		elsif (counter_i < "1010") then
			counter_i <= counter_i + 1;
        else
			boton_out <= boton_prev;
		end if;
	end if;
	
    end process;
    counter<=counter_i;
end behavioral;