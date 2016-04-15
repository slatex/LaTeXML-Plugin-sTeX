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
		  
my $perllib = $ENV{'PERL_LOCAL_LIB_ROOT'};
my $bindings = $perllib . '/lib/perl5/LaTeXML/Package';
my $config = LaTeXML::Common::Config->new(paths=>["$bindings"]);
my $converter = LaTeXML->get_converter($config);
my $response = $converter->convert("literal:$tex_input");
my $content_query = <<'EOQ';
<?xml version="1.0" encoding="UTF-8"?>
<?latexml class="smglom"?>
<?latexml RelaxNGSchema="omdoc+ltxml"?>
<omdoc xmlns="http://omdoc.org/ns" xmlns:om="http://www.openmath.org/OpenMath" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="Literal String \documentc#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#foo" stex:srcref="Literal String \documentc#textrange(from=3;0,to=6;12)" xml:id="foo">
    <symbol about="#foo.symbol1" name="foo" stex:srcref="Literal String \documentc#textrange(from=4;0,to=4;26)" xml:id="foo.symbol1"/>
    <notation about="#foo.notation2" cd="foo" name="foo" stex:macro_name="foo" stex:nargs="0" stex:srcref="Literal String \documentc#textrange(from=4;0,to=4;26)" xml:id="foo.notation2">
      <prototype>
        <om:OMS cd="foo" name="foo"/>
      </prototype>
      <rendering>
        <text xmlns="http://dlmf.nist.gov/LaTeXML" class="ltx_markedasmath">foo</text>
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
