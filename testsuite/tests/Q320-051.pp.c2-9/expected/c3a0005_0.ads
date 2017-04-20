-- C3A0005.A
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
--      Check that access to subprogram may be stored within record
--      objects, and that the access to subprogram can subsequently
--      be called.
--
-- TEST DESCRIPTION:
--      Declare an access to procedure type in a package specification.
--      Declare two different procedures that can be referred to by the
--      access to procedure type.  Declare a record with the access to
--      procedure type as a component.  Use the access to procedure type to
--      initialize the component of a record.
--
--      In the main program, declare an operation.  An access value
--      designating this operation is passed as a parameter to be
--      stored in the record.
--
--
-- CHANGE HISTORY:
--      06 Dec 94   SAIC    ACVC 2.0
--
--!

package C3a0005_0 is

   Default_Call : Boolean := False;

   type Button;

   -- Type accesses to procedures Push and Default_Response
   type Button_Response_Ptr is access procedure (B : access Button);

   procedure Push (B : access Button);

   procedure Set_Response (B : access Button; R : in Button_Response_Ptr);

   procedure Default_Response (B : access Button);

   Emergency_Call : Boolean := False;

   procedure Emergency (B : access C3a0005_0.Button);

   type Button is record
      Response : Button_Response_Ptr := Default_Response'Access;
   end record;

end C3a0005_0;