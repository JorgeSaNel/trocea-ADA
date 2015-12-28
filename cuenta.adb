-- Jorge Santos Neila
-- Doble Grado en Sist. Telecomunicacion + ADE
-- Cuenta returns how many words, characters and lines have a file

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.IO_Exceptions;
with Ada.Command_Line;
with List;
with Assign;

procedure Cuenta is
	package ASU renames Ada.Strings.Unbounded;

	type Count is record
		Lines: Integer := 0;
		Words: Integer := 0;
		Chars: Integer := 0;
		Print_All: Boolean := True;
	end record;

	procedure Arguments_Input(Counters: in out Count; File: out File_Type) is
		package ACL renames Ada.Command_Line;
		Input_W: Integer;
	begin
		Input_W := ACL.Argument_Count;
		if Input_W = 2 then
			if ACL.Argument(1) = "-f" then
				Open(File, In_File, ACL.Argument(2));
				Counters.Print_All := False;
			end if;
		elsif Input_W = 3 then
			if ACL.Argument(1) = "-f" and ACL.Argument(3) = "-t" then
				Open(File, In_File, ACL.Argument(2));
			elsif ACL.Argument(1) = "-t" and ACL.Argument(2) = "-f" then
				Open(File, In_File, ACL.Argument(3));
			end if;
		end if;
	end Arguments_Input;

	procedure Analyze_File_Line(Counters: in out Count; P_First: in out List.Word_Ptr; File: File_Type) is
		S_Unbounded, Str: ASU.Unbounded_String;
	begin
		S_Unbounded := ASU.To_Unbounded_String(Get_Line(File));

		Counters.Lines := Counters.Lines + 1;
		Counters.Words := Counters.Words + Assign.Count_Words(S_Unbounded);
		Counters.Chars := Counters.Chars + ASU.Length(S_Unbounded);

		for I in 1..Assign.Count_Words(S_Unbounded) loop
			Assign.Read_Word(S_Unbounded, Str);
			Assign.Lower(Str);
			List.Analyze_Linked(P_First, Str);
		end loop;
	end Analyze_File_Line;

	procedure Print_Counters(Counters: in out Count) is
	begin
		Counters.Chars := Counters.Chars + Counters.Lines; -- To count also End_Of_Line
		Put(Integer'Image(Counters.Lines));
		if Counters.Lines = 1 then
			Put(" linea,");
		else
			Put(" lineas,");
		end if;
		Put(Natural'Image(Counters.Words));
		if Counters.Words = 1 then
			Put(" palabra,");
		else
			Put(" palabras,");
		end if;
		Put_Line(Natural'Image(Counters.Chars) & " caracteres");
	end Print_Counters;

	procedure Print_All(Counters: out Count; P_First: List.Word_Ptr) is
	begin
		Print_Counters(Counters);
		if Counters.Print_All then
			New_Line(2);
			List.Print(P_First);
		end if;
	end Print_All;

   	File: File_Type;
	Finish: Boolean := False;
	P_First: List.Word_Ptr;

	Counters: Count;
begin
	begin
		Arguments_Input(Counters, File); --If the arguments are correct, it opens the file
	exception
		when Ada.IO_Exceptions.Name_Error =>
			Put_Line("Fichero no encontrado");
			Finish := True;
	end;

	while not Finish loop
		begin
			Analyze_File_Line(Counters, P_First, File);
		exception
			when Ada.IO_Exceptions.End_Error =>
				Close(File);
				Print_All(Counters, P_First);
				List.Free_All(P_First);
				Finish := True;
			when Ada.IO_Exceptions.Status_Error =>
				Put_Line("Argumentos incorrectos");
				Finish := True;
			when Ada.Strings.Index_Error =>
				Finish := False; --For not exit the loop  --Just for End_Of_Line without characters
		end;
	end loop;
end;
