library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Divider_17bit_16 is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        start   : in  STD_LOGIC;
        dividend: in  STD_LOGIC_VECTOR(16 downto 0); -- 17-bit input
        quotient : out STD_LOGIC_VECTOR(15 downto 0); -- 16-bit output
        done    : out STD_LOGIC
    );
end Divider_17bit_16;

architecture Behavioral of Divider_17bit_16 is
    signal internal_quotient : STD_LOGIC_VECTOR(15 downto 0);
    signal internal_done      : STD_LOGIC;
    signal count             : INTEGER := 0;
begin

process(clk, reset)
begin
    if reset = '1' then
        internal_quotient <= (others => '0');
        internal_done <= '0';
        count <= 0;
    elsif rising_edge(clk) then
        if start = '1' then
            if count < 17 then
                internal_quotient(count) <= dividend(count) / "0000000000000001"; -- Membagi dengan 1
                count <= count + 1;
            else
                internal_done <= '1';
                count <= 0; -- Reset count setelah selesai
            end if;
        end if;
    end if;
end process;

quotient <= internal_quotient;
done <= internal_done;

end Behavioral;