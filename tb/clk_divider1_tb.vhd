LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY clkdivider1_tb IS
END clkdivider1_tb;
 
ARCHITECTURE behavior OF clkdivider1_tb IS
    COMPONENT clkdivider1
    Port (
        Clk: in  STD_LOGIC;
        Reset  : in  STD_LOGIC;
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
        entrada => Clk,
        reset   => reset,
        salida  => Clk_out1
    );
 
    -- Definición del reloj.
    entrada_process :process
        begin
        entrada <= '0';
        wait for entrada_t / 2;
        entrada <= '1';
        wait for entrada_t / 2;
    end process;
 
   
    estimulos: process
    begin
        reset <= '1'; -- Condiciones iniciales.
        wait for 100 ns;
        reset <= '0'; 
        wait;
    end process;
END;