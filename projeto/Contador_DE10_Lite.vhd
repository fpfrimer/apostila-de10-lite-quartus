library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Contador_DE10_Lite is
    port (
        MAX10_CLK1_50 : in  std_logic;
        KEY           : in  std_logic_vector(1 downto 0);
        SW            : in  std_logic_vector(9 downto 0);
        LEDR          : out std_logic_vector(9 downto 0);
        HEX0          : out std_logic_vector(7 downto 0);
        HEX1          : out std_logic_vector(7 downto 0)
    );
end entity Contador_DE10_Lite;

architecture rtl of Contador_DE10_Lite is
    constant DIVISOR_1HZ : natural := 50000000;

    signal div_count : natural range 0 to DIVISOR_1HZ - 1 := 0;
    signal tick_1hz  : std_logic := '0';
    signal unidade   : unsigned(3 downto 0) := (others => '0');
    signal dezena    : unsigned(3 downto 0) := (others => '0');

    function seg7(bcd : unsigned(3 downto 0)) return std_logic_vector is
    begin
        case bcd is
            when "0000" => return "11000000"; -- 0
            when "0001" => return "11111001"; -- 1
            when "0010" => return "10100100"; -- 2
            when "0011" => return "10110000"; -- 3
            when "0100" => return "10011001"; -- 4
            when "0101" => return "10010010"; -- 5
            when "0110" => return "10000010"; -- 6
            when "0111" => return "11111000"; -- 7
            when "1000" => return "10000000"; -- 8
            when "1001" => return "10010000"; -- 9
            when others => return "11111111"; -- apagado
        end case;
    end function;
begin
    LEDR <= SW;

    process (MAX10_CLK1_50)
    begin
        if rising_edge(MAX10_CLK1_50) then
            if div_count = DIVISOR_1HZ - 1 then
                div_count <= 0;
                tick_1hz  <= '1';
            else
                div_count <= div_count + 1;
                tick_1hz  <= '0';
            end if;
        end if;
    end process;

    process (MAX10_CLK1_50)
        variable carga_unidade : unsigned(3 downto 0);
        variable carga_dezena  : unsigned(3 downto 0);
    begin
        if rising_edge(MAX10_CLK1_50) then
            carga_unidade := unsigned(SW(3 downto 0));
            carga_dezena  := unsigned(SW(7 downto 4));

            if KEY(0) = '0' then
                unidade <= (others => '0');
                dezena  <= (others => '0');
            elsif KEY(1) = '0' then
                if carga_unidade <= to_unsigned(9, 4) and
                   carga_dezena <= to_unsigned(9, 4) then
                    unidade <= carga_unidade;
                    dezena  <= carga_dezena;
                else
                    unidade <= (others => '0');
                    dezena  <= (others => '0');
                end if;
            elsif tick_1hz = '1' then
                if unidade = to_unsigned(9, 4) then
                    unidade <= (others => '0');

                    if dezena = to_unsigned(9, 4) then
                        dezena <= (others => '0');
                    else
                        dezena <= dezena + 1;
                    end if;
                else
                    unidade <= unidade + 1;
                end if;
            end if;
        end if;
    end process;

    HEX0 <= seg7(unidade);
    HEX1 <= seg7(dezena);
end architecture rtl;
