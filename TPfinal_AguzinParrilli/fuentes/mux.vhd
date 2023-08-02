entity mux is
port(
a0: in bit_vector(0 to 3); --codigo para el bit mas significativo
a1: in bit_vector(0 to 3); --codigo para el segundo bit mas significativo
a2: in bit_vector(0 to 3); --codigo para el bit menos significativo
a3: in bit_vector(0 to 3) := "1010"; -- codigo para el punto
a4: in bit_vector(0 to 3) := "1011"; --codigo para la V
a5: in bit_vector (0 to 3):= "1100"; -- codigo par el espacio
pixel_x: in bit_vector (0 to 9); --posicion horizontal en la pantalla
pixel_y: in bit_vector (0 to 9);
mux_out: out bit_vector (0 to 3)
);
end;

architecture test of mux is

signal sel: bit_vector(0 to 2);
signal sely: bit_vector(0 to 2);
--sel: a0=000 a1=010 a2=011 a3=001 a4=100 a5=101
signal salida_and_a0: bit_vector(0 to 3);
signal salida_and_a1: bit_vector(0 to 3);
signal salida_and_a2: bit_vector(0 to 3);
signal salida_and_a3: bit_vector(0 to 3);
signal salida_and_a4: bit_vector(0 to 3);
signal salida_and_a5: bit_vector(0 to 3);
signal mux_out_aux: bit_vector(0 to 3);

begin
sel <= pixel_x(0 to 2);
sely <= pixel_y(0 to 2);

--SELECCION A0--
salida_and_a0(0) <= a0(0) and (not sel(0)) and (not sel(1)) and (not sel(2));
salida_and_a0(1) <= a0(1) and (not sel(0)) and (not sel(1)) and (not sel(2));
salida_and_a0(2) <= a0(2) and (not sel(0)) and (not sel(1)) and (not sel(2));
salida_and_a0(3) <= a0(3) and (not sel(0)) and (not sel(1)) and (not sel(2));

--seleccion A1--
salida_and_a1(0) <= a1(0) and (not sel(0)) and sel(1) and (not sel(2));
salida_and_a1(1) <= a1(1) and (not sel(0)) and sel(1) and (not sel(2));
salida_and_a1(2) <= a1(2) and (not sel(0)) and sel(1) and (not sel(2));
salida_and_a1(3) <= a1(3) and (not sel(0)) and sel(1) and (not sel(2));

--SELECCION A2--
salida_and_a2(0) <= a2(0) and (not sel(0)) and sel(1) and sel(2);
salida_and_a2(1) <= a2(1) and (not sel(0)) and sel(1) and sel(2);
salida_and_a2(2) <= a2(2) and (not sel(0)) and sel(1) and sel(2);
salida_and_a2(3) <= a2(3) and (not sel(0)) and sel(1) and sel(2);

--SELECCION A3--
salida_and_a3(0) <= a3(0) and (not sel(0)) and (not sel(1)) and sel(2);
salida_and_a3(1) <= a3(1) and (not sel(0)) and (not sel(1)) and sel(2);
salida_and_a3(2) <= a3(2) and (not sel(0)) and (not sel(1)) and sel(2);
salida_and_a3(3) <= a3(3) and (not sel(0)) and (not sel(1)) and sel(2);

--SELECCION A4--
salida_and_a4(0) <= a4(0) and sel(0) and (not sel(1)) and (not sel(2));
salida_and_a4(1) <= a4(1) and sel(0) and (not sel(1)) and (not sel(2));
salida_and_a4(2) <= a4(2) and sel(0) and (not sel(1)) and (not sel(2));
salida_and_a4(3) <= a4(3) and sel(0) and (not sel(1)) and (not sel(2));

--SELECCION A5--
salida_and_a5(0) <= a5(0) and sel(0) and (not sel(1)) and sel(2);
salida_and_a5(1) <= a5(1) and sel(0) and (not sel(1)) and sel(2);
salida_and_a5(2) <= a5(2) and sel(0) and (not sel(1)) and sel(2);
salida_and_a5(3) <= a5(3) and sel(0) and (not sel(1)) and sel(2);


mux_out(0) <= (salida_and_a0(0) or salida_and_a1(0) or salida_and_a2(0) or salida_and_a3(0) or salida_and_a4(0) or salida_and_a5(0));
mux_out(1) <= (salida_and_a0(1) or salida_and_a1(1) or salida_and_a2(1) or salida_and_a3(1) or salida_and_a4(1) or salida_and_a5(1));
mux_out(2) <= (salida_and_a0(2) or salida_and_a1(2) or salida_and_a2(2) or salida_and_a3(2) or salida_and_a4(2) or salida_and_a5(2));
mux_out(3) <= (salida_and_a0(3) or salida_and_a1(3) or salida_and_a2(3) or salida_and_a3(3) or salida_and_a4(3) or salida_and_a5(3));


end;
