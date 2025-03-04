library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity NormalCaseHandler is
    port(
        A           : in  std_logic_vector(31 downto 0);
        B           : in  std_logic_vector(31 downto 0);
        clk         : in  std_logic;
        reset       : in  std_logic;
        enable      : in  std_logic;
        sum         : out std_logic_vector(31 downto 0);
        ovf         : out std_logic
    );
end NormalCaseHandler;

architecture Behavioral of NormalCaseHandler is
    -- Semnale intermediare
    signal A_exp, B_exp, final_exp         : std_logic_vector(8 downto 0);
    signal A_mantissa, B_mantissa          : std_logic_vector(24 downto 0);
    signal aligned_A, aligned_B            : std_logic_vector(24 downto 0);
    signal sum_mantissa, norm_mantissa     : std_logic_vector(24 downto 0);
    signal norm_exp                        : std_logic_vector(8 downto 0);
    signal overflow                        : std_logic;

    -- Instan?iere componente
    component Aligner
        port(
            A_exp      : in  std_logic_vector(8 downto 0);
            B_exp      : in  std_logic_vector(8 downto 0);
            A_mantissa : in  std_logic_vector(24 downto 0);
            B_mantissa : in  std_logic_vector(24 downto 0);
            aligned_A  : out std_logic_vector(24 downto 0);
            aligned_B  : out std_logic_vector(24 downto 0);
            final_exp  : out std_logic_vector(8 downto 0)
        );
    end component;

    component Adder
        port(
            A_mantissa : in  std_logic_vector(24 downto 0);
            B_mantissa : in  std_logic_vector(24 downto 0);
            sum_mantissa : out std_logic_vector(24 downto 0)
        );
    end component;

    component Normalizer
        port(
            in_mantissa : in  std_logic_vector(24 downto 0);
            in_exp      : in  std_logic_vector(8 downto 0);
            norm_mantissa : out std_logic_vector(24 downto 0);
            norm_exp      : out std_logic_vector(8 downto 0);
            ovf           : out std_logic
        );
    end component;

begin
    -- Extragerea câmpurilor din A ?i B
    A_exp <= "0" & A(30 downto 23);
    B_exp <= "0" & B(30 downto 23);
    A_mantissa <= "01" & A(22 downto 0);
    B_mantissa <= "01" & B(22 downto 0);

    -- Aliniere
    align_inst : Aligner
        port map(
            A_exp => A_exp,
            B_exp => B_exp,
            A_mantissa => A_mantissa,
            B_mantissa => B_mantissa,
            aligned_A => aligned_A,
            aligned_B => aligned_B,
            final_exp => final_exp
        );

    -- Adunare
    adder_inst : Adder
        port map(
            A_mantissa => aligned_A,
            B_mantissa => aligned_B,
            sum_mantissa => sum_mantissa
        );

    -- Normalizare
    normalizer_inst : Normalizer
        port map(
            in_mantissa => sum_mantissa,
            in_exp => final_exp,
            norm_mantissa => norm_mantissa,
            norm_exp => norm_exp,
            ovf => overflow
        );

    -- Combinarea rezultatului
    sum(31) <= '0'; -- Rezultatul final este pozitiv
    sum(30 downto 23) <= norm_exp(7 downto 0);
    sum(22 downto 0) <= norm_mantissa(22 downto 0);
    ovf <= overflow;

end Behavioral;
