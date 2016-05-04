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
\begin{module}

  \begin{omtext}
    \inlinedef{This is called \defi{this}}
  \end{omtext}

  \begin{omtext}
    Here is some text \inlinedef{This is called \defi{this}}
  \end{omtext}

  \begin{assertion}
   \inlinedef{This is called \defi{seasdcond}}
  \end{assertion}

  \begin{assertion}
   Ni hall \inlinedef{This is called \defiii{second}{asdf}{gas}}
  \end{assertion}

  \begin{axiom}
   asdf  \inlinedef{This is called \defi{thistry}}
  \end{axiom}

  \begin{axiom}
    \inlinedef{This is called \defi{thisfastry}{gasdg}}
  \end{axiom}

  \begin{example}
     \inlinedef{This is called \defi{ffss}}
  \end{example}

  \begin{example}
     nothign \inlinedef{This is called \defii{asd}{fasd}}
  \end{example}
\end{module}
\end{document}
EOQ
		  
my $perllib = $ENV{'PERL_LOCAL_LIB_ROOT'};
my $bindings = $perllib . '/lib/perl5/LaTeXML/Package';
my $config = LaTeXML::Common::Config->new(paths=>["$bindings"]);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $content_query = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="Literal String \documentc#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#omdoc1.theory1" stex:srcref="Literal String \documentc#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1">
    <metadata about="#omdoc1.theory1.metadata1" stex:srcref="Literal String \documentc#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1">
      <dc:creator about="#omdoc1.theory1.metadata1.creator1" stex:srcref="Literal String \documentc#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1.creator1"/>
      <dc:contributor about="#omdoc1.theory1.metadata1.contributor2" stex:srcref="Literal String \documentc#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1.contributor2"/>
      <meta about="#omdoc1.theory1.metadata1.meta3" property="smglom:state" stex:srcref="Literal String \documentc#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1.meta3"/>
    </metadata>
    <symbol name="this" xml:id="this.def.sym"/>
    <omtext about="#omdoc1.theory1.omtext2" stex:srcref="Literal String \documentc#textrange(from=5;1,to=7;14)" xml:id="omdoc1.theory1.omtext2">
      <CMP about="#omdoc1.theory1.omtext2.CMP1" stex:srcref="Literal String \documentc#textrange(from=6;0,to=6;42)" xml:id="omdoc1.theory1.omtext2.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.omtext2.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=6;0,to=6;42)" xml:id="omdoc1.theory1.omtext2.CMP1.p1"><text class="inlinedef">This is called <definiendum cd="theory1" name="this">this</definiendum></text></p>
      </CMP>
    </omtext>
    <omtext about="#omdoc1.theory1.omtext4" stex:srcref="Literal String \documentc#textrange(from=9;1,to=11;14)" xml:id="omdoc1.theory1.omtext4">
      <CMP about="#omdoc1.theory1.omtext4.CMP1" stex:srcref="Literal String \documentc#textrange(from=9;1,to=9;17)" xml:id="omdoc1.theory1.omtext4.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.omtext4.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=9;1,to=9;17)" xml:id="omdoc1.theory1.omtext4.CMP1.p1">Here is some text <text class="inlinedef">This is called <definiendum cd="theory1" name="this">this</definiendum></text></p>
      </CMP>
    </omtext>
    <symbol name="seasdcond" xml:id="seasdcond.def.sym"/>
    <assertion about="#omdoc1.theory1.assertion5" stex:srcref="Literal String \documentc#textrange(from=13;1,to=15;17)" xml:id="omdoc1.theory1.assertion5">
      <CMP about="#omdoc1.theory1.assertion5.CMP1" stex:srcref="Literal String \documentc#textrange(from=14;0,to=14;46)" xml:id="omdoc1.theory1.assertion5.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.assertion5.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=14;0,to=14;46)" xml:id="omdoc1.theory1.assertion5.CMP1.p1"><text class="inlinedef">This is called <definiendum cd="theory1" name="seasdcond">seasdcond</definiendum></text></p>
      </CMP>
    </assertion>
    <symbol name="second-asdf-gas" xml:id="second-asdf-gas.def.sym"/>
    <assertion about="#omdoc1.theory1.assertion7" stex:srcref="Literal String \documentc#textrange(from=17;1,to=19;17)" xml:id="omdoc1.theory1.assertion7">
      <CMP about="#omdoc1.theory1.assertion7.CMP1" stex:srcref="Literal String \documentc#textrange(from=17;1,to=17;20)" xml:id="omdoc1.theory1.assertion7.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.assertion7.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=17;1,to=17;20)" xml:id="omdoc1.theory1.assertion7.CMP1.p1">Ni hall <text class="inlinedef">This is called <definiendum cd="theory1" name="second-asdf-gas">second asdf gas</definiendum></text></p>
      </CMP>
    </assertion>
    <symbol name="thistry" xml:id="thistry.def.sym"/>
    <axiom about="#omdoc1.theory1.axiom9" stex:srcref="Literal String \documentc#textrange(from=21;1,to=23;13)" xml:id="omdoc1.theory1.axiom9">
      <CMP about="#omdoc1.theory1.axiom9.CMP1" stex:srcref="Literal String \documentc#textrange(from=21;1,to=21;16)" xml:id="omdoc1.theory1.axiom9.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.axiom9.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=21;1,to=21;16)" xml:id="omdoc1.theory1.axiom9.CMP1.p1">asdf <text class="inlinedef">This is called <definiendum cd="theory1" name="thistry">thistry</definiendum></text></p>
      </CMP>
    </axiom>
<!--  %**** String Line 25 **** -->    <symbol name="thisfastry" xml:id="thisfastry.def.sym"/>
    <axiom about="#omdoc1.theory1.axiom11" stex:srcref="Literal String \documentc#textrange(from=25;1,to=27;13)" xml:id="omdoc1.theory1.axiom11">
      <CMP about="#omdoc1.theory1.axiom11.CMP1" stex:srcref="Literal String \documentc#textrange(from=26;0,to=26;55)" xml:id="omdoc1.theory1.axiom11.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.axiom11.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=26;0,to=26;55)" xml:id="omdoc1.theory1.axiom11.CMP1.p1"><text class="inlinedef">This is called <definiendum cd="theory1" name="thisfastry">thisfastry</definiendum>gasdg</text></p>
      </CMP>
    </axiom>
    <symbol name="ffss" xml:id="ffss.def.sym"/>
    <example about="#omdoc1.theory1.example13" stex:srcref="Literal String \documentc#textrange(from=29;1,to=31;15)" xml:id="omdoc1.theory1.example13">
      <CMP about="#omdoc1.theory1.example13.CMP1" stex:srcref="Literal String \documentc#textrange(from=30;0,to=30;43)" xml:id="omdoc1.theory1.example13.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.example13.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=30;0,to=30;43)" xml:id="omdoc1.theory1.example13.CMP1.p1"><text class="inlinedef">This is called <definiendum cd="theory1" name="ffss">ffss</definiendum></text></p>
      </CMP>
    </example>
    <symbol name="asd-fasd" xml:id="asd-fasd.def.sym"/>
    <example about="#omdoc1.theory1.example15" stex:srcref="Literal String \documentc#textrange(from=33;1,to=35;15)" xml:id="omdoc1.theory1.example15">
      <CMP about="#omdoc1.theory1.example15.CMP1" stex:srcref="Literal String \documentc#textrange(from=33;1,to=33;18)" xml:id="omdoc1.theory1.example15.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.example15.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=33;1,to=33;18)" xml:id="omdoc1.theory1.example15.CMP1.p1">nothign <text class="inlinedef">This is called <definiendum cd="theory1" name="asd-fasd">asd fasd</definiendum></text></p>
      </CMP>
    </example>
  </theory>
</omdoc>
EOQ

# Remove searchpaths tag
my $xml = XML::LibXML->new;
my $myResponse = $xml->parse_string($response->{result});
$myResponse->removeChild(($myResponse->childNodes())[0]);

is($response->{status_code},0,'Conversion was problem-free.');
is($myResponse->toString(1),$content_query,'Content query successfully generated');
