entity cont16b is
    port(
        clkc: in bit;
        rstc: in bit:='0';
        enac: in bit:='1';
        qoc: out bit_vector(0 to 15)
        );
    end;
    
    architecture test of cont16b is
    
    signal ds,qos: bit_vector(0 to 15);
    ----------------------------- 
    component ffd
        port (
            clki: in bit;
            rsti: in bit;
            enai: in bit;
            di: in bit;
            qo: out bit);
    end component;
    -----------------------------
    begin
    ffd15: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(15),enai=>enac,qo=>qos(15));
    ds(15) <= enac xor qos(15);

    ffd14: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(14),enai=>enac,qo=>qos(14));
    ds(14)<= (qos(15) and enac) xor qos(14);

    ffd13: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(13),enai=>enac,qo=>qos(13));
    ds(13) <= (qos(14) and (qos(15) and enac)) xor qos(13);

    ffd12: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(12),enai=>enac,qo=>qos(12));
    ds(12)<= (qos(13) and (qos(14) and (qos(15) and enac))) xor qos(12);

    ffd11: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(11),enai=>enac,qo=>qos(11));
    ds(11)<= (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac)))) xor qos(11);

    ffd10: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(10),enai=>enac,qo=>qos(10));
    ds(10) <= (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac))))) xor qos(10);

    ffd9: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(9),enai=>enac,qo=>qos(9));
        ds(9) <= (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac)))))) xor qos(9);
    
    ffd8: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(8),enai=>enac,qo=>qos(8));
        ds(8)<= (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac))))))) xor qos(8);
    
    ffd7: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(7),enai=>enac,qo=>qos(7));
        ds(7)<= (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac)))))))) xor qos(7);
        
    ffd6: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(6),enai=>enac,qo=>qos(6));
        ds(6)<= (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac))))))))) xor qos(6);
        
    ffd5: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(5),enai=>enac,qo=>qos(5));
        ds(5)<= (qos(6) and (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac)))))))))) xor qos(5);
        
    ffd4: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(4),enai=>enac,qo=>qos(4));
        ds(4)<= (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac))))))))))) xor qos(4);
        
    ffd3: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(3),enai=>enac,qo=>qos(3));
        ds(3)<= (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac)))))))))))) xor qos(3);
        
    ffd2: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(2),enai=>enac,qo=>qos(2));
        ds(2)<=(qos(3) and (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac))))))))))))) xor qos(2);
        
    ffd1: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(1),enai=>enac,qo=>qos(1));
        ds(1)<= (qos(2) and (qos(3) and (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac)))))))))))))) xor qos(1);
       
    ffd0: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(0),enai=>enac,qo=>qos(0));
        ds(0)<= (qos(1) and (qos(2) and (qos(3) and (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and (qos(10) and (qos(11) and (qos(12) and (qos(13) and (qos(14) and (qos(15) and enac))))))))))))))) xor qos(0);
    
    qoc <= qos;
    end;