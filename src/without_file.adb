with Ada.Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;

procedure Test_With_Append is
   UStr : Unbounded_String;
   Mega : constant := 1048576;
   Size : constant := 2048000;
   Test_String : constant String (1 .. Mega) := (others => 'a');
begin
   Put_Line ("Max Natural: " & Natural'Image (Natural'Last));
   
   loop
      for J in 1 .. 10 loop
         Append (Ustr, Test_String);
      end loop;
      Put_Line ("achieved length:"
                & Integer (Length (Ustr) / Mega)'Image
                & " Mb");
      
      exit when Length (Ustr) > Size;
   end loop;
   
   Put_Line ("Result: " & To_String (UStr));
exception
   when E : others =>
      Put_Line (Ada.Exceptions.Exception_Message (E));
      Put_Line ("achieved length:" & Length (Ustr)'Image);
end Test_With_Append;
