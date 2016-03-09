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
\begin{module}[id=foo]
  \symdef[name=new]{helloOp}{HELLO}
  \symvariant{helloOp}{help}{NONONONON}
   This is going to be fun $ \helloOp $
   Maybe again $ \helloOp{help} $
\end{module}

\begin{module}[id=newMod]
\importmodule{foo}
 Try somehting new $ \helloOp$.
\end{module}

\begin{omtext}
  \usemodule{foo}
   We $ \helloOp $ believesefasd.
\end{omtext}
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
<omdoc xmlns="http://omdoc.org/ns" xmlns:om="http://www.openmath.org/OpenMath" xmlns:stex="http://kwarc.info/ns/sTeX" about="#omdoc1" stex:srcref="Literal String \documentc#textrange(from=2;0,to=0;0)" xml:id="omdoc1">
  <theory about="#foo" stex:srcref="Literal String \documentc#textrange(from=3;0,to=8;12)" xml:id="foo">
    <symbol about="#foo.symbol1" name="new" stex:srcref="Literal String \documentc#textrange(from=4;0,to=4;35)" xml:id="foo.symbol1"/>
    <notation about="#foo.notation2" cd="foo" name="new" stex:macro_name="helloOp" stex:nargs="0" stex:srcref="Literal String \documentc#textrange(from=4;0,to=4;35)" xml:id="foo.notation2">
      <prototype>
        <om:OMS cd="foo" name="new"/>
      </prototype>
      <rendering>
        <Math xmlns="http://dlmf.nist.gov/LaTeXML" about="#foo.notation2.m1" stex:srcref="Anonymous String#textrange(from=0;1,to=0;0)" text="H * E * L * L * O" xml:id="foo.notation2.m1">
          <XMath>
            <XMApp>
              <XMTok meaning="times" role="MULOP">⁢</XMTok>
              <XMTok font="italic" role="UNKNOWN">H</XMTok>
              <XMTok font="italic" role="UNKNOWN">E</XMTok>
              <XMTok font="italic" role="UNKNOWN">L</XMTok>
              <XMTok font="italic" role="UNKNOWN">L</XMTok>
              <XMTok font="italic" role="UNKNOWN">O</XMTok>
            </XMApp>
          </XMath>
        </Math>
      </rendering>
      <rendering ic="variant:help">
        <Math xmlns="http://dlmf.nist.gov/LaTeXML" about="#foo.notation2.m2" stex:srcref="Anonymous String#textrange(from=0;1,to=0;0)" text="N * O * N * O * N * O * N * O * N" xml:id="foo.notation2.m2">
          <XMath>
            <XMApp>
              <XMTok meaning="times" role="MULOP">⁢</XMTok>
              <XMTok font="italic" role="UNKNOWN">N</XMTok>
              <XMTok font="italic" role="UNKNOWN">O</XMTok>
              <XMTok font="italic" role="UNKNOWN">N</XMTok>
              <XMTok font="italic" role="UNKNOWN">O</XMTok>
              <XMTok font="italic" role="UNKNOWN">N</XMTok>
              <XMTok font="italic" role="UNKNOWN">O</XMTok>
              <XMTok font="italic" role="UNKNOWN">N</XMTok>
              <XMTok font="italic" role="UNKNOWN">O</XMTok>
              <XMTok font="italic" role="UNKNOWN">N</XMTok>
            </XMApp>
          </XMath>
        </Math>
      </rendering>
    </notation>
    <para xmlns="http://dlmf.nist.gov/LaTeXML" xml:id="foo.p1">
      <p about="#foo.p1.p1" xml:id="foo.p1.p1">This is going to be fun <Math about="#foo.p1.p1.m1" mode="inline" stex:srcref="Literal String \documentc#textrange(from=5;10,to=6;39)" tex="\@helloOp@construct[default]" text="new" xml:id="foo.p1.p1.m1">
          <XMath>
            <XMTok meaning="new" name="helloOp" omcd="foo"/>
          </XMath>
        </Math>
Maybe again <Math about="#foo.p1.p1.m2" mode="inline" stex:srcref="Literal String \documentc#textrange(from=6;16,to=7;33)" tex="\@helloOp@construct[default]{help}" text="new * h * e * l * p" xml:id="foo.p1.p1.m2">
          <XMath>
            <XMApp>
              <XMTok meaning="times" role="MULOP">⁢</XMTok>
              <XMTok meaning="new" name="helloOp" omcd="foo"/>
              <XMTok font="italic" role="UNKNOWN">h</XMTok>
              <XMTok font="italic" role="UNKNOWN">e</XMTok>
              <XMTok font="italic" role="UNKNOWN">l</XMTok>
              <XMTok font="italic" role="UNKNOWN">p</XMTok>
            </XMApp>
          </XMath>
        </Math></p>
    </para>
  </theory>
  <theory about="#newMod" stex:srcref="Literal String \documentc#textrange(from=10;0,to=13;12)" xml:id="newMod">
    <imports about="#newMod.imports1" from="#foo" stex:srcref="Literal String \documentc#textrange(from=11;0,to=11;18)" xml:id="newMod.imports1"/>
    <para xmlns="http://dlmf.nist.gov/LaTeXML" xml:id="newMod.p1">
      <p about="#newMod.p1.p1" xml:id="newMod.p1.p1">Try somehting new <Math about="#newMod.p1.p1.m1" mode="inline" stex:srcref="Literal String \documentc#textrange(from=11;10,to=12;30)" tex="\@helloOp@construct[default]" text="new" xml:id="newMod.p1.p1.m1">
          <XMath>
            <XMTok meaning="new" name="helloOp" omcd="foo"/>
          </XMath>
        </Math>.</p>
    </para>
  </theory>
  <omtext about="#omdoc1.omtext3" stex:srcref="Literal String \documentc#textrange(from=15;1,to=18;12)" xml:id="omdoc1.omtext3">
    <uses from="#foo"/>
    <CMP about="#omdoc1.omtext3.CMP1" stex:srcref="Literal String \documentc#textrange(from=15;1,to=15;15)" xml:id="omdoc1.omtext3.CMP1">
      <p xmlns="http://dlmf.nist.gov/LaTeXML" about="#omdoc1.omtext3.CMP1.p1" stex:srcref="Literal String \documentc#textrange(from=15;1,to=15;15)" xml:id="omdoc1.omtext3.CMP1.p1">We <Math about="#omdoc1.omtext3.CMP1.p1.m1" mode="inline" stex:srcref="Literal String \documentc#textrange(from=16;25,to=17;18)" tex="\@helloOp@construct[default]" text="new" xml:id="omdoc1.omtext3.CMP1.p1.m1">
          <XMath>
            <XMTok meaning="new" name="helloOp" omcd="foo"/>
          </XMath>
        </Math> believesefasd.</p>
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
