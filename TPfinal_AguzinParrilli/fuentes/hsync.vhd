entity hsync is
port(
	clkhsync: in bit;
	bits_contador_hsync: bit_vector(0 to 9);
	salidahsync: out bit);
end;

architecture test of hsync is
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

	hsyncup: compxigual port map(a=>bits_contador_hsync, b=>"1010001111",s=>salida_syncup);
	
	hsyncdown: compxigual port map(a=>bits_contador_hsync, b=>"1011100111",s=>salida_syncdown);
	
	ffdhsync: ffd port map(clki=>clkhsync,rsti=>salida_syncdown,enai=>salida_syncup,di=>'1',qo=>salidahsync);
end;
