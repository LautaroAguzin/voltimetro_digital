entity rom is
port(
pixel_x: in bit_vector(0 to 9);
pixel_y: in bit_vector(0 to 9);
char_adress: in bit_vector(0 to 3);
rom_out: out bit);

end; 

architecture test of rom is

type matriz is array (0 to 103) of bit_vector(0 to 7);

-----------------------------------------------------------------------------------------------------------
constant memoria: matriz:=
	("01111110","01000010","01000010","01000010","01000010","01000010","01000010","01111110", 	--0	0000
	"00001000","00001000","00001000","00001000","00001000","00001000","00001000","00001000",	--1	0001
	"01111110","01000010","00000110","00001000","00010000","00100000","01000000","01111110",	--2	0010
	"01111110","00000010","00000010","00111110","00000010","00000010","00000010","01111110",	--3	0011
	"01000010","01000010","01000010","01000010","01111110","00000010","00000010","00000010",	--4	0100
	"01111110","01000000","01000000","01111110","00000010","00000010","00000010","01111110",	--5 0101
	"00011110","00100000","01000000","01111110","01000010","01000010","01000010","01111110",	--6	0110
	"01111110","00000010","00000100","00000100","00001000","00001000","00010000","00010000",	--7	0111
	"01111110","01000010","01000010","01111110","01000010","01000010","01000010","01111110",	--8	1000
	"01111110","01000010","01000010","01111110","00000010","00000010","00000010","01111110",	--9	1001
	"00000000","00000000","00000000","00000000","00000000","00000000","00011000","00011000",  	--.	1010
	"01000010","01000010","01000010","00100100","00100100","00100100","00011000","00011000",	--V	 1011
	"00000000","00000000","00000000","00000000","00000000","00000000","00000000","00000000");      --espacio 1100
-----------------------------------------------------------------------------------------------------------
signal char_adress_aux: bit_vector(0 to 6);

signal char_adress_aux_aux: bit_vector(6 downto 0);
signal pixel_x_aux: bit_vector(2 downto 0);

-----FUNCION PARA CONERTIR A ENTERO-----

function conv_int(word:bit_vector) return integer is

variable resultado: integer:= 0 ;

begin
for i in word'range loop
	if (word(i)= '1') then
		resultado:= resultado + 2**i;
	end if;
end loop;
return resultado;
end conv_int;
-----------------------------------------

begin
	char_adress_aux <= char_adress & pixel_y(3 to 5);
	
	-----------------------------
	pixel_x_aux(2)<= pixel_x(3);
	pixel_x_aux(1)<=pixel_x(4);
	pixel_x_aux(0)<=pixel_x(5);

	char_adress_aux_aux(6)<=char_adress_aux(0);
	char_adress_aux_aux(5)<=char_adress_aux(1);
	char_adress_aux_aux(4)<=char_adress_aux(2);
	char_adress_aux_aux(3)<=char_adress_aux(3);
	char_adress_aux_aux(2)<=char_adress_aux(4);
	char_adress_aux_aux(1)<=char_adress_aux(5);
	char_adress_aux_aux(0)<=char_adress_aux(6);
	-----------------------------
	
	

	rom_out<= memoria(conv_int(char_adress_aux_aux))(conv_int(pixel_x_aux));
end;
