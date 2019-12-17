# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML
#**********************************************************************
use LaTeXML::Util::STeXTest;

latexml_stex_testall(
    "t/tests/omdoc/01-pathsuris",
    "t/tests/omdoc/02-metakeys",
    "t/tests/omdoc/03-presentation",
    "t/tests/omdoc/04-sref",
    "t/tests/omdoc/05-cmath",
    "t/tests/omdoc/06-workaddress",
    "t/tests/omdoc/07-modules",
    "t/tests/omdoc/08-omdoc",
    "t/tests/omdoc/09-sproof",
    "t/tests/omdoc/10-dcm",
    "t/tests/omdoc/11-omtext",
    "t/tests/omdoc/12-structview",
    "t/tests/omdoc/13-statements",
    "t/tests/omdoc/14-smultiling",
    "t/tests/omdoc/15-stex",
    "t/tests/omdoc/16-problem",
    "t/tests/omdoc/17-tikzinput",
    "t/tests/omdoc/18-smglom",
    "t/tests/omdoc/19-mikoslides",
    "t/tests/omdoc/20-hwexam",
    "t/tests/omdoc/21-mathhub"
);
