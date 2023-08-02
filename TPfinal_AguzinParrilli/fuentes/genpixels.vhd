entity genpixels is
port(
r_i: in bit;
g_i: in bit;
b_i: in bit:='1';
vidon_genp: in bit;
pixel_y: in bit_vector(0 to 9);
r_o,g_o,b_o: out bit
);
end;

architecture test of genpixels is

signal sely: bit_vector(0 to 2);
begin
r_o<=r_i and vidon_genp and (not pixel_y(1)) and (not pixel_y(2));
g_o<=g_i and vidon_genp and (not pixel_y(1)) and (not pixel_y(2));
b_o<=b_i and vidon_genp;

end;
