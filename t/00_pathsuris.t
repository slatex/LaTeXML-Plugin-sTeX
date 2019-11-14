# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML
#**********************************************************************
use LaTeXML::Util::STeXTest;

### To manually run a test, use:
# latexmlc --path './lib/LaTeXML/Package' --path './lib/LaTeXML/resources/RelaxNG' --path './lib/LaTeXML/resources/Profiles' --path './lib/LaTeXML/resources/XSLT' --nocomment /path/to/test.tex --destination /path/to/output.xml
### Then Manually remove the <?latexml searchpaths=...> line (because it contains absolute paths)
### It will be ignored by the tests

latexml_stex_tests("t/tests/omdoc/pathsuris");

# latexmlpost --path '/home/jazzpirate/work/ext/LaTeXML-Plugin-sTeX/lib/LaTeXML/Package' --path '/home/jazzpirate/work/ext/LaTeXML-Plugin-sTeX/lib/LaTeXML/resources/RelaxNG' --path '/home/jazzpirate/work/ext/LaTeXML-Plugin-sTeX/lib/LaTeXML/resources/Profiles' --path '/home/jazzpirate/work/ext/LaTeXML-Plugin-sTeX/lib/LaTeXML/resources/XSLT' nappa.xml --destination nappa.omdoc 

# latexmlc ?.tex --profile=stex-smglom-module --path=/home/jazzpirate/work/sty --destination=?.omdoc
