# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
use strict;
use warnings;
use XML::LibXML;

use Test::More tests => 30;

my $eval_return = eval {
  use LaTeXML;
  use LaTeXML::Common::Config;
  1;
};

ok($eval_return && !$@, 'LaTeXML modules loaded successfully.');

my $tex_input = <<'EOQ';
\documentclass[slides, showmeta, mh]{mikoslides}
\begin{document}
\begin{note}
    that is this...
\end{note}

\begin{frame}
  \frametitle{asdfadslfjk}
      this is a frame....
\end{frame}

\begin{module}
  \begin{frame}
    try again!!
   \end{frame}
\end{module}
\end{document}
EOQ

my $config = LaTeXML::Common::Config->new(local=>1, paths=>['./lib/LaTeXML/Package','./lib/LaTeXML/resources/RelaxNG','./lib/LaTeXML/resources/Profiles','./lib/LaTeXML/resources/XSLT']);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $target_xml = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="mikoslides" options="slides, showmeta, mh"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="anonymous_string#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <para xmlns="http://dlmf.nist.gov/LaTeXML" xml:id="omdoc1.p1">
    <p about="#omdoc1.p1.p1" stex:srcref="anonymous_string#textrange(from=3;14,to=4;5)" xml:id="omdoc1.p1.p1">that is this…</p>
  </para>
  <omgroup about="#omdoc1.omgroup2" layout="slide" stex:srcref="anonymous_string#textrange(from=7;13,to=10;11)" xml:id="omdoc1.omgroup2">
    <metadata about="#omdoc1.omgroup2.metadata1" stex:srcref="anonymous_string#textrange(from=8;0,to=8;26)" xml:id="omdoc1.omgroup2.metadata1">
      <dc:title about="#omdoc1.omgroup2.metadata1.title1" stex:srcref="anonymous_string#textrange(from=8;0,to=8;26)" xml:id="omdoc1.omgroup2.metadata1.title1">asdfadslfjk</dc:title>
    </metadata>
    <para xmlns="http://dlmf.nist.gov/LaTeXML" xml:id="omdoc1.omgroup2.p1">
      <p about="#omdoc1.omgroup2.p1.p1" stex:srcref="anonymous_string#textrange(from=8;18,to=9;7)" xml:id="omdoc1.omgroup2.p1.p1">this is a frame….</p>
    </para>
  </omgroup>
  <theory about="#omdoc1.theory3" stex:srcref="anonymous_string#textrange(from=12;1,to=16;12)" xml:id="omdoc1.theory3">
    <metadata about="#omdoc1.theory3.metadata1" stex:srcref="anonymous_string#textrange(from=12;1,to=16;12)" xml:id="omdoc1.theory3.metadata1">
      <dc:creator about="#omdoc1.theory3.metadata1.creator1" stex:srcref="anonymous_string#textrange(from=12;1,to=16;12)" xml:id="omdoc1.theory3.metadata1.creator1"/>
      <dc:contributor about="#omdoc1.theory3.metadata1.contributor2" stex:srcref="anonymous_string#textrange(from=12;1,to=16;12)" xml:id="omdoc1.theory3.metadata1.contributor2"/>
      <meta about="#omdoc1.theory3.metadata1.meta3" property="smglom:state" stex:srcref="anonymous_string#textrange(from=12;1,to=16;12)" xml:id="omdoc1.theory3.metadata1.meta3"/>
    </metadata>
    <omgroup about="#omdoc1.theory3.omgroup2" layout="slide" stex:srcref="anonymous_string#textrange(from=13;10,to=15;14)" xml:id="omdoc1.theory3.omgroup2">
      <para xmlns="http://dlmf.nist.gov/LaTeXML" xml:id="omdoc1.theory3.omgroup2.p1">
        <p about="#omdoc1.theory3.omgroup2.p1.p1" stex:srcref="anonymous_string#textrange(from=13;10,to=14;5)" xml:id="omdoc1.theory3.omgroup2.p1.p1">try again!!</p>
      </para>
    </omgroup>
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
