# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
use strict;
use warnings;
use XML::LibXML;
use Test::More tests => 62;

my $eval_return = eval {
  use LaTeXML;
  use LaTeXML::Common::Config;
  1;
};

ok($eval_return && !$@, 'LaTeXML modules loaded successfully.');

my $tex_input = <<'EOQ';
\documentclass{omdoc}
\begin{document}
\begin{module}[id=foo]

  \begin{omtext}
    \inlinedef{This is called \defi{this}}
  \end{omtext}

  \begin{omtext}
    Here is some text \inlinedef{This is called \defi{this2}}
  \end{omtext}

  \begin{assertion}[type=theorem]
   \inlinedef{This is called \defi{second}}
  \end{assertion}

  \begin{assertion}[type=remark]
   Ni hall \inlinedef{This is called \defiii{second}{word}{word2}}
  \end{assertion}

  \begin{axiom}
   word  \inlinedef{This is called \defi{fourth}}
  \end{axiom}

  \begin{axiom}
    \inlinedef{This is called \defi{fifth}{sixth}}
  \end{axiom}

  \begin{example}
     \inlinedef{This is called \defi{seventh}}
  \end{example}

  \begin{example}
     nothing \inlinedef{This is called \defii{word3}{word4}}
  \end{example}
\end{module}
\end{document}
EOQ
		  
my $config = LaTeXML::Common::Config->new(local=>1, paths=>['./lib/LaTeXML/Package','./lib/LaTeXML/resources/RelaxNG','./lib/LaTeXML/resources/Profiles','./lib/LaTeXML/resources/XSLT']);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
print STDERR "\n", $$response{log},"\n";
my $target_xml = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="anonymous_string#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#omdoc1.theory1" stex:srcref="anonymous_string#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1">
    <metadata about="#omdoc1.theory1.metadata1" stex:srcref="anonymous_string#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1">
      <dc:creator about="#omdoc1.theory1.metadata1.creator1" stex:srcref="anonymous_string#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1.creator1"/>
      <dc:contributor about="#omdoc1.theory1.metadata1.contributor2" stex:srcref="anonymous_string#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1.contributor2"/>
      <meta about="#omdoc1.theory1.metadata1.meta3" property="smglom:state" stex:srcref="anonymous_string#textrange(from=3;1,to=36;12)" xml:id="omdoc1.theory1.metadata1.meta3"/>
    </metadata>
    <symbol name="this" xml:id="this.def.sym"/>
    <omtext about="#omdoc1.theory1.omtext2" stex:srcref="anonymous_string#textrange(from=5;1,to=7;14)" xml:id="omdoc1.theory1.omtext2">
      <CMP about="#omdoc1.theory1.omtext2.CMP1" stex:srcref="anonymous_string#textrange(from=6;0,to=6;42)" xml:id="omdoc1.theory1.omtext2.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.omtext2.CMP1.p1" stex:srcref="anonymous_string#textrange(from=6;0,to=6;42)" xml:id="omdoc1.theory1.omtext2.CMP1.p1"><text class="inlinedef" for="this">This is called <definiendum cd="theory1" name="this">this</definiendum></text></p>
      </CMP>
    </omtext>
    <symbol name="this2" xml:id="this2.def.sym"/>
    <omtext about="#omdoc1.theory1.omtext4" stex:srcref="anonymous_string#textrange(from=9;1,to=11;14)" xml:id="omdoc1.theory1.omtext4">
      <CMP about="#omdoc1.theory1.omtext4.CMP1" stex:srcref="anonymous_string#textrange(from=9;56,to=10;5)" xml:id="omdoc1.theory1.omtext4.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.omtext4.CMP1.p1" stex:srcref="anonymous_string#textrange(from=9;56,to=10;5)" xml:id="omdoc1.theory1.omtext4.CMP1.p1">Here is some text <text class="inlinedef" for="this2">This is called <definiendum cd="theory1" name="this2">this2</definiendum></text></p>
      </CMP>
    </omtext>
    <symbol name="second" xml:id="second.def.sym"/>
    <assertion about="#omdoc1.theory1.assertion6" stex:srcref="anonymous_string#textrange(from=13;1,to=15;17)" xml:id="omdoc1.theory1.assertion6">
      <CMP about="#omdoc1.theory1.assertion6.CMP1" stex:srcref="anonymous_string#textrange(from=14;0,to=14;43)" xml:id="omdoc1.theory1.assertion6.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.assertion6.CMP1.p1" stex:srcref="anonymous_string#textrange(from=14;0,to=14;43)" xml:id="omdoc1.theory1.assertion6.CMP1.p1"><text class="inlinedef" for="second">This is called <definiendum cd="theory1" name="second">second</definiendum></text></p>
      </CMP>
    </assertion>
    <symbol name="second-word-word2" xml:id="second-word-word2.def.sym"/>
    <assertion about="#omdoc1.theory1.assertion8" stex:srcref="anonymous_string#textrange(from=17;1,to=19;17)" xml:id="omdoc1.theory1.assertion8">
      <CMP about="#omdoc1.theory1.assertion8.CMP1" stex:srcref="anonymous_string#textrange(from=17;62,to=18;4)" xml:id="omdoc1.theory1.assertion8.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.assertion8.CMP1.p1" stex:srcref="anonymous_string#textrange(from=17;62,to=18;4)" xml:id="omdoc1.theory1.assertion8.CMP1.p1">Ni hall <text class="inlinedef" for="second-word-word2">This is called <definiendum cd="theory1" name="second-word-word2">second word word2</definiendum></text></p>
      </CMP>
    </assertion>
    <symbol name="fourth" xml:id="fourth.def.sym"/>
    <axiom about="#omdoc1.theory1.axiom10" stex:srcref="anonymous_string#textrange(from=21;1,to=23;13)" xml:id="omdoc1.theory1.axiom10">
      <CMP about="#omdoc1.theory1.axiom10.CMP1" stex:srcref="anonymous_string#textrange(from=21;45,to=22;4)" xml:id="omdoc1.theory1.axiom10.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.axiom10.CMP1.p1" stex:srcref="anonymous_string#textrange(from=21;45,to=22;4)" xml:id="omdoc1.theory1.axiom10.CMP1.p1">word <text class="inlinedef" for="fourth">This is called <definiendum cd="theory1" name="fourth">fourth</definiendum></text></p>
      </CMP>
    </axiom>
<!--  %**** String Line 25 **** -->    <symbol name="fifth" xml:id="fifth.def.sym"/>
    <axiom about="#omdoc1.theory1.axiom12" stex:srcref="anonymous_string#textrange(from=25;1,to=27;13)" xml:id="omdoc1.theory1.axiom12">
      <CMP about="#omdoc1.theory1.axiom12.CMP1" stex:srcref="anonymous_string#textrange(from=26;0,to=26;50)" xml:id="omdoc1.theory1.axiom12.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.axiom12.CMP1.p1" stex:srcref="anonymous_string#textrange(from=26;0,to=26;50)" xml:id="omdoc1.theory1.axiom12.CMP1.p1"><text class="inlinedef" for="fifth">This is called <definiendum cd="theory1" name="fifth">fifth</definiendum>sixth</text></p>
      </CMP>
    </axiom>
    <symbol name="seventh" xml:id="seventh.def.sym"/>
    <example about="#omdoc1.theory1.example14" stex:srcref="anonymous_string#textrange(from=29;1,to=31;15)" xml:id="omdoc1.theory1.example14">
      <CMP about="#omdoc1.theory1.example14.CMP1" stex:srcref="anonymous_string#textrange(from=30;0,to=30;46)" xml:id="omdoc1.theory1.example14.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.example14.CMP1.p1" stex:srcref="anonymous_string#textrange(from=30;0,to=30;46)" xml:id="omdoc1.theory1.example14.CMP1.p1"><text class="inlinedef" for="seventh">This is called <definiendum cd="theory1" name="seventh">seventh</definiendum></text></p>
      </CMP>
    </example>
    <symbol name="word3-word4" xml:id="word3-word4.def.sym"/>
    <example about="#omdoc1.theory1.example16" stex:srcref="anonymous_string#textrange(from=33;1,to=35;15)" xml:id="omdoc1.theory1.example16">
      <CMP about="#omdoc1.theory1.example16.CMP1" stex:srcref="anonymous_string#textrange(from=33;54,to=34;6)" xml:id="omdoc1.theory1.example16.CMP1">
        <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.theory1.example16.CMP1.p1" stex:srcref="anonymous_string#textrange(from=33;54,to=34;6)" xml:id="omdoc1.theory1.example16.CMP1.p1">nothing <text class="inlinedef" for="word3-word4">This is called <definiendum cd="theory1" name="word3-word4">word3 word4</definiendum></text></p>
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
my @got_lines = split("\n", $myResponse->toString(1));
my @expected_lines = split("\n", $target_xml);
my $index = 0;
while (@got_lines) {
  $index++;
  my $got_line = shift @got_lines;
  my $expected_line = shift @expected_lines;
  is($got_line, $expected_line,"Compared line $index of XML output.");
}
