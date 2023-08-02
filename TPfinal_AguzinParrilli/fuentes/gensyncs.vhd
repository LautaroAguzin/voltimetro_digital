entity gensyncs is
	port(
	clksync: in bit;
	pixel_y_syncs, pixel_x_syncs: out bit_vector(0 to 9);
	h_sync,v_sync: out bit;
	pixy_vidon: out bit;
	vid_on: out bit:='1'
		
	);
end;
architecture test of gensyncs is

	--DECLARACION DE COMPONENTES-----------------
	component contV 
		port(
			clkcontv: in bit;
			rstcontv: in bit;
			encontv: in bit;
			pixel_y_contv: out bit_vector (0 to 9));
	end component;
	---------------------------------------------
	component contH
		port(
			clkconth: in bit;
			rstconth: in bit;
			enconth: in bit;
			pixel_x_conth: out bit_vector (0 to 9);
			flag_rst: out bit);
	end component;
	---------------------------------------------
	component vidon
		port(
			clkh_vidon: in bit;
			clkv_vidon: in bit;
			pixel_y_vidon: in bit_vector (0 to 9);
			pixel_x_vidon: in bit_vector (0 to 9);
			salida_vidon: out bit:='1';
			v_vidon: out bit);
	end component;
	---------------------------------------------
	component vsync
		port(
			clkvsync: in bit;
			bits_contador_vsync: bit_vector(0 to 9);
			salidavsync: out bit);
	end component;
	---------------------------------------------
	component hsync
		port(
			clkhsync: in bit;
			bits_contador_hsync: bit_vector(0 to 9);
			salidahsync: out bit);
	end component;
	---------------------------------------------
	---DECLARACION DE SEÑALES--------------------
	signal pixel_y_aux, pixel_x_aux: bit_vector (0 to 9);
	signal flag_rst_aux: bit;

begin

cv: contV port map(clkcontv=>clksync, rstcontv=>'0', encontv=>flag_rst_aux, pixel_y_contv=>pixel_y_aux);

ch: contH port map(clkconth=>clksync, rstconth=>'0', enconth=>'1', pixel_x_conth=>pixel_x_aux, flag_rst=>flag_rst_aux);

video_on: vidon port map(clkh_vidon=>clksync, clkv_vidon=>clksync, pixel_y_vidon=>pixel_y_aux, pixel_x_vidon=> pixel_x_aux, salida_vidon=> vid_on,v_vidon=>pixy_vidon);

syncver: vsync port map(clkvsync=>clksync, bits_contador_vsync=>pixel_y_aux, salidavsync=>v_sync);

synchor: hsync port map(clkhsync=>clksync, bits_contador_hsync=>pixel_x_aux, salidahsync=>h_sync);


pixel_x_syncs <= pixel_x_aux;
pixel_y_syncs <= pixel_y_aux;
end;
