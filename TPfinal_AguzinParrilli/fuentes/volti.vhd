entity volti is
    port(
        clkvolt: in bit;
        rstvolt: in bit;
        unos: in bit;
        hsvolt: out bit;
        vsvolt: out bit;
        redV:out bit;
        greenV: out bit;
        blueV: out bit
    );
end;
architecture test of volti is
    
            --DECLARACION DE COMPONENTES-----
            component cont_bin_330 is
            port(
                clk330: in bit;
                rst330: in bit;
                ena330: in bit:='1';
                out1, out2 : out bit);
            end component;
            component cont1s is
                port(
                    clk1s: in bit;
                    rst1s: in bit;
                    ena1s: in bit;
                    data_out0: out bit_vector(0 to 3);
                    data_out1: out bit_vector(0 to 3);
                    data_out4: out bit_vector(0 to 3);
                    data_out3: out bit_vector(0 to 3);
                    data_out2: out bit_vector(0 to 3));
            end component;
            component reg is
                port(
                    clkr: in bit;
                    rstr: in bit:= '0';
                    enar: in bit;
                    bcd0,bcd1,bcd2: in bit_vector(0 to 3);
                    a_0,a_1,a_2: out bit_vector(0 to 3));
            end component;
            component mux is
                port(
                    a0: in bit_vector(0 to 3); --codigo para el bit mas significativo
                    a1: in bit_vector(0 to 3); --codigo para el segundo bit mas significativo
                    a2: in bit_vector(0 to 3); --codigo para el bit menos significativo
                    a3: in bit_vector(0 to 3) := "1010"; -- codigo para el punto
                    a4: in bit_vector(0 to 3) := "1011"; --codigo para la V
                    a5: in bit_vector (0 to 3):= "1100"; -- codigo par el espacio
                    pixel_x: in bit_vector (0 to 9); --posicion horizontal en la pantalla
                    pixel_y: in bit_vector (0 to 9);
                    mux_out: out bit_vector (0 to 3));
            end component;
            component rom is
                port(
                    pixel_x: in bit_vector(0 to 9);
                    pixel_y: in bit_vector(0 to 9);
                    char_adress: in bit_vector(0 to 3);
                    rom_out: out bit);
            end component;
            component vga is
                port(
                    clkvga: in bit;
                    data_in_vga: in bit;
                    hsyncvga, vsyncvga: out bit;
                    r_vga,g_vga,b_vga: out bit;
                    pixely_vidon: out bit;
                    pixel_x_vga,pixel_y_vga: out bit_vector(0 to 9));
            end component;
            --FIN DECLARACION DE COMPONENTES-------------

    --DECLARACION DE SENIALES----------
signal pixel_x_aux,pixel_y_aux: bit_vector(0 to 9);
signal v_vidon_aux: bit;
signal not_v_vidon_aux: bit;
signal data4,data3: bit_vector(0 to 3);

signal not_vvidon_and_out1: bit;

signal out1_aux, out2_aux: bit;
signal a0_c1s_reg: bit_vector(0 to 3);   
signal a1_c1s_reg: bit_vector(0 to 3);       
signal a2_c1s_reg: bit_vector(0 to 3);  
signal a0_reg_mux: bit_vector(0 to 3);   
signal a1_reg_mux: bit_vector(0 to 3);       
signal a2_reg_mux: bit_vector(0 to 3); 

    
signal mux_rom :bit_vector(0 to 3);
signal rom_out_aux: bit;
    --FIN DECLARACION DE SENIALES------

begin
    dutcontbin330: cont_bin_330 port map(clk330=>clkvolt,rst330=>rstvolt,ena330=>'1',out1=>out1_aux,out2=>out2_aux);

    dutcont1s: cont1s port map(clk1s=>clkvolt,rst1s=>out2_aux,ena1s=>unos,data_out0=>a0_c1s_reg, data_out1=>a1_c1s_reg, data_out2=>a2_c1s_reg,data_out3=>data3,data_out4=>data4);
    
    dutreg: reg port map(clkr=>clkvolt,rstr=>'0', enar=>not_vvidon_and_out1, bcd0=>a0_c1s_reg,bcd1=>a1_c1s_reg,bcd2=>a2_c1s_reg, a_0=>a0_reg_mux,a_1=>a1_reg_mux,a_2=>a2_reg_mux);
    
    not_vvidon_and_out1<= out1_aux and not_v_vidon_aux;
    not_v_vidon_aux<= not v_vidon_aux;
    
    
    dutmux: mux port map(a0=>a0_reg_mux,a1=>a1_reg_mux,a2=>a2_reg_mux,a3=>"1010",a4=>"1011",a5=>"1100",pixel_x=>pixel_x_aux,pixel_y=>pixel_y_aux,mux_out=>mux_rom); 

    dutrom: rom port map(pixel_x=>pixel_x_aux,pixel_y=>pixel_y_aux,char_adress=>mux_rom,rom_out=>rom_out_aux); 

    dutvga: vga port map(clkvga=>clkvolt,data_in_vga=>rom_out_aux,hsyncvga=>hsvolt,vsyncvga=>vsvolt,r_vga=>redV,g_vga=>greenV,b_vga=>blueV,pixely_vidon=>v_vidon_aux,pixel_x_vga=>pixel_x_aux,pixel_y_vga=>pixel_y_aux);
end;