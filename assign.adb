-- Jorge Santos Neila
-- Doble Grado en Sist. Telecomunicación + ADE

with Ada.Characters.Handling;
package body Assign is

	function Count_Words (Src: ASU.Unbounded_String) return Natural is
		N_Words: Natural := 0;
	begin
		if ASU.Element(Src, 1) /= ' ' then
			N_Words := N_Words + 1;
		end if;
		for I in 1..ASU.Length(Src) - 1 loop
			if ASU.Element(Src, I) = ' ' and ASU.Element(Src, I + 1) /= ' ' then
				N_Words := N_Words + 1;
			end if;
		end loop;
		return N_Words;
	end Count_Words;

	procedure Read_Word (Src, Word: in out ASU.Unbounded_String) is
		Pos: Natural := 1;
	begin
		while ASU.Element(Src, Pos) = ' ' loop
			Pos := Pos + 1;
		end loop;
		ASU.Tail(Src, ASU.Length(Src) - Pos+1);
		Pos := ASU.Index(Src, " ");
		if Count_Words(Src) = 1 and Pos /= 0 then
			Word := ASU.Head(Src, Pos-1);
		elsif Pos /= 0 then
			Word := ASU.Head(Src, Pos-1);
			while ASU.Element(Src, Pos) = ' ' loop
				Pos := Pos + 1;
			end loop;
			ASU.Tail(Src, ASU.Length(Src) - Pos+1);
		else
			Word := ASU.Tail(Src, ASU.Length(Src) - Pos);
		end if;
	end Read_Word;

	procedure Lower (Str: out ASU.Unbounded_String) is
	begin
		Str := ASU.To_Unbounded_String(Ada.Characters.Handling.To_Lower(ASU.To_String(Str)));
	end Lower;

end Assign;
