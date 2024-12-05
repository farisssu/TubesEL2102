-- UART Transmitter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_TX is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR(7 downto 0);
           tx : out STD_LOGIC;
           send : in STD_LOGIC);
end UART_TX;

architecture Behavioral of UART_TX is
    signal bit_count : integer := 0;
    signal baud_counter : integer := 0;
    signal tx_data : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal tx_bit : STD_LOGIC := '1';  -- idle state for UART is '1'
    signal busy : STD_LOGIC := '0';

    constant baud_rate : integer := 9600;  -- Set baud rate

begin
    process(clk, reset)
    begin
        if reset = '1' then
            bit_count <= 0;
            baud_counter <= 0;
            tx_data <= "00000000";
            tx_bit <= '1';
            busy <= '0';
        elsif rising_edge(clk) then
            if send = '1' and busy = '0' then
                busy <= '1';
                tx_data <= data_in;
                bit_count <= 0;
                baud_counter <= 0;
            end if;

            -- Baud rate generator
            if baud_counter = (50000000 / baud_rate) then  -- assuming clk is 50MHz
                baud_counter <= 0;
                -- Transmitting logic
                if bit_count < 8 then
                    tx_bit <= tx_data(bit_count);
                    bit_count <= bit_count + 1;
                else
                    tx_bit <= '1';  -- Stop bit
                    busy <= '0';  -- Transmission complete
                end if;
            else
                baud_counter <= baud_counter + 1;
            end if;
        end if;
    end process;

    tx <= tx_bit;
end Behavioral;
