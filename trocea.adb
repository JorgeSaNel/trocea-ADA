-- Jorge Santos Neila
-- Doble Grado en Sist. Telecomunicación + ADE
-- Trocea returns how many words and spaces introduce you by standard input

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded.Text_IO;

procedure Trocea is	
	package ASU renames Ada.Strings.Unbounded;

	procedure Read_String (Strings : out ASU.Unbounded_String) is
		package ASU_IO renames Ada.Strings.Unbounded.Text_IO;
	begin
		Put("Introduce una cadena de caracteres: ");
		Strings := ASU_IO.Get_Line;
	end Read_String;

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

	procedure Return_First_Word (S_Unbounded, First: in out ASU.Unbounded_String) is
      		Pos: Natural := 1;
	begin      
		while ASU.Element(S_Unbounded, Pos) = ' ' loop
			Pos := Pos + 1;
		end loop;
		ASU.Tail(S_Unbounded, ASU.Length(S_Unbounded) - Pos+1);
		Pos := ASU.Index(S_Unbounded, " ");
		if Count_Words(S_Unbounded) = 1 and Pos /= 0 then
			First := ASU.Head(S_Unbounded, Pos-1);
		elsif Pos /= 0 then
			First := ASU.Head(S_Unbounded, Pos-1);			
			while ASU.Element(S_Unbounded, Pos) = ' ' loop
				Pos := Pos + 1;
			end loop;
			ASU.Tail(S_Unbounded, ASU.Length(S_Unbounded) - Pos+1);
		else
			First := ASU.Tail(S_Unbounded, ASU.Length(S_Unbounded) - Pos);
		end if;
	end Return_First_Word;

	procedure Print_Result(Words, Spaces: Natural) is
	begin
		Put("Total:" & Natural'Image(Words));
		if Words = 1 then
			Put(" palabra y");     
		else
	 		Put(" palabras y");     
		end if;
		if Spaces = 1 then
			Put_Line(Natural'Image(Spaces) & " espacio");
		else
			Put_Line(Natural'Image(Spaces) & " espacios");
		end if;
	end Print_Result;

	S_Unbounded, Word: ASU.Unbounded_String;
	N_Words, N_Spaces: Natural;	
begin
	begin
		Read_String(S_Unbounded);
		N_Words := Count_Words(S_Unbounded);
		N_Spaces := ASU.Count(S_Unbounded, " ");

		for N_Words in 1..Count_Words(S_Unbounded) loop 
	   		Return_First_Word(S_Unbounded, Word);
			Put_Line("Palabra" & Natural'Image(N_Words) & ": |" & ASU.To_String(Word) & "|");
		end loop;
		Print_Result(N_Words, N_Spaces);
	exception
		when Ada.Strings.Index_Error =>
			Print_Result(N_Words, N_Spaces);
	end;
end;
