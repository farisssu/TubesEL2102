-- UART Receiver
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_RX is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           rx : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(7 downto 0);
           received : out STD_LOGIC);
end UART_RX;

architecture Behavioral of UART_RX is
    signal bit_count : integer := 0;
    signal baud_counter : integer := 0;
    signal rx_data : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal rx_bit : STD_LOGIC := '1';
    signal busy : STD_LOGIC := '0';

    constant baud_rate : integer := 9600;  -- Set baud rate

begin
    process(clk, reset)
    begin
        if reset = '1' then
            bit_count <= 0;
            baud_counter <= 0;
            rx_data <= "00000000";
            busy <= '0';
            received <= '0';
        elsif rising_edge(clk) then
            -- Baud rate generator
            if baud_counter = (50000000 / baud_rate) then  -- assuming clk is 50MHz
                baud_counter <= 0;

                if rx = '0' then  -- Start bit detection
                    busy <= '1';
                    bit_count <= 0;
                elsif busy = '1' then
                    rx_data(bit_count) <= rx;
                    bit_count <= bit_count + 1;

                    if bit_count = 7 then
                        busy <= '0';
                        received <= '1';  -- Data received
                        data_out <= rx_data;
                    end if;
                end if;
            else
                baud_counter <= baud_counter + 1;
            end if;
        end if;
    end process;
end Behavioral;
