-- C67002E.ADA

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
-- CHECK THAT ALL OPERATOR SYMBOLS CAN BE USED IN (OVERLOADED) FUNCTION
-- SPECIFICATIONS WITH THE REQUIRED NUMBER OF PARAMETERS. THIS TEST CHECKS
-- RENAMING DECLARATIONS FOR THESE FUNCTIONS.
--   SUBTESTS ARE:
--        (A) THROUGH (P): "=", "AND", "OR", "XOR", "<", "<=",
--             ">", ">=", "&", "*", "/", "MOD", "REM", "**", "+", "-",
--             RESPECTIVELY.  ALL OF THESE HAVE TWO PARAMETERS.
--        (Q), (R), (S), AND (T): "+", "-", "NOT", "ABS", RESPECTIVELY,
--             WITH ONE PARAMETER.

-- CPP 6/26/84

with Report; use Report;
procedure C67002e is

   function Two_Params (I1, I2 : Integer) return Character is
   begin
      if I1 > I2 then
         return 'G';
      else
         return 'L';
      end if;
   end Two_Params;

   function One_Param (I1 : Integer) return Character is
   begin
      if I1 < Ident_Int (0) then
         return 'N';
      else
         return 'P';
      end if;
   end One_Param;

begin
   Test
     ("C67002E",
      "USE OF OPERATOR SYMBOLS IN " & "(OVERLOADED) FUNCTION SPECIFICATIONS");

   -------------------------------------------------

   declare -- (A)

      package Pkg is
         type Lp is limited private;
         function "=" (Lpa, Lpb : Lp) return Boolean;
      private
         type Lp is new Integer;
      end Pkg;
      use Pkg;

      Lp1, Lp2 : Lp;

      function "=" (Lpa, Lpb : Lp) return Boolean renames Pkg."=";

      package body Pkg is
         function "=" (Lpa, Lpb : Lp) return Boolean is
         begin
            return Lpa > Lpb;
         end "=";
      begin
         Lp1 := Lp (Ident_Int (7));
         Lp2 := Lp (Ident_Int (8));
      end Pkg;

   begin -- (A)
      if (Lp1 = Lp2) or not (Lp2 = Lp1) or (Lp1 = Lp1) or (Lp2 /= Lp1) then
         Failed ("OVERLOADING OF ""="" OPERATOR DEFECTIVE");
      end if;
   end; -- (A)

   -------------------------------------------------

   declare -- (B)
      function "AND" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (B)
      if (Ident_Int (10) and 1) /= 'G' or (5 and 10) /= 'L' then
         Failed ("OVERLOADING OF ""AND"" OPERATOR DEFECTIVE");
      end if;
   end; -- (B)

   -------------------------------------------------

   declare -- (C)
      function "OR" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (C)
      if (Ident_Int (10) or 1) /= 'G' or (5 or 10) /= 'L' then
         Failed ("OVERLOADING OF ""OR"" OPERATOR DEFECTIVE");
      end if;
   end; -- (C)

   -------------------------------------------------

   declare -- (D)
      function "XOR" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (D)
      if (Ident_Int (10) xor 1) /= 'G' or (5 xor 10) /= 'L' then
         Failed ("OVERLOADING OF ""XOR"" OPERATOR DEFECTIVE");
      end if;
   end; -- (D)

   -------------------------------------------------

   declare -- (E)
      function "<" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (E)
      if (Ident_Int (10) < 1) /= 'G' or (5 < 10) /= 'L' then
         Failed ("OVERLOADING OF ""<"" OPERATOR DEFECTIVE");
      end if;
   end; -- (E)

   -------------------------------------------------

   declare -- (F)
      function "<=" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (F)
      if (Ident_Int (10) <= 1) /= 'G' or (5 <= 10) /= 'L' then
         Failed ("OVERLOADING OF ""<="" OPERATOR DEFECTIVE");
      end if;
   end; -- (F)

   -------------------------------------------------

   declare -- (G)
      function ">" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (G)
      if (Ident_Int (10) > 1) /= 'G' or (5 > 10) /= 'L' then
         Failed ("OVERLOADING OF "">"" OPERATOR DEFECTIVE");
      end if;
   end; -- (G)

   -------------------------------------------------

   declare -- (H)
      function ">=" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (H)
      if (Ident_Int (10) >= 1) /= 'G' or (5 >= 10) /= 'L' then
         Failed ("OVERLOADING OF "">="" OPERATOR DEFECTIVE");
      end if;
   end; -- (H)

   -------------------------------------------------

   declare -- (I)
      function "&" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (I)
      if (Ident_Int (10) & 1) /= 'G' or (5 & 10) /= 'L' then
         Failed ("OVERLOADING OF ""&"" OPERATOR DEFECTIVE");
      end if;
   end; -- (I)

   -------------------------------------------------

   declare -- (J)
      function "*" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (J)
      if (Ident_Int (10) * 1) /= 'G' or (5 * 10) /= 'L' then
         Failed ("OVERLOADING OF ""*"" OPERATOR DEFECTIVE");
      end if;
   end; -- (J)

   -------------------------------------------------

   declare -- (K)
      function "/" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (K)
      if (Ident_Int (10) / 1) /= 'G' or (5 / 10) /= 'L' then
         Failed ("OVERLOADING OF ""/"" OPERATOR DEFECTIVE");
      end if;
   end; -- (K)

   -------------------------------------------------

   declare -- (L)
      function "MOD" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (L)
      if (Ident_Int (10) mod 1) /= 'G' or (5 mod 10) /= 'L' then
         Failed ("OVERLOADING OF ""MOD"" OPERATOR DEFECTIVE");
      end if;
   end; -- (L)

   -------------------------------------------------

   declare -- (M)
      function "REM" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (M)
      if (Ident_Int (10) rem 1) /= 'G' or (5 rem 10) /= 'L' then
         Failed ("OVERLOADING OF ""REM"" OPERATOR DEFECTIVE");
      end if;
   end; -- (M)

   -------------------------------------------------

   declare -- (N)
      function "**" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (N)
      if (Ident_Int (10)**1) /= 'G' or (5**10) /= 'L' then
         Failed ("OVERLOADING OF ""**"" OPERATOR DEFECTIVE");
      end if;
   end; -- (N)

   -------------------------------------------------

   declare -- (O)
      function "+" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (O)
      if (Ident_Int (10) + 1) /= 'G' or (5 + 10) /= 'L' then
         Failed ("OVERLOADING OF ""+"" OPERATOR DEFECTIVE");
      end if;
   end; -- (O)

   -------------------------------------------------

   declare -- (P)
      function "-" (I1, I2 : Integer) return Character renames Two_Params;

   begin -- (P)
      if (Ident_Int (10) - 1) /= 'G' or (5 - 10) /= 'L' then
         Failed ("OVERLOADING OF ""-"" OPERATOR DEFECTIVE");
      end if;
   end; -- (P)

   -------------------------------------------------

   declare -- (Q)
      function "+" (I1 : Integer) return Character renames One_Param;

   begin -- (Q)
      if (+Ident_Int (25) /= 'P') or (+(0 - 25) /= 'N') then
         Failed ("OVERLOADING OF ""+"" " & "OPERATOR (ONE OPERAND) DEFECTIVE");
      end if;
   end; -- (Q)

   -------------------------------------------------

   declare -- (R)
      function "-" (I1 : Integer) return Character renames One_Param;

   begin -- (R)
      if (-Ident_Int (25) /= 'P') or (-(0 - 25) /= 'N') then
         Failed ("OVERLOADING OF ""-"" " & "OPERATOR (ONE OPERAND) DEFECTIVE");
      end if;
   end; -- (R)

   -------------------------------------------------

   declare -- (S)
      function "NOT" (I1 : Integer) return Character renames One_Param;

   begin -- (S)
      if (not Ident_Int (25) /= 'P') or (not (0 - 25) /= 'N') then
         Failed
           ("OVERLOADING OF ""NOT"" " & "OPERATOR (ONE OPERAND) DEFECTIVE");
      end if;
   end; -- (S)

   -------------------------------------------------

   declare -- (T)
      function "ABS" (I1 : Integer) return Character renames One_Param;

   begin -- (T)
      if (abs Ident_Int (25) /= 'P') or (abs (0 - 25) /= 'N') then
         Failed
           ("OVERLOADING OF ""ABS"" " & "OPERATOR (ONE OPERAND) DEFECTIVE");
      end if;
   end; -- (T)

   -------------------------------------------------

   Result;
end C67002e;