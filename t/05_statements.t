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
\end{definition}

\begin{definition}
 \trefi{concept}
 \trefii{new}{concerpt}
 \trefiii{old}{new}{concerpt}
\end{definition}
\end{document}
EOQ
		  
my $config = LaTeXML::Common::Config->new(paths=>['blib/lib/LaTeXML/resources/Profiles',
						  'blib/lib/LaTeXML/Package',
						  '../sTeX/sty/etc']);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $content_query = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="Literal String \documentc#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <assertion about="#hello" stex:srcref="Literal String \documentc#textrange(from=3;0,to=5;15)" type="lemma" xml:id="hello">
    <CMP about="#hello.CMP1" stex:srcref="Literal String \documentc#textrange(from=3;0,to=5;15)" xml:id="hello.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#hello.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=3;15,to=4;19)" xml:id="hello.CMP1.p1"><Math about="#hello.CMP1.p1.m1" mode="inline" stex:srcref="Literal String \documentc#textrange(from=3;15,to=4;19)" tex="Waohwerasd_{x}" text="W * a * o * h * w * e * r * a * s * d _ x" xml:id="hello.CMP1.p1.m1">
          <XMath>
            <XMApp>
              <XMTok meaning="times" role="MULOP">⁢</XMTok>
              <XMTok font="italic" role="UNKNOWN">W</XMTok>
              <XMTok font="italic" role="UNKNOWN">a</XMTok>
              <XMTok font="italic" role="UNKNOWN">o</XMTok>
              <XMTok font="italic" role="UNKNOWN">h</XMTok>
              <XMTok font="italic" role="UNKNOWN">w</XMTok>
              <XMTok font="italic" role="UNKNOWN">e</XMTok>
              <XMTok font="italic" role="UNKNOWN">r</XMTok>
              <XMTok font="italic" role="UNKNOWN">a</XMTok>
              <XMTok font="italic" role="UNKNOWN">s</XMTok>
              <XMApp>
                <XMTok role="SUBSCRIPTOP" scriptpos="post3"/>
                <XMTok font="italic" role="UNKNOWN">d</XMTok>
                <XMTok font="italic" role="UNKNOWN">x</XMTok>
              </XMApp>
            </XMApp>
          </XMath>
        </Math></p>
    </CMP>
  </assertion>
  <axiom about="#newAx" stex:srcref="Literal String \documentc#textrange(from=7;0,to=9;11)" xml:id="newAx">
    <CMP about="#newAx.CMP1" stex:srcref="Literal String \documentc#textrange(from=7;0,to=9;11)" xml:id="newAx.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#newAx.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=7;0,to=7;23)" xml:id="newAx.CMP1.p1">Thiasdf is not wokraw.</p>
    </CMP>
  </axiom>
  <omtext about="#test.one" stex:srcref="Literal String \documentc#textrange(from=11;0,to=15;16)" type="definition" xml:id="test.one">
    <CMP about="#test.one.CMP1" stex:srcref="Literal String \documentc#textrange(from=11;0,to=15;16)" xml:id="test.one.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#test.one.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=11;7,to=12;16)" xml:id="test.one.CMP1.p1"><term about="#test.one.CMP1.p1.term1" name="concept" role="definiendum" stex:srcref="Literal String \documentc#textrange(from=11;7,to=12;16)" xml:id="test.one.CMP1.p1.term1">concept</term> is this
<term about="#test.one.CMP1.p1.term2" name="new-concerpt" role="definiendum" stex:srcref="Literal String \documentc#textrange(from=13;1,to=13;23)" xml:id="test.one.CMP1.p1.term2">new concerpt</term>
<term about="#test.one.CMP1.p1.term3" name="old-new-concerpt" role="definiendum" stex:srcref="Literal String \documentc#textrange(from=14;1,to=14;29)" xml:id="test.one.CMP1.p1.term3">old new concerpt</term></p>
    </CMP>
  </omtext>
  <omtext about="#omdoc1.omtext4" stex:srcref="Literal String \documentc#textrange(from=17;1,to=21;16)" type="definition" xml:id="omdoc1.omtext4">
    <CMP about="#omdoc1.omtext4.CMP1" stex:srcref="Literal String \documentc#textrange(from=17;1,to=21;16)" xml:id="omdoc1.omtext4.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.omtext4.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=18;0,to=18;16)" xml:id="omdoc1.omtext4.CMP1.p1"><term about="#omdoc1.omtext4.CMP1.p1.term1" name="concept" stex:srcref="Literal String \documentc#textrange(from=18;0,to=18;16)" xml:id="omdoc1.omtext4.CMP1.p1.term1">concept</term>
<term about="#omdoc1.omtext4.CMP1.p1.term2" name="new-concerpt" stex:srcref="Literal String \documentc#textrange(from=19;0,to=19;23)" xml:id="omdoc1.omtext4.CMP1.p1.term2">new concerpt</term>
<term about="#omdoc1.omtext4.CMP1.p1.term3" name="old-new-concerpt" stex:srcref="Literal String \documentc#textrange(from=20;0,to=20;29)" xml:id="omdoc1.omtext4.CMP1.p1.term3">old new concerpt</term></p>
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
