--el ingreso de los 1s es por el ena1s--

entity cont1s is
    port(
        clk1s: in bit;
        rst1s: in bit;
        ena1s: in bit;
        data_out0: out bit_vector(0 to 3);
        data_out1: out bit_vector(0 to 3);
        data_out4: out bit_vector(0 to 3);
        data_out3: out bit_vector(0 to 3);
        data_out2: out bit_vector(0 to 3)
    );
end;

architecture test of cont1s is
   
    --------------------------------
    component bcd is
    port(
        clkb: in bit;
        rstb: in bit;
        enab: in bit;
        f: out bit;
        qob: out bit_vector(0 to 3));
    end component;
    ---------------------------------
    signal flag4: bit;
    signal flag3: bit;
    signal flag2: bit;  -- se?al de clock que sale de las unidades
    signal flag1: bit;
    signal flag0: bit; -- se?al de clock que sale de las decenas
    signal qo0,qo1,qo2,qo3,qo4: bit_vector(0 to 3); --salidas de los bcds
    signal ena0,ena1,ena2,ena3: bit;
    

    begin
        bcd4 : bcd port map (clkb=>clk1s,rstb=>rst1s, enab=> ena1s,f=>flag4,qob=>qo4); --menos significativo
        bcd3 : bcd port map (clkb=>clk1s,rstb=>rst1s, enab=> ena3,f=>flag3,qob=>qo3); 
        bcd2 : bcd port map (clkb=>clk1s,rstb=>rst1s, enab=> ena2,f=>flag2,qob=>qo2); 
        bcd1 : bcd port map (clkb=>clk1s,rstb=>rst1s, enab=> ena1,f=>flag1,qob=>qo1); 
        bcd0 : bcd port map (clkb=>clk1s,rstb=>rst1s, enab=> ena0,f=>flag0,qob=>qo0); --MAS SIGNIFICATIVO

  ena3<= flag4 and ena1s;
  ena2<= flag3 and ena3;
  ena1<= flag2 and ena2;
  ena0<= flag1 and ena1;

    


    data_out0 <= qo0;
    data_out1 <= qo1;
    data_out2 <= qo2;
    data_out3 <= qo3;
    data_out4 <= qo4;

end;
