-- CA110040.A
--
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
--
-- OBJECTIVE:
--      See CA110042.AM
--
-- TEST DESCRIPTION:
--      See CA110042.AM
--
-- TEST FILES:
--      The following files comprise this test:
--
--      => CA110040.A
--         CA110041.A
--         CA110042.AM
--
-- CHANGE HISTORY:
--      06 Dec 94   SAIC    ACVC 2.0
--      26 Apr 96   SAIC    ACVC 2.1: Modified prologue; Added pragma
--                          Elaborate_Body.
--
--!

package Ca110040 is                              -- Package Computer_System.
   pragma Elaborate_Body (Ca110040);

   -- Types.
   type Id_Type is range 1 .. 4;
   type System_Account_Capacity is new Id_Type;

   type Account is tagged record
      User_Id : Id_Type;
   end record;

   -- Constants.
   Maximum_System_Accounts : constant System_Account_Capacity :=
     System_Account_Capacity'Last;

   System_Administrator : constant Id_Type :=
     Id_Type (System_Account_Capacity'First);

   Administrator_Account : constant Account :=
     (User_Id => System_Administrator);

   -- Objects.
   Total_Accounts : System_Account_Capacity := 1;

   -- Exceptions.
   Illegal_Account        : exception;
   Account_Limit_Exceeded : exception;

   -- Subprograms.
   function Next_Available_Id return Id_Type;

end Ca110040;                                -- Package Computer_System.