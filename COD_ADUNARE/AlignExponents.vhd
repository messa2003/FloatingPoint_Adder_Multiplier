library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity AlignExponents is
    port(
        A_exp            : in  std_logic_vector(8 downto 0);
        B_exp            : in  std_logic_vector(8 downto 0);
        A_mantissa       : in  std_logic_vector(24 downto 0);
        B_mantissa       : in  std_logic_vector(24 downto 0);
        aligned_mantissa : out std_logic_vector(24 downto 0);
        state            : inout std_logic_vector(2 downto 0)
    );
end AlignExponents;

architecture Behavioral of AlignExponents is
begin
    process(A_exp, B_exp, A_mantissa, B_mantissa)
        variable diff : signed(8 downto 0);
    begin
        if unsigned(A_exp) > unsigned(B_exp) then
            diff := signed(A_exp) - signed(B_exp);
            aligned_mantissa <= B_mantissa srl to_integer(diff);
        elsif unsigned(A_exp) < unsigned(B_exp) then
            diff := signed(B_exp) - signed(A_exp);
            aligned_mantissa <= A_mantissa srl to_integer(diff);
        else
            aligned_mantissa <= A_mantissa; -- Exponen?ii sunt egali
        end if;
    end process;
end Behavioral;
