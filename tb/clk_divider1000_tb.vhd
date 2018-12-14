LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY clkdivider1000_tb IS
END clkdivider1000_tb;
 
ARCHITECTURE behavior OF clkdivider1000_tb IS
    COMPONENT clkdivider1000
    PORT(
        Clk : IN  std_logic;
        Reset   : IN  std_logic;
        Clk_out1000  : OUT std_logic
    );
    END COMPONENT;
 
    -- Entradas
    signal Clk : std_logic := '0';
    signal Reset   : std_logic := '0';
    -- Salidas
    signal Clk_out1000  : std_logic;
    constant entrada_t : time := 20 ns; 
BEGIN
    -- Instancia de la unidad bajo prueba.
    uut: clkdivider1000 PORT MAP (
        Clk => Clk,
        Reset   => Reset,
        Clk_out1000  => Clk_out1000
    );
 
    -- Definición del reloj.
    entrada_process :process
        begin
        Clk <= '0';
        wait for entrada_t / 2;
        Clk <= '1';
        wait for entrada_t / 2;
    end process;
 
    -- Procesamiento de estímulos.
    estimulos: process
    begin
        Reset <= '1'; -- Condiciones iniciales.
        wait for 100 ns;
        Reset <= '0'; 
        wait;
    end process;
END;