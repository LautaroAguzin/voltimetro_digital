--registro de 4 bits--
entity reg4 is
	port(
	clkr4: in bit;
	rstr4: in bit:='0';
	enar4: in bit;
	dr4: in bit_vector(0 to 3);
	qr4: out bit_vector(0 to 3));
end;

architecture test of reg4 is
	component ffd is
	port (
		clki: in bit;
		rsti: in bit;
		enai: in bit;
		di: in bit;
		qo: out bit);
	end component;
	
begin

ffd0: ffd port map(clki=>clkr4,rsti=>rstr4,enai=>enar4,di=>dr4(0),qo=>qr4(0));
ffd1: ffd port map(clki=>clkr4,rsti=>rstr4,enai=>enar4,di=>dr4(1),qo=>qr4(1));
ffd2: ffd port map(clki=>clkr4,rsti=>rstr4,enai=>enar4,di=>dr4(2),qo=>qr4(2));
ffd3: ffd port map(clki=>clkr4,rsti=>rstr4,enai=>enar4,di=>dr4(3),qo=>qr4(3));

end;
