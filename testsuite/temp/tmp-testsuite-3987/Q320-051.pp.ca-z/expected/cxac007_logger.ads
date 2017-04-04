-- CXAC007.A
--
--     The Ada Conformity Assessment Authority (ACAA) holds unlimited
--     rights in the software and documentation contained herein. Unlimited
--     rights are the same as those granted by the U.S. Government for older
--     parts of the Ada Conformity Assessment Test Suite, and are defined
--     in DFAR 252.227-7013(a)(19). By making this public release, the ACAA
--     intends to confer upon all recipients unlimited rights equal to those
--     held by the ACAA. These rights include rights to use, duplicate,
--     release or disclose the released technical data and computer software
--     in whole or in part, in any manner and for any purpose whatsoever, and
--     to have or permit others to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS. THE ACAA MAKES NO EXPRESS OR IMPLIED
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--
--                                     Notice
--
--    The ACAA has created and maintains the Ada Conformity Assessment Test
--    Suite for the purpose of conformity assessments conducted in accordance
--    with the International Standard ISO/IEC 18009 - Ada: Conformity
--    assessment of a language processor. This test suite should not be used
--    to make claims of conformance unless used in accordance with
--    ISO/IEC 18009 and any applicable ACAA procedures.
--
--*
--
-- OBJECTIVE:
--      Check that Stream_IO is preelaborated.
--
-- TEST DESCRIPTION:
--      This test is designed to demonstrate using a logger in a preelaborated
--      package. The logger uses Stream_IO to write to the log as it is the
--      only Ada IO package that can be used in a preelaborated package.
--
--      After writing the log, we close it and read it to verify the expected
--      contents.
--
-- APPLICABILITY CRITERIA:
--      This test is applicable to all implementations capable of supporting
--      external Stream_IO files.
--
--
-- CHANGE HISTORY:
--    16 Nov 2013   GRB   Initial version.
--    27 Nov 2013   RLB   Added headers.
--    18 Apr 2014   RLB   Renamed, revised test as original version was
--                        illegal.
--    19 May 2014   RLB   Added missing name to Legal_File_Name (default
--                        is nonsense as it is called before Test).
--
--!
with Ada.Streams.Stream_Io;
package Cxac007_Logger with
   Preelaborate is

   procedure Log_Item (To : in String; Item : in String);
   -- Write an item to the log file named To.
   -- Note: We have to pass the file name here since it is generated by
   -- the Report package, which is not Preelaborated. In a real program,
   -- the name would most likely come from a constant or function declared
   -- in this package rather than being passed.

end Cxac007_Logger;