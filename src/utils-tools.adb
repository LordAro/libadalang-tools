with GNAT.Byte_Order_Mark;
with GNAT.OS_Lib;

with Langkit_Support.Diagnostics;

with Libadalang.Iterators;        use Libadalang.Iterators;
with Libadalang.Project_Provider; use Libadalang.Project_Provider;

with Utils.Command_Lines.Common;   use Utils.Command_Lines.Common;
with Utils.Err_Out;
with Utils.String_Utilities; use Utils.String_Utilities;

package body Utils.Tools is

   procedure Process_File
     (Tool : in out Tool_State'Class;
      Cmd : in out Command_Line;
      File_Name : String;
      Counter : Natural;
      Reparse : Boolean := False)
   is
      use GNAT.OS_Lib, GNAT.Byte_Order_Mark;
      --  We read the file into a String, and convert to wide
      --  characters according to the encoding method.
      --
      --  No matter what the encoding method is, we recognize brackets
      --  encoding, but not within comments.
      --
      --  These behaviors are intended to match what the compiler
      --  does.

      Input : String_Access := Read_File (File_Name);
      First : Natural       := 1;
      --  First character of Input, skipping the BOM, if any

      BOM     : BOM_Kind;
      BOM_Len : Natural;
      BOM_Seen : Boolean := False;
   begin
      --  Check for BOM at start of file. The only supported BOM is
      --  UTF8_All. If present, when we're called from gnatpp, the
      --  Wide_Character_Encoding should already be set to
      --  WCEM_UTF8, but when we're called from xml2gnat, we need to
      --  set it.

      Read_BOM (Input.all, BOM_Len, BOM);
      if BOM = UTF8_All then
         First := BOM_Len + 1; -- skip it
         BOM_Seen := True;
         Set_WCEM (Cmd, "8");
      else
         pragma Assert (BOM = Unknown); -- no BOM found
      end if;

      --  Call Create_Context if we don't have one, or after an arbitrary
      --  number of files.

      if Tool.Context = No_Analysis_Context or else Counter mod 100 = 0 then
         declare
            use GNATCOLL.Projects;

            Provider : constant Unit_Provider_Reference :=
              (if Status (Tool.Project_Tree.all) = Empty
               then No_Unit_Provider_Reference
               else Create_Project_Unit_Provider_Reference
                      (Tool.Project_Tree, Tool.Project_Env,
                       Is_Project_Owner => False));
         begin
            Tool.Context := Create_Context
              (Charset       => Wide_Character_Encoding (Cmd),
               Unit_Provider => Provider);
         end;
      end if;

      declare
         Inp : String renames Input (First .. Input'Last);
         Unit : constant Analysis_Unit :=
           Get_From_File (Tool.Context, File_Name, Reparse => Reparse);
      begin
         if Has_Diagnostics (Unit) then
            Err_Out.Put ("Syntax errors in \1\n", File_Name);

            for D of Diagnostics (Unit) loop
               Err_Out.Put
                 ("\1\n", Langkit_Support.Diagnostics.To_Pretty_String (D));
            end loop;

         else
            pragma Assert (not Root (Unit).Is_Null);
            Per_File_Action
              (Tool, Cmd, File_Name, Inp, BOM_Seen, Unit);
         end if;
         Free (Input);
      end;
   end Process_File;

end Utils.Tools;
