
WITH REPORT; USE REPORT;
PRAGMA ELABORATE (REPORT);
PACKAGE BODY C94004C_PKG IS

     TASK BODY TT IS
          I : INTEGER := IDENT_INT (120);
     BEGIN
          ACCEPT E;
          COMMENT ("DELAY LIBRARY TASK FOR TWO MINUTES");
          DELAY DURATION(I);
          -- MAIN PROGRAM SHOULD NOW BE TERMINATED.
          RESULT;
          -- USE LOOP FOR SELECTIVE WAIT WITH TERMINATE.
          LOOP
               SELECT
                    ACCEPT E;
               OR
                    TERMINATE;
               END SELECT;
          END LOOP;
          -- FAILS IF JOB HANGS UP WITHOUT TERMINATING.
     END TT;

END C94004C_PKG;