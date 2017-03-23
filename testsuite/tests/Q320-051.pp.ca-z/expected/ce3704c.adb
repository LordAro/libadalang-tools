-- CE3704C.ADA

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
--     CHECK THAT INTEGER_IO GET RAISES CONSTRAINT_ERROR IF THE
--     WIDTH PARAMETER IS NEGATIVE, IF THE WIDTH PARAMETER IS
--     GREATER THAN FIELD'LAST WHEN FIELD'LAST IS LESS THAN
--     INTEGER'LAST, OR THE VALUE READ IS OUT OF THE RANGE OF
--     THE ITEM PARAMETER BUT WITHIN THE RANGE OF INSTANTIATED
--     TYPE.

-- HISTORY:
--     SPS 10/04/82
--     DWC 09/09/87  ADDED CASES FOR WIDTH BEING GREATER THAN
--                   FIELD'LAST AND THE VALUE BEING READ IS OUT
--                   OF ITEM'S RANGE BUT WITHIN INSTANTIATED
--                   RANGE.
--     JRL 06/07/96  Added call to Ident_Int in expressions involving
--                   Field'Last, to make the expressions non-static and
--                   prevent compile-time rejection.

with Report;  use Report;
with Text_Io; use Text_Io;

procedure Ce3704c is
   Incomplete : exception;

begin

   Test
     ("CE3704C",
      "CHECK THAT INTEGER_IO GET RAISES " &
      "CONSTRAINT_ERROR IF THE WIDTH PARAMETER " &
      "IS NEGATIVE, IF THE WIDTH PARAMETER IS " &
      "GREATER THAN FIELD'LAST WHEN FIELD'LAST IS " &
      "LESS THAN INTEGER'LAST, OR THE VALUE READ " &
      "IS OUT OF THE RANGE OF THE ITEM PARAMETER " &
      "BUT WITHIN THE RANGE OF INSTANTIATED TYPE");

   declare
      Ft : File_Type;
      type Int is new Integer range 1 .. 10;
      package Iio is new Integer_Io (Int);
      X : Int range 1 .. 5;
      use Iio;
   begin

      begin
         Get (Ft, X, Ident_Int (-1));
         Failed ("CONSTRAINT_ERROR NOT RAISED - FILE");
      exception
         when Constraint_Error =>
            null;
         when Status_Error =>
            Failed ("RAISED STATUS_ERROR");
         when others =>
            Failed ("WRONG EXCEPTION RAISED - FILE");
      end;

      begin
         Get (X, Ident_Int (-6));
         Failed ("CONSTRAINT_ERROR NOT RAISED - DEFAULT");
      exception
         when Constraint_Error =>
            null;
         when others =>
            Failed ("WRONG EXCEPTION RAISED - DEFAULT");
      end;

      begin
         Create (Ft, Out_File, Legal_File_Name);
      exception
         when Use_Error =>
            Not_Applicable
              ("USE_ERROR RAISED; TEXT CREATE " & "WITH OUT_FILE MODE");
            raise Incomplete;
         when Name_Error =>
            Not_Applicable
              ("NAME_ERROR RAISED; TEXT CREATE " & "WITH OUT_FILE MODE");
            raise Incomplete;
      end;

      Put (Ft, 1);
      New_Line (Ft);
      Put (Ft, 8);
      New_Line (Ft);
      Put (Ft, 2);

      Close (Ft);

      begin
         Open (Ft, In_File, Legal_File_Name);
      exception
         when Use_Error =>
            Not_Applicable ("USE_ERROR FOR OPEN " & "WITH IN_FILE MODE");
            raise Incomplete;
      end;

      begin
         Get (Ft, X, Ident_Int (-1));
         Failed
           ("CONSTRAINT_ERROR NOT RAISED - " &
            "NEGATIVE WIDTH WITH EXTERNAL FILE");
      exception
         when Constraint_Error =>
            null;
         when others =>
            Failed
              ("WRONG EXCEPTION RAISED - " &
               "NEGATIVE WIDTH WITH EXTERNAL FILE");
      end;

      Skip_Line (Ft);

      begin
         Get (Ft, X);
         Failed ("CONSTRAINT_ERROR NOT RAISED - " & "OUT OF RANGE");
      exception
         when Constraint_Error =>
            null;
         when others =>
            Failed ("WRONG EXCEPTION RAISED - " & "OUT OF RANGE");
      end;

      Skip_Line (Ft);

      if Field'Last < Integer'Last then
         begin
            Get (Ft, X, Field'Last + Ident_Int (1));
            Failed
              ("CONSTRAINT_ERROR NOT RAISED - " &
               "FIELD'LAST + 1 WIDTH WITH " &
               "EXTERNAL FILE");
         exception
            when Constraint_Error =>
               null;
            when others =>
               Failed
                 ("WRONG EXCEPTION RAISED - " &
                  "FIELD'LAST + 1 WIDTH WITH " &
                  "EXTERNAL FILE");
         end;
      end if;

      begin
         Delete (Ft);
      exception
         when Use_Error =>
            null;
      end;

   exception
      when Incomplete =>
         null;
   end;

   Result;
end Ce3704c;