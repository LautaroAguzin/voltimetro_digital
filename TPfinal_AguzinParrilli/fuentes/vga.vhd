entity vga is
    port(
        clkvga: in bit;
        data_in_vga: in bit;
        hsyncvga, vsyncvga: out bit;
        r_vga,g_vga,b_vga: out bit;
        pixely_vidon: out bit;
        pixel_x_vga,pixel_y_vga: out bit_vector(0 to 9)
    );
end;

architecture test of vga is
    -------------------------------------
    component gensyncs is
        port(
	        clksync: in bit;
	        pixel_y_syncs, pixel_x_syncs: out bit_vector(0 to 9);
	        h_sync,v_sync: out bit;
	        pixy_vidon: out bit;
	        vid_on: out bit:='1'	
	    );
    end component;
    -------------------------------------
    component genpixels is
        port(
            r_i: in bit;
            g_i: in bit;
            b_i: in bit:='1';
            vidon_genp: in bit;
            pixel_y: in bit_vector(0 to 9);
            r_o,g_o,b_o: out bit
        );
    end component;
    -------------------------------------
    signal vidon_aux: bit;
    signal pixel_y_aux: bit_vector(0 to 9);
begin
    dutgs: gensyncs port map(
        clksync=>clkvga,
        pixel_y_syncs=>pixel_y_aux,
        pixel_x_syncs=>pixel_x_vga,
        h_sync=>hsyncvga,
        v_sync=>vsyncvga,
        pixy_vidon=>pixely_vidon,
        vid_on => vidon_aux);
        
pixel_y_vga<=pixel_y_aux;

    dutgp: genpixels port map(
        r_i=>data_in_vga,
        g_i=>data_in_vga,
        b_i=>'1',
        vidon_genp=>vidon_aux,
        pixel_y=>pixel_y_aux,
        r_o=>r_vga,
        g_o=>g_vga,
        b_o=>b_vga);
end;