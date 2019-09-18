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
\documentclass{omdoc}
\begin{document}
\begin{module}[id=foo]
\end{module}

\begin{module}[id=foo2]
  \importmodule{foo}
\end{module}

\begin{module}[id=foo3]
  \importmodule{foo2}
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
<omdoc xmlns="http://omdoc.org/ns" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="anonymous_string#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#foo" stex:srcref="anonymous_string#textrange(from=3;0,to=5;12)" xml:id="foo"/>
  <theory about="#foo2" stex:srcref="anonymous_string#textrange(from=7;0,to=9;12)" xml:id="foo2">
    <imports about="#foo2.imports1" from="#foo" stex:srcref="anonymous_string#textrange(from=8;0,to=8;18)" xml:id="foo2.imports1"/>
  </theory>
  <theory about="#foo3" stex:srcref="anonymous_string#textrange(from=11;0,to=14;12)" xml:id="foo3">
    <imports about="#foo3.imports1" from="#foo2" stex:srcref="anonymous_string#textrange(from=12;0,to=12;19)" xml:id="foo3.imports1"/>
  </theory>
</omdoc>
EOQ

# Remove searchpaths tag
my $xml = XML::LibXML->new;
my $myResponse = $xml->parse_string($response->{result});
$myResponse->removeChild(($myResponse->childNodes())[0]);

is($response->{status_code},0,'Conversion was problem-free.');
is($myResponse->toString(1),$content_query,'Content query successfully generated');
