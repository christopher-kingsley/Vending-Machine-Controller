library ieee;
use ieee.std_logic_1164.all;
entity part2 is
port(RESET, CLK, quarter, nickel, dime, gumin, candyin, sodain, refund: in std_logic;
		notenough, candyout1, gumout1, sodaout1, CLK_IND,NB: out std_logic;
		Total: out std_logic_vector(2 downto 0);
		D1, D2, D3: out std_logic_vector(6 downto 0));
end entity;

architecture beh of part2 is
signal CLOCK : std_logic;
signal RA_sig: std_logic_vector(1 downto 0);
signal Total_sig: std_logic_vector(2 downto 0);

component clockdivider is
	port(
		clk : in std_logic;
		Clock : out std_logic
);
end component;

component fsm is
	port(clk, rst, n, d, q, gum, candy, soda, ref: in std_logic;
		T: out std_logic_vector(2 downto 0);
		ref_amount: out std_logic_vector(1 downto 0);
		ne, gumout, candyout, sodaout, nickel_back: out std_logic);
end component;

component Total_display is
	port(Total_in: in std_logic_vector(2 downto 0);
		H1, H2: out std_logic_vector(6 downto 0));
end component;

component Ref_display is
	port(R_amount: in std_logic_vector(1 downto 0);
		H3: out std_logic_vector(6 downto 0));
end component;

begin

process(CLOCK)
begin

	CLK_IND<=CLOCK;

end process;

	timing : clockdivider port map(clk => CLK, Clock => CLOCK);
	brain : fsm port map(
		T=>Total_sig,
		clk => CLOCK,
		rst => RESET,
		n => nickel,
		d => dime,
		q => quarter,
		gum => gumin,
		candy => candyin,
		soda => sodain,
		ref=> refund,
		ref_amount=>RA_sig,
		ne => notenough,
		gumout => gumout1,
		candyout => candyout1,
		sodaout => sodaout1,
		nickel_back=> NB
	);

	TOT: Total_display port map(Total_in=>Total_sig, H1=>D1, H2=>D2);
	Change: Ref_display port map(R_amount=>RA_sig, H3=>D3);
end beh;