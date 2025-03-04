library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SpecialCasesChecker is
    Port (
        x : in STD_LOGIC_VECTOR(31 downto 0);
        y : in STD_LOGIC_VECTOR(31 downto 0);
        is_special_case : out STD_LOGIC; -- Semnal care se activeaza pt cazul special
        special_result : out STD_LOGIC_VECTOR(31 downto 0) -- Rezultatul cazului special
    );
end SpecialCasesChecker;

architecture rtl of SpecialCasesChecker is
    signal x_exponent, y_exponent : STD_LOGIC_VECTOR(7 downto 0);
    signal x_mantissa, y_mantissa : STD_LOGIC_VECTOR(22 downto 0);
    signal x_sign, y_sign : STD_LOGIC;
begin

    x_exponent <= x(30 downto 23);
    y_exponent <= y(30 downto 23);
    x_mantissa <= x(22 downto 0);
    y_mantissa <= y(22 downto 0);
    x_sign <= x(31);
    y_sign <= y(31);

    process(x_exponent, y_exponent, x_mantissa, y_mantissa, x_sign, y_sign)
    begin
        -- Initializare
        is_special_case <= '0';
        special_result <= (others => '0');

        -- Verificare NaN
        if (x_exponent = "11111111" and x_mantissa /= "00000000000000000000000") or
           (y_exponent = "11111111" and y_mantissa /= "00000000000000000000000") then
            is_special_case <= '1';
            special_result <= "01111111110000000000000000000000"; -- NaN

        -- Verificare infinit
        elsif x_exponent = "11111111" or y_exponent = "11111111" then
            is_special_case <= '1';
            if (x_exponent = "11111111" and y_exponent = "00000000" and y_mantissa = "00000000000000000000000") or
               (y_exponent = "11111111" and x_exponent = "00000000" and x_mantissa = "00000000000000000000000") then
                special_result <= "01111111110000000000000000000000"; -- NaN (infinity * 0)
            else
                special_result(31) <= x_sign xor y_sign; -- Semnul rezultatului
                special_result(30 downto 23) <= "11111111"; -- Infinit
                special_result(22 downto 0) <= (others => '0'); -- Mantisa zero
            end if;

        -- Verificare zero
        elsif (x_exponent = "00000000" and x_mantissa = "00000000000000000000000") or
              (y_exponent = "00000000" and y_mantissa = "00000000000000000000000") then
            is_special_case <= '1';
            special_result(31) <= x_sign xor y_sign; -- Semnul rezultatului
            special_result(30 downto 23) <= "00000000"; -- Exponent zero
            special_result(22 downto 0) <= (others => '0'); -- Mantisa zero
        end if;
    end process;
end rtl;