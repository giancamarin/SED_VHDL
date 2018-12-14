library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity clk_divider1000 is
    Port (
        Clk: in  STD_LOGIC;
        Reset  : in  STD_LOGIC;
        Clk_out1000 : out STD_LOGIC
    );
end clk_divider1000;
 
architecture Behavioral of clk_divider1000 is
    signal temporal: STD_LOGIC;
    signal contador: integer range 0 to 49999 := 0;
begin
    divisor_frecuencia: process (Clk, Reset) begin
        if (Reset = '1') then
            temporal <= '0';
            contador <= 0;
        elsif rising_edge(Clk) then
            if (contador = 49999) then
                temporal <= NOT(temporal);
                contador <= 0;
            else
                contador <= contador+1;
            end if;
        end if;
    end process;
     
    Clk_out1000 <= temporal;
end Behavioral;