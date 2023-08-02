entity vsync is
port(
	clkvsync: in bit;
	bits_contador_vsync: bit_vector(0 to 9);
	salidavsync: out bit);
end;

architecture test of vsync is
	--DECLARACION DE COMPONENETES--
	component compxigual
		port(
			a: in bit_vector (0 to 9);
			b: in bit_vector (0 to 9);
			s: out bit);
		end component;
	------------------------------
	component ffd
		port (
			clki: in bit;
			rsti: in bit;
			enai: in bit;
			di: in bit;
			qo: out bit);
		end component;
	------------------------------
	--DECLARACION DE SEÑALES------
signal salida_syncup, salida_syncdown: bit; 

begin

	vsyncup: compxigual port map(a=>bits_contador_vsync, b=>"0111101010",s=>salida_syncup);
	
	vsyncdown: compxigual port map(a=>bits_contador_vsync, b=>"0111101100",s=>salida_syncdown);
	
	ffdvsync: ffd port map(clki=>clkvsync,rsti=>salida_syncdown,enai=>salida_syncup,di=>'1',qo=>salidavsync);
end;
