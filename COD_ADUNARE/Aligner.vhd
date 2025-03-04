library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Aligner is
    port(
        A_exp      : in  std_logic_vector(8 downto 0);
        B_exp      : in  std_logic_vector(8 downto 0);
        A_mantissa : in  std_logic_vector(24 downto 0);
        B_mantissa : in  std_logic_vector(24 downto 0);
        aligned_A  : out std_logic_vector(24 downto 0);
        aligned_B  : out std_logic_vector(24 downto 0);
        final_exp  : out std_logic_vector(8 downto 0)
    );
end Aligner;

architecture Behavioral of Aligner is
begin
    process(A_exp, B_exp, A_mantissa, B_mantissa)
        variable diff : signed(8 downto 0);
    begin
        if unsigned(A_exp) > unsigned(B_exp) then
            diff := signed(A_exp) - signed(B_exp);
            aligned_A <= A_mantissa;
            aligned_B <= std_logic_vector(shift_right(unsigned(B_mantissa), to_integer(diff)));
            final_exp <= A_exp;
        elsif unsigned(A_exp) < unsigned(B_exp) then
            diff := signed(B_exp) - signed(A_exp);
            aligned_A <= std_logic_vector(shift_right(unsigned(A_mantissa), to_integer(diff)));
            aligned_B <= B_mantissa;
            final_exp <= B_exp;
        else
            aligned_A <= A_mantissa;
            aligned_B <= B_mantissa;
            final_exp <= A_exp;
        end if;
    end process;
end Behavioral;
