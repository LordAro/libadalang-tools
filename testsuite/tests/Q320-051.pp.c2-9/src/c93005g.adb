
WITH REPORT, C93005G_PK1;
USE  REPORT, C93005G_PK1;
WITH SYSTEM; USE SYSTEM;
PROCEDURE C93005G IS


BEGIN

     TEST("C93005G", "TEST EXCEPTIONS TERMINATE NOT YET ACTIVATED " &
                     "TASKS");

     COMMENT("SUBTEST 5: TASK IN STATEMENT PART OF BLOCK");
     COMMENT("  THE TASKS DON'T DEPEND ON THE DECLARATIVE PART");
B51: DECLARE
          X : MNT;
     BEGIN
B52:      DECLARE
               Y   : MNT;
               PTR : ACC_BAD_REC;
          BEGIN
               PTR := NEW BAD_REC;
               FAILED ("EXCEPTION NOT RAISED");
          EXCEPTION
               WHEN CONSTRAINT_ERROR =>
                    NULL;
               WHEN OTHERS =>
                    FAILED ("WRONG EXCEPTION IN B52");
          END B52;

          COMMENT ("SUBTEST 5: COMPLETED");
     EXCEPTION
          WHEN OTHERS =>
               FAILED ("EXCEPTION NOT ABSORBED");
     END B51;

     CHECK;

     RESULT;

EXCEPTION
     WHEN OTHERS =>
          FAILED ("EXCEPTION NOT ABSORBED");
          RESULT;
END C93005G;