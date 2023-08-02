

entity volticonffd is
port(
pin_in: in bit;
pin_out: out bit;
clk_in: in bit;
rst: in bit:='0';
h_sync: out bit;
v_sync: out bit;
red:out bit;
green: out bit;
blue: out bit);

end;

architecture test of volticonffd is

	component cont10b is
	port(
	clkc: in bit;
	rstc: in bit;
	enac: in bit;
	qoc: out bit_vector(0 to 9));
	end component;
    component volti is
        port(
        clkvolt: in bit;
        rstvolt: in bit;
        unos: in bit;
        hsvolt: out bit;
        vsvolt: out bit;
        redV:out bit;
        greenV: out bit;
        blueV: out bit);
    end component;
    component ffd is
        port (
            clki: in bit;
            rsti: in bit;
            enai: in bit;
            di: in bit;
            qo: out bit);
    end component;
    
  

signal unos_aux: bit;
signal clk25: bit;
signal qcont: bit_vector(0 to 9);

    begin
        dutvolti: volti port map(clkvolt=>clk25,rstvolt=>rst,unos=>unos_aux,hsvolt=>h_sync,vsvolt=>v_sync,redV=>red,greenV=>green,blueV=>blue);

        dutffd: ffd port map(clki=>clk25,rsti=>'0',enai=>'1',di=>pin_in,qo=>unos_aux);
        
	dutcont10b: cont10b port map(clkc=>clk_in,rstc=>'0',enac=>'1',qoc=>qcont);
	
        pin_out<= not unos_aux;
	clk25<=qcont(8);

end;