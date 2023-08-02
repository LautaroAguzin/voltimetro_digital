--1 0 0 0 0 0 0 0 1 1 1 0 1 0 0 0
entity cont_bin_330 is
port(
clk330: in bit;
rst330: in bit:='0';
ena330: in bit:='1';
out1, out2 : out bit
);
end;

architecture test of cont_bin_330 is

    ---DECLARACION DE COMPONENTES--------------
    component cont16b 
        port(
            clkc: in bit;
            rstc: in bit;
            enac: in bit;
            qoc: out bit_vector(0 to 15));
    end component;
    
    component ffd 
        port (
            clki: in bit;
            rsti: in bit;
            enai: in bit;
            di: in bit;
            qo: out bit);
    end component;
    -------------------------------------------

signal flag330, rst_aux: bit;
signal q_aux: bit_vector(0 to 15);

begin

        --  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
--33000 = --1 0 0 0 0 0 0 0 1 1 1  0  1   0  0 0
dut: cont16b port map(clkc=>clk330,rstc=>rst_aux,enac=>ena330,qoc=>q_aux);

flag330 <= q_aux(0) and (not q_aux(1)) and (not q_aux(2)) and (not q_aux(3)) and (not q_aux(4)) and (not q_aux(5)) and (not q_aux(6)) and (not q_aux(7)) and q_aux(8) and q_aux(9) and q_aux(10) and (not q_aux(11)) and q_aux(12) and (not q_aux(13)) and (not q_aux(14)) and (not q_aux(15));
rst_aux <= flag330 or rst330;
out1<=flag330;



dut1: ffd port map(clki=>clk330, rsti=>rst330, enai=> ena330, di=>flag330,qo=>out2);
end;
