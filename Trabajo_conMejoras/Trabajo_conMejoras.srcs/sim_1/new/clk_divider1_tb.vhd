LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY clkdivider1_tb IS
END clkdivider1_tb;
 
ARCHITECTURE behavior OF clkdivider1_tb IS
    COMPONENT clkdivider1
    Port (
        Clk: in  STD_LOGIC;
        Reset  : in  STD_LOGIC;
        Clk_out1 : out STD_LOGIC
    );
    END COMPONENT;
 
    -- Entradas
    signal Clk : std_logic := '0';
    signal Reset   : std_logic := '0';
    -- Salidas
    signal Clk_out1  : std_logic;
    constant entrada_t : time := 20 ns; 
BEGIN
    -- Instancia de la unidad bajo prueba.
    uut: clkdivider1 PORT MAP (
        Clk => Clk,
        Reset   => Reset,
        Clk_out1  => Clk_out1
    );
 
    -- Definición del reloj.
    entrada_process :process
        begin
        Clk <= '0';
        wait for entrada_t / 2;
        Clk <= '1';
        wait for entrada_t / 2;
    end process;
 
   
    estimulos: process
    begin
        Reset <= '1'; -- Condiciones iniciales.
        wait for 100 ns;
        Reset <= '0'; 
        wait;
    end process;
END;