# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
use strict;
use warnings;
use XML::LibXML;

use Test::More tests => 33;

my $eval_return = eval {
  use LaTeXML;
  use LaTeXML::Common::Config;
  1;
};

ok($eval_return && !$@, 'LaTeXML modules loaded successfully.');

my $tex_input = <<'EOQ';
\documentclass{smglom}
\begin{document}
\begin{module}
\symdef{foo}{\text{foo}}
  \begin{definition}[id=foo.def]
    A \defi{foo} (we write $\foo$) is a false object offer. 
  \end{definition}
\end{module}
\end{document}
EOQ
		  
my $config = LaTeXML::Common::Config->new(local=>1, paths=>['./lib/LaTeXML/Package','./lib/LaTeXML/resources/RelaxNG','./lib/LaTeXML/resources/Profiles','./lib/LaTeXML/resources/XSLT']);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $content_query = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:om="http://www.openmath.org/OpenMath" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="anonymous_string#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#omdoc1.theory1" stex:srcref="anonymous_string#textrange(from=3;1,to=8;12)" xml:id="omdoc1.theory1">
    <metadata about="#omdoc1.theory1.metadata1" stex:srcref="anonymous_string#textrange(from=3;1,to=8;12)" xml:id="omdoc1.theory1.metadata1">
      <dc:creator about="#omdoc1.theory1.metadata1.creator1" stex:srcref="anonymous_string#textrange(from=3;1,to=8;12)" xml:id="omdoc1.theory1.metadata1.creator1"/>
      <dc:contributor about="#omdoc1.theory1.metadata1.contributor2" stex:srcref="anonymous_string#textrange(from=3;1,to=8;12)" xml:id="omdoc1.theory1.metadata1.contributor2"/>
      <meta about="#omdoc1.theory1.metadata1.meta3" property="smglom:state" stex:srcref="anonymous_string#textrange(from=3;1,to=8;12)" xml:id="omdoc1.theory1.metadata1.meta3"/>
    </metadata>
    <symbol about="#omdoc1.theory1.symbol2" name="foo" stex:srcref="anonymous_string#textrange(from=4;0,to=4;24)" xml:id="omdoc1.theory1.symbol2"/>
    <notation about="#omdoc1.theory1.notation3" cd="theory1" name="foo" stex:macro_name="foo" stex:nargs="0" stex:srcref="anonymous_string#textrange(from=4;0,to=4;24)" xml:id="omdoc1.theory1.notation3">
      <prototype>
        <om:OMS cd="theory1" name="foo"/>
      </prototype>
      <rendering>
        <text xmlns="http://dlmf.nist.gov/LaTeXML" class="ltx_markedasmath">foo</text>
      </rendering>
    </notation>
    <symbol about="#foo.def.sym" name="foo" stex:srcref="anonymous_string#textrange(from=5;0,to=7;18)" xml:id="foo.def.sym"/>
    <definition about="#foo.def" for="foo" stex:srcref="anonymous_string#textrange(from=5;0,to=7;18)" xml:id="foo.def">
      <CMP about="#foo.def.CMP1" stex:srcref="anonymous_string#textrange(from=5;54,to=6;5)" xml:id="foo.def.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#foo.def.CMP1.p1" stex:srcref="anonymous_string#textrange(from=5;54,to=6;5)" xml:id="foo.def.CMP1.p1">A <definiendum cd="theory1" name="foo">foo</definiendum> (we write <Math about="#foo.def.CMP1.p1.m1" font="italic" mode="inline" stex:srcref="anonymous_string#textrange(from=5;27,to=6;33)" tex="\@foo@construct[default]" text="foo" xml:id="foo.def.CMP1.p1.m1">
            <XMath>
              <XMTok meaning="foo" name="foo" omcd="theory1"/>
            </XMath>
          </Math>) is a false object offer.</p>
      </CMP>
    </definition>
  </theory>
</omdoc>
EOQ

# Remove searchpaths tag
my $xml = XML::LibXML->new;
my $myResponse = $xml->parse_string($response->{result});
$myResponse->removeChild(($myResponse->childNodes())[0]);

is($response->{status_code},0,'Conversion was problem-free.');

my @got_lines = split("\n", $myResponse->toString(1));
my @expected_lines = split("\n", $content_query);
my $index = 0;
while (@got_lines) {
  $index++;
  my $got_line = shift @got_lines;
  my $expected_line = shift @expected_lines;
  is($got_line, $expected_line,'Line $index was different than expected.');
}

