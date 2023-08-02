

entity compxigual is
	port(
	a: in bit_vector (9 downto 0);
	b: in bit_vector (9 downto 0);
	s: out bit
	);
end;

architecture test of compxigual is

signal salidas_xnor: bit_vector (9 downto 0);


begin

salidas_xnor <= a xnor b; 
s <= salidas_xnor(0) and salidas_xnor(1) and salidas_xnor(2) and salidas_xnor(3) and salidas_xnor(4) and salidas_xnor(5) and salidas_xnor(6) and salidas_xnor(7) and salidas_xnor(8) and salidas_xnor(9);


end;