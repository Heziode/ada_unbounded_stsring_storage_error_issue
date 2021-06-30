with Ada.Directories;
with Ada.Characters.Handling;
with Ada.Characters.Latin_1;
with Ada.Strings.Unbounded;
with Ada.Text_IO;

use Ada.Characters.Handling;
use Ada.Strings.Unbounded;
use Ada.Text_IO;

procedure Main is
   package L renames Ada.Characters.Latin_1;

   procedure Read (File   :        File_Type;
                   Result :    out Unbounded_String)
   is
   begin
      Result := To_Unbounded_String ("");
      loop
         exit when End_Of_File (File);

         if End_Of_Line (File) then
            Skip_Line (File);
         elsif End_Of_Page (File) then
            Skip_Page (File);
         else
            Result := Result & To_Unbounded_String (Get_Line (File)) & L.LF;
         end if;
      end loop;
   end Read;

   procedure Open_File (File      : in out File_Type;
                        Mode      : File_Mode;
                        Path      : String;
                        File_Form : String  := "wcem=8";
                        Auto      : Boolean := True)
   is
      use Ada.Directories;
   begin
      if Exists (Path) then
         Open (File, Mode, Path, File_Form);
      else
         if Auto then
            Create (File, Mode, Path, File_Form);
         else
            raise Ada.Directories.Name_Error;
         end if;
      end if;
   end Open_File;

   Req_File_Path_Working      : constant String := "./output_working.txt";
   Req_File_Path_Not_Working  : constant String := "./output_not_working.txt";

   File : File_Type;
   UStr : Unbounded_String;
begin
   Put_Line ("Max Natural: " & Natural'Image (Natural'Last));

   -- Working Version (2048000 bytes)
   -- Generated with: dd if=/dev/zero of=output_working.txt  bs=2048000  count=1

   Open_File (File => File,
              Mode => In_File,
              Path => Req_File_Path_Working);
   Read (File, UStr);
   Close (File);

   Put_Line ("""" & Req_File_Path_Working & """ size: " & Natural'Image (Length (UStr)));

   -- Not working exemple (just 1 more byte than the working version)
   -- Generated with: dd if=/dev/zero of=output_working.txt  bs=2048001  count=1

   Open_File (File => File,
              Mode => In_File,
              Path => Req_File_Path_Not_Working);
   Read (File, UStr);
   Close (File);

   Put_Line ("""" & Req_File_Path_Not_Working & """ size: " & Natural'Image (Length (UStr)));
end Main;
