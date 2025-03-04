library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity M is
    Port (
        mantissa_x : in STD_LOGIC_VECTOR(23 downto 0);
        mantissa_y : in STD_LOGIC_VECTOR(23 downto 0);
        product : out STD_LOGIC_VECTOR(47 downto 0)
    );
end M;

architecture rtl of M is
begin
    process(mantissa_x, mantissa_y)
    begin
        product <= std_logic_vector(unsigned(mantissa_x) * unsigned(mantissa_y));
    end process;
end rtl;