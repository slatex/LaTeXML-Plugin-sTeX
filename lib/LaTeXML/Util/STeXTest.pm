package LaTeXML::Util::STeXTest;

use LaTeXML::Util::Test;
use base qw(Exporter);
our @EXPORT = (qw(&latexml_stex_tests),
  @LaTeXML::Util::Test::EXPORT);

sub latexml_stex_tests {
    my ($folder, @rest) = @_;
    return latexml_tests($folder, core_options => {
        preload => [],
        searchpaths => [
            './lib/LaTeXML/Package',
            './lib/LaTeXML/resources/RelaxNG',
            './lib/LaTeXML/resources/Profiles',
            './lib/LaTeXML/resources/XSLT'
        ],
        includecomments => 0,
        verbosity => -2,
    }, @rest);
}

### To manually run a test, use:
# latexmlc --path './lib/LaTeXML/Package' --path './lib/LaTeXML/resources/RelaxNG' --path './lib/LaTeXML/resources/Profiles' --path './lib/LaTeXML/resources/XSLT' /path/to/test.tex --destination /path/to/output.xml
### Then Manually remove the <?latexml searchpaths=...> line (because it contains absolute paths)
### It will be ignored by the tests
