library IEEE;
use IEEE.std_logic_1164.all;


entity Total_display is
	port(Total_in: in std_logic_vector(2 downto 0);
		H1, H2: out std_logic_vector(6 downto 0));
end entity;

architecture beh of Total_display is
begin
process(Total_in)
begin
	case Total_in is
		when "000" =>
			H1<="1000000"; --0
			H2<="1000000"; --0
		when "001" =>
			H1<="0010010"; --5
			H2<="1000000"; --0
		when "010" =>
			H1<="1000000"; --0
			H2<="1111001"; --1
		when "011" =>
			H1<="0010010"; --5
			H2<="1111001"; --1
		when "100" =>
			H1<="1000000"; --0
			H2<="0100100"; --2
		when "101" =>
			H1<="0010010"; --5
			H2<="0100100"; --2
		when "110" =>
			H1<="1000000"; --0
			H2<="0110000"; --3
		when others =>
			H1<="1000000"; --0
			H2<="1000000"; --0
	end case;
end process;
end architecture;
