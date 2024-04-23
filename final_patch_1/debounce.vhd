-------------------------------------------------
--! @brief Button debouncer with edge detector
--! @version 1.0
--! @copyright (c) 2024 Tomas Fryza, MIT license
--!
--! This VHDL module implements a button debouncer using
--! a Finite State Machine (FSM) and an edge detector. The FSM
--! ensures stable button transitions and the edge detector
--! generates single-clock pulses for positive and negative
--! edges of the debounced signal.
--!
--! Developed using TerosHDL, Vivado 2023.2, and EDA Playground.
--! Tested on Nexys A7-50T board and xc7a50ticsg324-1L FPGA.
--!
--! Inspired by:
--!   * https://web.mit.edu/6.111/volume2/www/f2019/handouts/labs/lab2_19/index.html
-------------------------------------------------

library ieee;
    use ieee.std_logic_1164.all;

-------------------------------------------------

entity debounce is
    port (
        clk      : in    std_logic; --! Main clock
        rst      : in    std_logic; --! High-active synchronous reset
        en       : in    std_logic; --! Clock enable input
        bouncey  : in    std_logic; --! Bouncey button input
        clean    : out   std_logic; --! Debounced button output
        pos_edge : out   std_logic; --! Positive-edge (rising) impulse
        neg_edge : out   std_logic  --! Negative-edge (falling) impulse
    );
end entity debounce;

-------------------------------------------------

architecture behavioral of debounce is
    --! Define states for the FSM
    type   state_type is (RELEASED, PRE_PRESSED, PRESSED, PRE_RELEASED);
    signal state : state_type; --! FSM state

    --! Define number of periods for debounce counter
    constant DEB_COUNT : integer := 4;

    --! Define signals for debounce counter
    signal sig_count : integer range 0 to DEB_COUNT;

    -- Edge detector signals
    signal sig_clean : std_logic; --! Debounced signal
    --! Remember previous debounced signal value
    signal sig_delayed : std_logic;
begin

    --! Process implementing a finite state machine (FSM) for
    --! button debouncing. Handles transitions between different
    --! states based on clock signal and bouncey button input.
    --!
    --! **RELEASED**: The initial state when the button is not pressed.
    --!     It waits for the button signal to become active (high).
    --!
    --! **PRE_PRESSED**: Upon detecting an active button signal,
    --!     it starts counting a sequence of high values to confirm
    --!     the button press.
    --!
    --! **PRESSED**: Indicates that the button has been pressed and
    --!     stable for the debounce duration. It waits for the button
    --!     signal to become inactive (low).
    --!
    --! **PRE_RELEASED**: Upon detecting an inactive button signal,
    --!     it starts counting a sequence of low values to confirm
    --!     the button release.
    p_fsm : process (clk) is
    begin

        if rising_edge(clk) then
            -- Active-high reset
            if (rst = '1') then
                state <= RELEASED;
            -- Clock enable
            elsif (en = '1') then
                -- Define transitions between states
                case state is

                    when RELEASED =>
                        if (bouncey = '1') then
                            sig_count <= 0;
                            state     <= PRE_PRESSED;
                        end if;

                    when PRE_PRESSED =>
                        if (bouncey = '1') then
                            sig_count <= sig_count + 1;
                            if (sig_count = DEB_COUNT - 1) then
                                state <= PRESSED;
                            else
                                state <= PRE_PRESSED;
                            end if;
                        else
                            state <= RELEASED;
                        end if;

                    when PRESSED =>
                        if (bouncey = '0') then
                            sig_count <= 0;
                            state     <= PRE_RELEASED;
                        end if;

                    when PRE_RELEASED =>
                        if (bouncey = '0') then
                            sig_count <= sig_count + 1;
                            if (sig_count = DEB_COUNT - 1) then
                                state <= RELEASED;
                            else
                                state <= PRE_RELEASED;
                            end if;
                        else
                            sig_count <= 0;
                            state     <= PRESSED;
                        end if;

                    -- Prevent unhandled cases
                    when others =>
                        null;

                end case;

            end if;
        end if;

    end process p_fsm;

    -- Output debounced button value
    sig_clean <= '1' when state = PRESSED or state = PRE_RELEASED else
                 '0';
    -- Assign output debounced signal
    clean <= sig_clean;

    --! Remember the previous value of a signal and generates single
    --! clock pulses for positive and negative edges of the debounced
    --! signal.
    p_edge_detector : process (clk) is
    begin

        if rising_edge(clk) then
            if (rst = '1') then
                sig_delayed <= '0';
            else
                sig_delayed <= sig_clean;
            end if;
        end if;

    end process p_edge_detector;

    -- Assign output signals for edge detector
    pos_edge <= sig_clean and not(sig_delayed);
    neg_edge <= not(sig_clean) and sig_delayed;

end architecture behavioral;
