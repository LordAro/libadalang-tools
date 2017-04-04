-- CD5013K.ADA

--                             Grant of Unlimited Rights
--
--     Under contracts F33600-87-D-0337, F33600-84-D-0280, MDA903-79-C-0687,
--     F08630-91-C-0015, and DCA100-97-D-0025, the U.S. Government obtained
--     unlimited rights in the software and documentation contained herein.
--     Unlimited rights are defined in DFAR 252.227-7013(a)(19).  By making
--     this public release, the Government intends to confer upon all
--     recipients unlimited rights  equal to those held by the Government.
--     These rights include rights to use, duplicate, release or disclose the
--     released technical data and computer software in whole or in part, in
--     any manner and for any purpose whatsoever, and to have or permit others
--     to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS.  THE GOVERNMENT MAKES NO EXPRESS OR IMPLIED
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--*
-- OBJECTIVE:
--     CHECK THAT AN ADDRESS CLAUSE CAN BE GIVEN IN THE PRIVATE PART OF
--     A PACKAGE SPECIFICATION FOR A VARIABLE OF A RECORD TYPE, WHERE
--     THE VARIABLE IS DECLARED IN THE VISIBLE PART OF THE
--     SPECIFICATION.

-- HISTORY:
--     BCB 09/16/87  CREATED ORIGINAL TEST.
--     PWB 05/11/89  CHANGED EXTENSION FROM '.DEP' TO '.ADA'.

with Report;  use Report;
with Spprt13; use Spprt13;
with System;  use System;

procedure Cd5013k is

   type Rec_Type is record
      Bool : Boolean;
      Int  : Integer;
   end record;

   package Pack is
      Check_Var : Rec_Type;
   private
      for Check_Var use at Variable_Address;
   end Pack;

   package body Pack is
   begin
      Test
        ("CD5013K",
         "AN ADDRESS CLAUSE CAN BE GIVEN " &
         "IN THE PRIVATE PART OF A PACKAGE " &
         "SPECIFICATION FOR A VARIABLE OF A RECORD " &
         "TYPE, WHERE THE VARIABLE IS DECLARED IN " &
         "THE VISIBLE PART OF THE SPECIFICATION");

      Check_Var := (True, Ident_Int (5));
      if Equal (3, 3) then
         Check_Var := (False, Ident_Int (10));
      end if;

      if Check_Var /= (False, Ident_Int (10)) then
         Failed ("INCORRECT VALUE FOR RECORD VARIABLE");
      end if;

      if Check_Var'Address /= Variable_Address then
         Failed ("INCORRECT ADDRESS FOR RECORD VARIABLE");
      end if;
   end Pack;

begin

   Result;
end Cd5013k;