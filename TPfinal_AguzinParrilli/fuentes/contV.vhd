entity contV is
port(
	clkcontv: in bit;
	rstcontv: in bit;
	encontv: in bit;
	pixel_y_contv: out bit_vector (0 to 9));
end;

architecture test of contV is
	---------------------------------------------
	component cont10b
		port(
			clkc: in bit;
			rstc: in bit;
			enac: in bit;
			qoc: out bit_vector(0 to 9));
	end component;
	--------------------------------------------
	component compxigual
		port(
			a: in bit_vector (9 downto 0);
			b: in bit_vector (9 downto 0);
			s: out bit);
	end component;
	---------------------------------------------
	
	signal bits_contador: bit_vector(0 to 9);
	signal rst_aux, rstcont: bit;
begin
	contver: cont10b port map(clkc=>clkcontv, rstc=>rstcont, enac=>encontv,qoc=>bits_contador);

	comprstv: compxigual port map(a=>bits_contador,b=>"1000001101", s=> rst_aux); --525
	
	rstcont<= rst_aux or rstcontv;

	pixel_y_contv <= bits_contador;
	
end;
