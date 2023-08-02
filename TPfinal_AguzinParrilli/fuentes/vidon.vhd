entity vidon is 
port(
	clkh_vidon: in bit;
	clkv_vidon: in bit;
	pixel_y_vidon: in bit_vector (0 to 9);
	pixel_x_vidon: in bit_vector (0 to 9);
	salida_vidon: out bit:='1';
	v_vidon: out bit
);
end;

architecture test of vidon is
	-----------------------------------------------
	component compxigual
		port(
			a: in bit_vector (9 downto 0);
			b: in bit_vector (9 downto 0);
			s: out bit
			);
	end component;
	-----------------------------------------------
	component ffd
		port (
			clki: in bit;
			rsti: in bit;
			enai: in bit;
			di: in bit;
			qo: out bit
			);
	end component;
	-----------------------------------------------

signal flag_v_vidon_up, flag_v_vidon_down, flag_h_vidon_up, flag_h_vidon_down: bit;
signal salida_hvidon, salida_vvidon: bit;
signal flag_h_vidon_up1,flag_h_vidon_up2: bit;
signal flag_v_vidon_up1,flag_v_vidon_up2: bit;

begin
	flag_h_vidon_up <= flag_h_vidon_up1 or flag_h_vidon_up2; --hvidon se activa cuando esta en 0 o en 799
	flag_v_vidon_up <= flag_v_vidon_up1 or flag_v_vidon_up2; --hvidon se activa cuando esta en 0 o en 525
	-----------COMPORTAMIENTO DE HVIDON---------------------
	hvidonup1: compxigual port map (a=>pixel_x_vidon, b=>"0000000000", s=>flag_h_vidon_up1);
	hvidonup2: compxigual port map (a=>pixel_x_vidon, b=>"1100011111", s=>flag_h_vidon_up2); --799
	hvidondown: compxigual port map (a=>pixel_x_vidon, b=>"1010000000", s=>flag_h_vidon_down); --640

	ffdhvidon: ffd port map (clki=>clkh_vidon,rsti=>flag_h_vidon_down, enai=> flag_h_vidon_up, di=>'1', qo=>salida_hvidon);
	--------------------------------------------------------

	----------COMPORTAMIENTO DE VVIDON----------------------
	vvidonup1: compxigual port map (a=>pixel_y_vidon, b=>"0000000000", s=>flag_v_vidon_up1);
	vvidonup2: compxigual port map (a=>pixel_y_vidon, b=>"1000001101", s=>flag_v_vidon_up2); --525
	vvidondown: compxigual port map (a=>pixel_y_vidon, b=>"0111100001", s=>flag_v_vidon_down); --481

	ffdvvidon: ffd port map (clki=>clkv_vidon,rsti=>flag_v_vidon_down, enai=> flag_v_vidon_up, di=>'1', qo=>salida_vvidon);


	salida_vidon <= salida_hvidon and salida_vvidon;
	v_vidon<=salida_vvidon;
end;
