library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity AdderOrganised is
    Port ( 
        reset         : in std_logic;
        clk           : in std_logic;
        A_num             : in std_logic_vector(31 downto 0);
        B_num             : in std_logic_vector(31 downto 0);
        DisplayResult : out std_logic_vector(31 downto 0)
        
    );
end AdderOrganised;

architecture Behavioral of AdderOrganised is

    component NormalCaseHandler is
    port(
        A           : in  std_logic_vector(31 downto 0);
        B           : in  std_logic_vector(31 downto 0);
        clk         : in  std_logic;
        reset       : in  std_logic;
        enable      : in  std_logic;
        sum         : out std_logic_vector(31 downto 0);
        ovf         : out std_logic
    );
    end component;

    component SpecialCaseHandler is
        port(
            clk           : in std_logic;
            nr1           : in std_logic_vector(31 downto 0);
            nr2           : in std_logic_vector(31 downto 0);
            SpecialCase   : out std_logic;
            DisplayResult : out std_logic_vector(31 downto 0)
        );
    end component;

    signal sc              : std_logic := '0';
    signal enable          : std_logic := '1';
    signal sum1, sum2      : std_logic_vector(31 downto 0);
    signal done            : std_logic;
    signal ovf             : std_logic;
    signal state_debug     : std_logic_vector(2 downto 0);

begin

    Label1: SpecialCaseHandler
        port map (
            clk           => clk,
            nr1           => A_num,
            nr2           => B_num,
            SpecialCase   => sc,
            DisplayResult => sum1
        );


    Label2: NormalCaseHandler
        port map (
            A            => A_num,   
            B            => B_num,
            clk          => clk,
            enable       => enable,
            reset        => reset,
            sum          => sum2,
            ovf          => ovf
        );
       
        

process(sc,sum1,sum2)
begin
    if (sc = '0') then
        DisplayResult <= sum2; -- Prioritizeaz? cazurile speciale (INF, NaN, etc.)
    else 
        DisplayResult <= sum1; -- Caz normal
        sc <= '0';
    end if;
end process;

end Behavioral;