entity cont10b is
port(
	clkc: in bit;
	rstc: in bit;
	enac: in bit;
	qoc: out bit_vector(0 to 9));
end;

architecture test of cont10b is

signal ds,qos: bit_vector(0 to 9);
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

ffd9: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(9),enai=>enac,qo=>qos(9));
    ds(9) <= enac xor qos(9);

ffd8: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(8),enai=>enac,qo=>qos(8));
    ds(8)<= (qos(9) and enac) xor qos(8);

ffd7: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(7),enai=>enac,qo=>qos(7));
    ds(7)<= (qos(8) and (qos(9) and enac) ) xor qos(7);
    
ffd6: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(6),enai=>enac,qo=>qos(6));
    ds(6)<= (qos(7) and (qos(8) and (qos(9) and enac))) xor qos(6);
    
ffd5: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(5),enai=>enac,qo=>qos(5));
    ds(5)<= (qos(6) and (qos(7) and (qos(8) and (qos(9) and enac)))) xor qos(5);
    
ffd4: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(4),enai=>enac,qo=>qos(4));
    ds(4)<= (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and enac))))) xor qos(4);
    
ffd3: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(3),enai=>enac,qo=>qos(3));
    ds(3)<= (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and enac)))))) xor qos(3);
    
ffd2: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(2),enai=>enac,qo=>qos(2));
    ds(2)<= (qos(3) and (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and enac))))))) xor qos(2);
    
ffd1: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(1),enai=>enac,qo=>qos(1));
    ds(1)<= (qos(2) and (qos(3) and (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and enac)))))))) xor qos(1);
   
ffd0: ffd port map(rsti=>rstc,clki=>clkc,di=>ds(0),enai=>enac,qo=>qos(0));
    ds(0)<= (qos(1) and (qos(2) and (qos(3) and (qos(4) and (qos(5) and (qos(6) and (qos(7) and (qos(8) and (qos(9) and enac))))))))) xor qos(0);

qoc <= qos;
end;
