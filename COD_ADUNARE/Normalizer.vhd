library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Normalizer is
    port(
        in_mantissa : in  std_logic_vector(24 downto 0);
        in_exp      : in  std_logic_vector(8 downto 0);
        norm_mantissa : out std_logic_vector(24 downto 0);
        norm_exp      : out std_logic_vector(8 downto 0);
        ovf           : out std_logic
    );
end Normalizer;

architecture Behavioral of Normalizer is
begin
    process(in_mantissa, in_exp)
    begin
        if in_mantissa(24) = '1' then
            norm_mantissa <= '0' & in_mantissa(24 downto 1);
            norm_exp <= std_logic_vector(unsigned(in_exp) + 1);
            ovf <= '1';
        elsif in_mantissa(23) = '0' then
            norm_mantissa <= in_mantissa(23 downto 0) & '0';
            norm_exp <= std_logic_vector(unsigned(in_exp) - 1);
            ovf <= '0';
        else
            norm_mantissa <= in_mantissa;
            norm_exp <= in_exp;
            ovf <= '0';
        end if;
    end process;
end Behavioral;
