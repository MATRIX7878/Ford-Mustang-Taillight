LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY sig IS
    PORT(L, R, H, clk : IN STD_LOGIC;
         LC, LB, LA, RA, RB, RC : OUT STD_LOGIC);
END sig;

ARCHITECTURE behavior OF sig IS
    TYPE state IS (S0, S1, S2, S3, S4, S5, S6, S7);
    SIGNAL currentState, nextState : state;

BEGIN
    PROCESS (currentState, L, R, H)
        VARIABLE INPUTS : STD_LOGIC_VECTOR (2 DOWNTO 0);
        BEGIN
            INPUTS := L&R&H;
            CASE currentState IS
                WHEN S0 => IF (INPUTS = "000") THEN
                    nextState <= S0;
                ELSIF (INPUTS = "100") THEN
                    nextState <= S1;
                ELSIF (INPUTS = "010") THEN
                    nextState <= S4;
                ELSE
                    nextState <= S7;
                END IF;

                WHEN S1 => IF (INPUTS(0) = '1') THEN
                    nextState <= S7;
                ELSIF (INPUTS = "100") THEN
                    nextState <= S2;
                ELSE
                    nextState <= S0;
                END IF;

                WHEN S2 => IF (INPUTS(0) = '1') THEN
                    nextState <= S7;
                ELSIF (INPUTS = "100") THEN
                    nextState <= S3;
                ELSE
                    nextState <= S0;
                END IF;

                WHEN S3|S6 => IF (INPUTS(0) = '1') THEN
                    nextState <= S7;
                ELSE
                    nextState <= S0;
                END IF;

                WHEN S4 => IF (INPUTS(0) = '1') THEN
                    nextState <= S7;
                ELSIF (INPUTS = "010") THEN
                    nextState <= S5;
                ELSE
                    nextState <= S0;
                END IF;

                WHEN S5 => IF (INPUTS(0) = '1') THEN
                    nextState <= S7;
                ELSIF (INPUTS = "010") THEN
                    nextState <= S6;
                ELSE
                    nextState <= S0;
                END IF;

                WHEN S7 => nextState <= S0;

            END CASE;
    END PROCESS;

    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            currentState <= nextState;
        END IF;
    END PROCESS;

    PROCESS (currentState)
    BEGIN
        LC <= '1'; LB <= '1'; LA <= '1'; RA <= '1'; RB <= '1'; RC <= '1';

        CASE currentState IS
            WHEN S0 => NULL;
            WHEN S1 => LA <= '0';
            WHEN S2 => LA <= '0'; LB <= '0';
            WHEN S3 => LA <= '0'; LB <= '0'; LC <= '0';
            WHEN S4 => RA <= '0';
            WHEN S5 => RA <= '0'; RB <= '0';
            WHEN S6 => RA <= '0'; RB <= '0'; RC <= '0';
            WHEN S7 => LA <= '0'; LB <= '0'; LC <= '0'; RA <= '0'; RB <= '0'; RC <= '0';
        END CASE;
    END PROCESS;
END behavior;