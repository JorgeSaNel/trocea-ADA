-- Jorge Santos Neila
-- Doble Grado en Sist. Telecomunicación + ADE

with Ada.Text_IO; use Ada.Text_IO;
with Unchecked_Deallocation;
package body List is

	procedure Add_Word (P_First: in out Word_Ptr; Str: ASU.Unbounded_String) is
		New_Word: Word_Ptr;
	begin
		New_Word := new Word;
		New_Word.Name := Str;
		New_Word.Next := P_First;
		P_First := New_Word;
	end Add_Word;

	procedure Analyze_Linked (P_First: in out Word_Ptr; Str: ASU.Unbounded_String) is
		P_Scan: Word_Ptr;
	begin
		if P_First = null then
			Add_Word(P_First, Str);
		else
			P_Scan := P_First;
			loop
				if P_Scan.Name = Str then
					P_Scan.Count := P_Scan.Count + 1;
					exit when P_Scan.Name = Str;
				end if;
				P_Scan := P_Scan.Next;
				exit when P_Scan = null;
			end loop;
			if P_Scan = null then
				Add_Word(P_First, Str);
			end if;
		end if;
	end Analyze_Linked;

	procedure Print(P_First: Word_Ptr) is
		P_Scan: Word_Ptr;
	begin
		Put_Line("Palabras");
		Put_Line("--------");
		P_Scan := P_First;
		while P_Scan /= null loop
			Put(ASU.To_String(P_Scan.Name));
			Put_Line(":" & Natural'Image(P_Scan.Count));
			P_Scan := P_Scan.Next;
		end loop;
	end Print;

	procedure Free is new Unchecked_Deallocation (List.Word, List.Word_Ptr);

	procedure Free_All(P_First: out Word_Ptr) is
		P_Scan: Word_Ptr;
	begin
		P_Scan := P_First;
		while P_First /= null loop
			Free(P_Scan);
			P_First := P_First.Next;
			P_Scan := P_First;
		end loop;
	end Free_All;

end List;
