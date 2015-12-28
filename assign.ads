-- Jorge Santos Neila
-- Doble Grado en Sist. Telecomunicación + ADE

with Ada.Strings.Unbounded;
package Assign is
	package ASU renames Ada.Strings.Unbounded;

	function Count_Words (Src: ASU.Unbounded_String) return Natural;
	procedure Read_Word(Src, Word: in out ASU.Unbounded_String);
	procedure Lower(Str: out ASU.Unbounded_String);

end Assign;
