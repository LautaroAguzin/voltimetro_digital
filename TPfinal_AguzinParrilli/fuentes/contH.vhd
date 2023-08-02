entity contH is
port(
	clkconth: in bit;
	rstconth: in bit;
	enconth: in bit;
	pixel_x_conth: out bit_vector (0 to 9);
	flag_rst: out bit
);
end;

architecture test of contH is
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
	signal flag_rst_aux, rstcont: bit;
begin
	conthor: cont10b port map(clkc=>clkconth, rstc=>rstcont, enac=>enconth,qoc=>bits_contador);

	comprsth: compxigual port map(a=>bits_contador,b=>"1100011111", s=> flag_rst_aux); --799
	
	rstcont <= rstconth or flag_rst_aux;

	pixel_x_conth <= bits_contador;
	flag_rst<=flag_rst_aux;
end;
