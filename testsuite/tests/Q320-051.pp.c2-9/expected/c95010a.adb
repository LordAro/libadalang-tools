-- C95010A.ADA

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
-- CHECK THAT A TASK MAY CONTAIN MORE THAN ONE ACCEPT_STATEMENT
--   FOR AN ENTRY.

-- THIS TEST CONTAINS SHARED VARIABLES.

-- JRK 11/5/81
-- JWC 6/28/85   RENAMED TO -AB

with Report; use Report;
procedure C95010a is

   V : Integer := 0;

begin
   Test
     ("C95010A",
      "CHECK THAT A TASK MAY CONTAIN MORE THAN " &
      "ONE ACCEPT_STATEMENT FOR AN ENTRY");

   declare

      subtype Int is Integer range 1 .. 5;

      task T is
         entry E;
         entry Ef (Int) (I : Integer);
      end T;

      task body T is
      begin
         V := 1;
         accept E;
         V := 2;
         accept E;
         V := 3;
         accept Ef (2) (I : Integer) do
            V := I;
         end Ef;
         V := 5;
         accept Ef (2) (I : Integer) do
            V := I;
         end Ef;
         V := 7;
      end T;

   begin

      T.E;
      T.E;
      T.Ef (2) (4);
      T.Ef (2) (6);

   end;

   if V /= 7 then
      Failed ("WRONG CONTROL FLOW VALUE");
   end if;

   Result;
end C95010a;