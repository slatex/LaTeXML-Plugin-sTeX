# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
use strict;
use warnings;
use XML::LibXML;

use Test::More tests => 51;

my $eval_return = eval {
  use LaTeXML;
  use LaTeXML::Common::Config;
  1;
};

ok($eval_return && !$@, 'LaTeXML modules loaded successfully.');

my $tex_input = <<'EOQ';
\documentclass{omdoc}
\begin{document}
\begin{assertion}[id=hello, type=lemma]
  $ Waohwer asd_x $
\end{assertion}

\begin{axiom}[id=newAx]
 Thiasdf is not wokraw.
\end{axiom}

\begin{definition}[id=test.one]
 \defi{concept} is this
 \defii{new}{concerpt}
 \defiii{old}{new}{concerpt}
 \defiv{quasi}{old}{new}{concerpt}
\end{definition}

\begin{omtext}
 \trefi{concept}
 \trefii{new}{concerpt}
 \trefiiv{old}{new}{concerpt}
\end{omtext}

\begin{definition}[id=test.two]
 \defi[name=one]{concept} is this
 \defii[name=two]{new}{concerpt}
 \defiii[name=three]{old}{new}{concerpt}
 \defiv[name=four]{quasi}{old}{new}{concerpt}
\end{definition}

\begin{omtext}
 \trefi{concept}
 \trefii{new}{concerpt}
 \trefiiv{old}{new}{concerpt}
\end{omtext}
\end{document}
EOQ
		  
my $config = LaTeXML::Common::Config->new(local=>1, paths=>['./lib/LaTeXML/Package','./lib/LaTeXML/resources/RelaxNG','./lib/LaTeXML/resources/Profiles','./lib/LaTeXML/resources/XSLT'],profile=>'stex-smglom');
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $target_xml = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="anonymous_string#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <assertion about="#hello" stex:srcref="anonymous_string#textrange(from=3;0,to=5;15)" type="lemma" xml:id="hello">
    <CMP about="#hello.CMP1" stex:srcref="anonymous_string#textrange(from=3;15,to=4;19)" xml:id="hello.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#hello.CMP1.p1" stex:srcref="anonymous_string#textrange(from=3;15,to=4;19)" xml:id="hello.CMP1.p1"><Math about="#hello.CMP1.p1.m1" font="italic" mode="inline" stex:srcref="anonymous_string#textrange(from=3;15,to=4;19)" tex="Waohwerasd_{x}" text="W * a * o * h * w * e * r * a * s * d _ x" xml:id="hello.CMP1.p1.m1">
          <XMath>
            <XMApp>
              <XMTok meaning="times" role="MULOP">⁢</XMTok>
              <XMTok mode="math" role="UNKNOWN">W</XMTok>
              <XMTok mode="math" role="UNKNOWN">a</XMTok>
              <XMTok mode="math" role="UNKNOWN">o</XMTok>
              <XMTok mode="math" role="UNKNOWN">h</XMTok>
              <XMTok mode="math" role="UNKNOWN">w</XMTok>
              <XMTok mode="math" role="UNKNOWN">e</XMTok>
              <XMTok mode="math" role="UNKNOWN">r</XMTok>
              <XMTok mode="math" role="UNKNOWN">a</XMTok>
              <XMTok mode="math" role="UNKNOWN">s</XMTok>
              <XMApp>
                <XMTok role="SUBSCRIPTOP" scriptpos="post3"/>
                <XMTok mode="math" role="UNKNOWN">d</XMTok>
                <XMTok fontsize="70%" mode="math" role="UNKNOWN" rule="Subscript">x</XMTok>
              </XMApp>
            </XMApp>
          </XMath>
        </Math></p>
    </CMP>
  </assertion>
  <axiom about="#newAx" stex:srcref="anonymous_string#textrange(from=7;0,to=9;11)" xml:id="newAx">
    <CMP about="#newAx.CMP1" stex:srcref="anonymous_string#textrange(from=7;21,to=8;2)" xml:id="newAx.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#newAx.CMP1.p1" stex:srcref="anonymous_string#textrange(from=7;21,to=8;2)" xml:id="newAx.CMP1.p1">Thiasdf is not wokraw.</p>
    </CMP>
  </axiom>
  <omtext about="#test.one" stex:srcref="anonymous_string#textrange(from=11;0,to=15;16)" type="definition" xml:id="test.one">
    <CMP about="#test.one.CMP1" stex:srcref="anonymous_string#textrange(from=11;0,to=15;16)" xml:id="test.one.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#test.one.CMP1.p1" stex:srcref="anonymous_string#textrange(from=11;7,to=12;16)" xml:id="test.one.CMP1.p1"><definiendum name="concept">concept</definiendum> is this
<definiendum name="new-concerpt">new concerpt</definiendum>
<definiendum name="old-new-concerpt">old new concerpt</definiendum></p>
    </CMP>
  </omtext>
  <omtext about="#omdoc1.omtext4" stex:srcref="anonymous_string#textrange(from=17;1,to=21;16)" type="definition" xml:id="omdoc1.omtext4">
    <CMP about="#omdoc1.omtext4.CMP1" stex:srcref="anonymous_string#textrange(from=17;1,to=21;16)" xml:id="omdoc1.omtext4.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.omtext4.CMP1.p1" stex:srcref="anonymous_string#textrange(from=18;0,to=20;29)" xml:id="omdoc1.omtext4.CMP1.p1"><term about="#omdoc1.omtext4.CMP1.p1.term1" name="concept" stex:srcref="anonymous_string#textrange(from=18;0,to=18;16)" xml:id="omdoc1.omtext4.CMP1.p1.term1">concept</term>
<term about="#omdoc1.omtext4.CMP1.p1.term2" name="new-concerpt" stex:srcref="anonymous_string#textrange(from=19;0,to=19;23)" xml:id="omdoc1.omtext4.CMP1.p1.term2">new concerpt</term>
<term about="#omdoc1.omtext4.CMP1.p1.term3" name="old-new-concerpt" stex:srcref="anonymous_string#textrange(from=20;0,to=20;29)" xml:id="omdoc1.omtext4.CMP1.p1.term3">old new concerpt</term></p>
    </CMP>
  </omtext>
</omdoc>
EOQ

# Remove searchpaths tag
my $xml = XML::LibXML->new;
my $myResponse = $xml->parse_string($response->{result});
$myResponse->removeChild(($myResponse->childNodes())[0]);

is($response->{status_code},0,'Conversion was problem-free.');
my @got_lines = split("\n", $myResponse->toString(1));
my @expected_lines = split("\n", $target_xml);
my $index = 0;
while (@got_lines) {
  $index++;
  my $got_line = shift @got_lines;
  my $expected_line = shift @expected_lines;
  is($got_line, $expected_line,"Compared line $index of XML output.");
}
