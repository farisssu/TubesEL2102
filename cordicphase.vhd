library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cordicphase is
    Port ( clk : in STD_LOGIC;                  -- FPGA clock input
           reset : in STD_LOGIC;                -- Reset signal
           tx : out STD_LOGIC;                  -- UART TX output
           rx : in STD_LOGIC;                   -- UART RX input
           tx_data : in STD_LOGIC_VECTOR(7 downto 0);  -- Data to transmit
           rx_data : out STD_LOGIC_VECTOR(7 downto 0); -- Received data
           send : in STD_LOGIC;                    -- Signal to trigger transmission
           received : out STD_LOGIC);              -- Signal to indicate data received
end cordicphase;

architecture Behavioral of cordicphase is

    -- Signals for UART communication
    signal uart_tx_internal : STD_LOGIC;  -- Renamed internal signal for UART TX
    signal uart_rx_internal : STD_LOGIC;  -- Renamed internal signal for UART RX
    signal uart_send : STD_LOGIC;
    signal uart_received : STD_LOGIC;
    signal uart_tx_data : STD_LOGIC_VECTOR(7 downto 0);
    signal uart_rx_data : STD_LOGIC_VECTOR(7 downto 0);

    -- Instantiate the UART Transmitter
    component UART_TX is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               data_in : in STD_LOGIC_VECTOR(7 downto 0);
               tx : out STD_LOGIC;
               send : in STD_LOGIC);
    end component;

    -- Instantiate the UART Receiver
    component UART_RX is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               rx : in STD_LOGIC;
               data_out : out STD_LOGIC_VECTOR(7 downto 0);
               received : out STD_LOGIC);
    end component;

begin
    -- Instantiate UART Transmitter
    UART_TX_inst : UART_TX
        Port map (clk => clk, 
                  reset => reset, 
                  data_in => tx_data, 
                  tx => uart_tx_internal,  -- Use the renamed internal signal
                  send => send);

    -- Instantiate UART Receiver
    UART_RX_inst : UART_RX
        Port map (clk => clk, 
                  reset => reset, 
                  rx => rx, 
                  data_out => uart_rx_data,  -- Correct signal for rx_data
                  received => uart_received);

    -- Map the UART signals to top-level ports
    tx <= uart_tx_internal;    -- Send the UART TX data to the output port
    rx_data <= uart_rx_data;    -- Correctly map uart_rx_data to rx_data
    received <= uart_received;  -- Indicate that data is received

end Behavioral;

