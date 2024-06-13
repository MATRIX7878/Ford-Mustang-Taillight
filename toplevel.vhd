LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY toplevel IS
    PORT(L, R, H, clk, clr : IN STD_LOGIC;
         LC, LB, LA, RA, RB, RC : OUT STD_LOGIC);
END toplevel;

ARCHITECTURE behavior OF toplevel IS
    SIGNAL oclk : STD_LOGIC;

    COMPONENT sig IS
        PORT(L, R, H, clk : IN STD_LOGIC;
             LC, LB, LA, RA, RB, RC : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT clockdiv IS
        PORT(iclk, clr : IN STD_LOGIC;
             oclk : OUT STD_LOGIC);
    END COMPONENT;

    BEGIN
        a : sig PORT MAP (L, R, H, oclk, LC, LB, LA, RA, RB, RC);
        b : clockdiv PORT MAP (clk, clr, oclk);

END behavior;