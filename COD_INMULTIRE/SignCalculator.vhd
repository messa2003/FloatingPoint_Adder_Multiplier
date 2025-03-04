library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SignCalculator is
    Port (
        sign_x : in STD_LOGIC;
        sign_y : in STD_LOGIC;
        sign_result : out STD_LOGIC
    );
end SignCalculator;

architecture rtl of SignCalculator is
begin
    process(sign_x, sign_y)
    begin
        sign_result <= sign_x xor sign_y;  -- Semnul rezultatului
    end process;
end rtl;
