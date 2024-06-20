library IEEE;
use IEEE.std_logic_1164.all;

entity Ref_display is
	port(R_amount: in std_logic_vector(1 downto 0);
		H3: out std_logic_vector(6 downto 0));
end entity;

architecture beh of Ref_display is
begin

process(R_amount)
begin
	case R_amount is
		when "00" =>
			H3<="1111111";
		when "01" =>
			H3<="1111001";
		when "10" =>
			H3<="0100100";
		when "11" =>
			H3<="0110000";
	end case;
end process;
end architecture;