-- C97205B.ADA

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
-- CHECK THAT IF THE RENDEZVOUS IS IMMEDIATELY POSSIBLE (FOR A CONDITIONAL
-- ENTRY CALL), IT IS PERFORMED.

-- CASE B: ENTRY FAMILY; THE CALLED TASK IS EXECUTING A SELECTIVE WAIT.

-- WRG 7/13/86
-- PWN 09/11/94 REMOVED PRAGMA PRIORITY FOR ADA 9X.

with Report; use Report;
with System; use System;
procedure C97205b is

   Rendezvous_Occurred            : Boolean  := False;
   Statements_After_Call_Executed : Boolean  := False;
   Count                          : Positive := 1;

begin

   Test
     ("C97205B",
      "CHECK THAT IF THE RENDEZVOUS IS IMMEDIATELY " &
      "POSSIBLE (FOR A CONDITIONAL ENTRY CALL), IT " &
      "IS PERFORMED");

   declare

      task T is
         entry E (1 .. 3) (B : in out Boolean);
      end T;

      task body T is
      begin
         select
            accept E (2) (B : in out Boolean) do
               B := Ident_Bool (True);
            end E;
         or
            accept E (3) (B : in out Boolean);
            Failed ("NONEXISTENT ENTRY CALL ACCEPTED");
         end select;
      end T;

   begin

      while not Statements_After_Call_Executed loop
         delay 1.0;

         select
            T.E (2) (Rendezvous_Occurred);
            Statements_After_Call_Executed := Ident_Bool (True);
         else
            if Count < 60 * 60 then
               Count := Count + 1;
            else
               Failed ("NO RENDEZVOUS AFTER AT LEAST ONE " & "HOUR ELAPSED");
               exit;
            end if;
         end select;
      end loop;

   end;

   if not Rendezvous_Occurred then
      Failed ("RENDEZVOUS DID NOT OCCUR");
   end if;

   if Count > 1 then
      Comment ("DELAYED" & Positive'Image (Count) & " SECONDS");
   end if;

   Result;

end C97205b;