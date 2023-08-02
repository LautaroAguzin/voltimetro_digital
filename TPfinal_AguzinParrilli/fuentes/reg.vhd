--registro de 4 bits--
entity reg is
	port(
	clkr: in bit;
	rstr: in bit:= '0';
	enar: in bit;
	bcd0,bcd1,bcd2: in bit_vector(0 to 3);
	a_0,a_1,a_2: out bit_vector(0 to 3));
end;

architecture test of reg is

	----------------------------------------------
	component reg4 is
		port(
			clkr4: in bit;
			rstr4: in bit;
			enar4: in bit;
			dr4: in bit_vector(0 to 3);
			qr4: out bit_vector(0 to 3));
	end component;
	---------------------------------------------

begin
	
	reg4_0: reg4 port map(clkr4 => clkr, rstr4 => rstr, enar4 => enar, dr4 => bcd0, qr4 => a_0);
	reg4_1: reg4 port map(clkr4 => clkr, rstr4 => rstr, enar4 => enar, dr4 => bcd1, qr4 => a_1);
	reg4_2: reg4 port map(clkr4 => clkr, rstr4 => rstr, enar4 => enar, dr4 => bcd2, qr4 => a_2);

end;
