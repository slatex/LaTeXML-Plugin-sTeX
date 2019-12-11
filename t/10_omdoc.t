# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML
#**********************************************************************
use LaTeXML::Util::STeXTest;

latexml_stex_testall(
    "t/tests/omdoc/pathsuris",
    "t/tests/omdoc/metakeys",
    "t/tests/omdoc/presentation",
    "t/tests/omdoc/sref",
    "t/tests/omdoc/cmath",
    "t/tests/omdoc/workaddress",
    "t/tests/omdoc/modules"
);
