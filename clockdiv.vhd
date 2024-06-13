LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY clockdiv IS
    PORT(iclk, clr : IN STD_LOGIC;
         oclk : OUT STD_LOGIC);
END clockdiv;

ARCHITECTURE behavior OF clockdiv IS
    SIGNAL Count : INTEGER RANGE 0 TO 13499999;
    SIGNAL clkstate : STD_LOGIC;

BEGIN
    PROCESS (iclk, clr)
    BEGIN
        IF clr = '1' THEN
            Count <= 0;
            clkstate <= '0';
        ELSIF (rising_edge(iclk)) THEN
            IF Count = 13499999 THEN
                Count <= 0;
                clkstate <= NOT clkstate;
            ELSE
                Count <= Count + 1;
            END IF;
        END IF;
    END PROCESS;
    oclk <= clkstate;
END behavior;