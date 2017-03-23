--==================================================================--

with C330001_0;
pragma Elaborate (C330001_0); -- Insure that the functions can be called.
package C330001_0.C330001_2 is

   Publicchild_Obj_01 : Fullviewdefinite_Unknown_Disc := Indef_Func_1;

   Publicchild_Obj_02 : Indefinite_W_Inherit_Disc_2 := Indef_Func_2 (4);

   Publicchild_Obj_03 : Indefinite_No_Disc := (38, 72, 21, 59);

   Publicchild_Obj_04 : Indefinite_Tag_W_Disc := (D => 7, C1 => True);

   Publicchild_Obj_05 : Indefinite_Tag_W_Disc := Publicchild_Obj_04;

   Publicchild_Obj_06 : Indefinite_New_W_Disc (6);

   procedure Assign_Private_Obj_3;

   function Raised_Ce_Publicchild_Obj return Boolean;

   function Raised_Ce_Privatechild_Obj return Boolean;

   -- The following functions check the private types defined in the parent
   -- and the private child package from within the client program.

   function Verify_Public_Obj_1 return Boolean;

   function Verify_Public_Obj_2 return Boolean;

   function Verify_Private_Obj_1 return Boolean;

   function Verify_Private_Obj_2 return Boolean;

   function Verify_Private_Obj_3 return Boolean;

end C330001_0.C330001_2;