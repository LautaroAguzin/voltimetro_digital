entity ffd is 
	port (
		clki: in bit;
		rsti: in bit;
		enai: in bit;
		di: in bit;
		qo: out bit);
end ffd;

architecture ffdarq of ffd is 
begin
process(clki,rsti)
begin
if (clki 'event and clki='1') then
	if rsti='1' then
		qo <= '0';
		elsif enai = '1' then
			qo <= di;
		end if;
	end if;
end process;
end ffdarq;
