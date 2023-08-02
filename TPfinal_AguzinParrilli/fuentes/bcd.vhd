entity bcd is
port(
clkb: in bit;
rstb: in bit;
enab: in bit;
f: out bit;
qob: out bit_vector(0 to 3));
end;

architecture test of bcd is

signal ds,qos: bit_vector(0 to 3);
--------------------------------------
component ffd
port (
clki: in bit;
rsti: in bit;
enai: in bit;
di: in bit;
qo: out bit);
end component;
--------------------------------------


begin
ffd3: ffd port map(clki=>clkb,rsti=>rstb,enai=>enab,di=>ds(3),qo=>qos(3));

ffd2: ffd port map(clki=>clkb,rsti=>rstb,enai=>enab,di=>ds(2),qo=>qos(2));

ffd1: ffd port map(clki=>clkb,rsti=>rstb,enai=>enab,di=>ds(1),qo=>qos(1));

ffd0: ffd port map(clki=>clkb, rsti=>rstb,enai=>enab,di=>ds(0),qo=>qos(0));

ds(0)<= (qos(0) and (not qos(2)) and (not qos(3))) or (qos(1) and qos(2) and qos(3));
ds(1) <= (qos(1) and (not qos(2))) or (qos(1) and (not qos(3))) or ((not qos(1)) and qos(2) and  qos(3));
ds(2) <= (qos(2) and (not qos(3))) or ((not qos(0)) and (not qos(2)) and qos(3));
ds(3) <= not qos(3);

qob <= qos;
f <= qos(0) and (not qos(1) and (not qos(2)) and qos(3));
end;

