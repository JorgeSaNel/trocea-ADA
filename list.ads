-- Jorge Santos Neila
-- Doble Grado en Sist. Telecomunicación + ADE

with Ada.Strings.Unbounded;
package List is
	package ASU renames Ada.Strings.Unbounded;
	use type ASU.Unbounded_String;
	
	type Word_Ptr is limited private;
	
	procedure Analyze_Linked (P_First: in out Word_Ptr; Str: ASU.Unbounded_String);
	procedure Print(P_First: Word_Ptr);
	procedure Free_All(P_First: out Word_Ptr);

private 

	type Word;
	type Word_Ptr is access Word;
	type Word is record
		Name : ASU.Unbounded_String;
		Count: Natural := 1;
		Next : Word_Ptr := null;
	end record;
end List;
