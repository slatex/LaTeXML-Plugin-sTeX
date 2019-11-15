# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
use strict;
use warnings;
use XML::LibXML;

use Test::More tests => 3;

my $eval_return = eval {
  use LaTeXML;
  use LaTeXML::Common::Config;
  1;
};

ok($eval_return && !$@, 'LaTeXML modules loaded successfully.');

my $tex_input = <<'EOQ';
\documentclass{smglom}
\begin{document}
\begin{modsig}{foo}
  \symdef{foo}{\text{foo}}
  \symtest{foo}{\foo}
\end{modsig}
\end{document}
EOQ

my $config = LaTeXML::Common::Config->new(local=>1, paths=>['./lib/LaTeXML/Package','./lib/LaTeXML/resources/RelaxNG','./lib/LaTeXML/resources/Profiles','./lib/LaTeXML/resources/XSLT']);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $content_query = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:ltx="http://dlmf.nist.gov/LaTeXML" xmlns:om="http://www.openmath.org/OpenMath" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="anonymous_string#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#foo" stex:srcref="anonymous_string#textrange(from=3;0,to=6;12)" xml:id="foo">
    <symbol about="#foo.symbol1" name="foo" stex:srcref="anonymous_string#textrange(from=4;0,to=4;26)" xml:id="foo.symbol1"/>
    <notation about="#foo.notation2" cd="foo" name="foo" stex:macro_name="foo" stex:nargs="0" stex:srcref="anonymous_string#textrange(from=4;0,to=4;26)" xml:id="foo.notation2">
      <prototype>
        <om:OMS cd="foo" name="foo"/>
      </prototype>
      <rendering>
        <ltx:text class="ltx_markedasmath">foo</ltx:text>
      </rendering>
    </notation>
  </theory>
</omdoc>
EOQ

# Remove searchpaths tag
my $xml = XML::LibXML->new;
my $myResponse = $xml->parse_string($response->{result});
$myResponse->removeChild(($myResponse->childNodes())[0]);

is($response->{status_code},0,'Conversion was problem-free.');
is($myResponse->toString(1),$content_query,'Content query successfully generated');
