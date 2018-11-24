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
\begin{omtext}[title=newTitle, type=abstract]
 Ni hao me.
\end{omtext}

\begin{omtext}[type=introduction]
 \nlex{If \coreft{hello}1 owns \corefs{he}2.}
\end{omtext}
\end{document}
EOQ
		  
my $config = LaTeXML::Common::Config->new(local=>1, paths=>['./lib/LaTeXML/Package','./lib/LaTeXML/resources/RelaxNG','./lib/LaTeXML/resources/Profiles','./lib/LaTeXML/resources/XSLT']);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $content_query = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="Literal String \documentc#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <omtext about="#omdoc1.omtext1" stex:srcref="Literal String \documentc#textrange(from=3;0,to=5;12)" type="abstract" xml:id="omdoc1.omtext1">
    <metadata about="#omdoc1.omtext1.metadata1" stex:srcref="Literal String \documentc#textrange(from=3;0,to=5;12)" xml:id="omdoc1.omtext1.metadata1">
      <dc:title about="#omdoc1.omtext1.metadata1.title1" stex:srcref="Literal String \documentc#textrange(from=3;0,to=5;12)" xml:id="omdoc1.omtext1.metadata1.title1">newTitle</dc:title>
    </metadata>
    <CMP about="#omdoc1.omtext1.CMP2" stex:srcref="Literal String \documentc#textrange(from=3;0,to=3;45)" xml:id="omdoc1.omtext1.CMP2">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.omtext1.CMP2.p1" stex:srcref="Literal String \documentc#textrange(from=3;0,to=3;45)" xml:id="omdoc1.omtext1.CMP2.p1">Ni hao me.</p>
    </CMP>
  </omtext>
  <omtext about="#omdoc1.omtext2" stex:srcref="Literal String \documentc#textrange(from=7;0,to=9;12)" type="introduction" xml:id="omdoc1.omtext2">
    <CMP about="#omdoc1.omtext2.CMP1" stex:srcref="Literal String \documentc#textrange(from=8;0,to=8;45)" xml:id="omdoc1.omtext2.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.omtext2.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=8;0,to=8;45)" xml:id="omdoc1.omtext2.CMP1.p1"><text class="nlex">If <text class="coref-target" stex:index="1">hello</text> owns <text class="coref-source" stex:index="2">he</text>.</text></p>
    </CMP>
  </omtext>
</omdoc>
EOQ

# Remove searchpaths tag
my $xml = XML::LibXML->new;
my $myResponse = $xml->parse_string($response->{result});
$myResponse->removeChild(($myResponse->childNodes())[0]);

is($response->{status_code},0,'Conversion was problem-free.');
is($myResponse->toString(1),$content_query,'Content query successfully generated');
