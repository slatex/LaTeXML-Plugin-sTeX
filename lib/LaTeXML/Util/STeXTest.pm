# -*- mode: Perl -*-
# /=====================================================================\ #
# | STeX Tests Implementation of LaTeXML                                | #
# | http://github.com/sLaTeX/LaTeXML-Plugin-sTeX/                       | #
# |=====================================================================| #
# |  Copyright (c) Tom Wiesing 2019.                                    | #
# | Adapted from LaTeXML:                                                    | #
# |  Public domain software, produced as part of work done by the       | #
# |  United States Government & not subject to copyright in the US.     | #
# |---------------------------------------------------------------------| #
# | Michael Kohlhase <michael.kohlhase@fau.de>                  #_#     | #
# | http://github.com/sLaTeX/sTeX                              (o o)    | #
# \=========================================================ooo==U==ooo=/ #

package LaTeXML::Util::STeXTest;
use strict;
use warnings;

use Encode;

use Test::More;
use LaTeXML::Util::Pathname;
use JSON::XS;
use FindBin;
use File::Copy;
use File::Which;
use File::Spec::Functions;
use LaTeXML::Post;
use LaTeXML::Post::MathML::Presentation;
use LaTeXML::Post::XMath;
use Config;

use base qw(Exporter);
our @EXPORT = (qw(&latexml_stex_tests &make_latexml &make_latexmlpost),
  @Test::More::EXPORT);

# 'core_options'
sub core_options {
    ### Options for running 'latexmlc':
    my %core_options = (
        preload => [],
        searchpaths => [
            './lib/LaTeXML/Package',
            './lib/LaTeXML/resources/RelaxNG',
            './lib/LaTeXML/resources/Profiles',
            './lib/LaTeXML/resources/XSLT'
        ],
        includecomments => 0,
        verbosity => -2,
    );
    return \%core_options;
}

## to run this manually on the command line, use:
# latexmlc --path './lib/LaTeXML/Package' --path './lib/LaTeXML/resources/RelaxNG' --path './lib/LaTeXML/resources/Profiles' --path './lib/LaTeXML/resources/XSLT' /path/to/test.tex --destination /path/to/output.xml
# and then manually remove the 'searchpaths' line

# Test the conversion of all *.tex files in the given directory (typically t/something)
# Skip any that have no corresponding *.xml file.
# Also test with postprocessing all *.omdoc files (need the xml as input)
sub latexml_stex_tests {
    my ($directory, %options) = @_;

    # Can't read directory? Fail (assumed single) test.
    my $DIR;
    return do_fail($directory, "Couldn't read directory $directory:$!") unless opendir($DIR, $directory);

    # read the directory, find '.omdoc' and .tex tests
    my @dir_contents  = sort readdir($DIR);
    my $t;
    my @xml_tests     = map { (($t = $_) =~ s/\.tex$//      ? ($t) : ()); } @dir_contents;
    my @omdoc_tests   = map { (($t = $_) =~ s/\.omdoc$// ? ($t) : ()); } @dir_contents;
    closedir($DIR);

    # plan how many tests we will have
    plan tests => (1 + scalar(@xml_tests) + scalar(@omdoc_tests));

    # ensure LaTeXML loads properly and bail out if it doesn't.
    # TODO: Do we want to load something STeX specific here?
    unless(eval { use_ok("LaTeXML::Core"); }) {
        skip_all("Couldn't load LaTeXML");
        return done_testing();
    }
    
    # run the tests themselves
    SKIP: {
        
        # find the requirements
        my $requires = $options{requires} || {};    # normally a hash: test=>[files...]
        $requires = { '*' => $requires } unless ref $requires;    # scalar== filename required by ALL
        

        # Run the '.xml' tests
        my $core_options = core_options();
        foreach my $name (@xml_tests) {
            my $test = "$directory/$name";
            SKIP: {
                # check that the requirements and files exist or bail out
                skip("No file $test.xml", 1) unless (-f "$test.xml");
                next unless check_requirements($test, 1, $$requires{'*'}, $$requires{$name});

                # run the xml test
                latexml_ok("$test.tex", "$test.xml", $test, $core_options);
            }
        }
        
        # Run the '.omdoc' tests
        foreach my $name (@omdoc_tests) {
            my $test = "$directory/$name";
            SKIP: {
                # check the files exist or bail out
                skip("No file $test.xml and/or $test.omdoc", 1) unless ((-f "$test.xml") && (-f "$test.omdoc"));
                next unless check_requirements($test, 1, $$requires{'*'}, $$requires{$name});

                # run the post-processing test
                latexmlpost_ok("$test.tex", "$test.omdoc", $test);
            }
        }
    }

    return done_testing();
}

# 'check_requirements' checks the requirements of the packages
sub check_requirements {
    my ($test, $ntests, @reqmts) = @_;
    foreach my $reqmts (@reqmts) {
        next unless $reqmts;
        my @required_packages = ();
        my $texlive_min       = 0;

        # resolve requirements from an array or a hash ir a string
        if (!(ref $reqmts)) {
            @required_packages = ($reqmts);
        } elsif (ref $reqmts eq 'ARRAY') {
            @required_packages = @$reqmts;
        } elsif (ref $reqmts eq 'HASH') {
            @required_packages = (ref $$reqmts{packages} eq 'ARRAY' ? @{ $$reqmts{packages} } : $$reqmts{packages});
            $texlive_min = $$reqmts{texlive_min} || 0;
        }

        # check that each of them is fullfilled
        foreach my $reqmt (@required_packages) {
            unless (pathname_kpsewhich($reqmt) || pathname_find($reqmt)) {
                my $message = "Missing requirement $reqmt for $test";
                diag("Skip: $message");
                skip($message, $ntests);
                return 0;
            }
        }
    }
    return 1;
}

# 'do_fail' produces a failure message
sub do_fail {
    my ($name, $diag) = @_;
    my $ok = ok(0, $name);
    diag($diag);
    return $ok;
}

# 'latexml_ok' checks that latexml processes a single file ok
sub latexml_ok {
    my ($texpath, $xmlpath, $name, $core_options) = @_;
    if (my $texstrings = process_texfile(texpath => $texpath, name => $name, core_options => $core_options)) {
        if (my $xmlstrings = process_xmlfile($xmlpath, $name)) {
            return is_strings($texstrings, $xmlstrings, $name);
        }
    }
}

sub make_latexml {
    my ($texpath, $xmlpath, $name) = @_;
    my $core_options = core_options();
    my $texstrings = process_texfile(texpath => $texpath, name => $name, core_options => $core_options);
    return unless $texstrings;
    return dump_domstring($texstrings, $xmlpath);
}

# 'latexmlpost_ok' checks that latexml postprocesses a single file ok
sub latexmlpost_ok {
    my ($xmlpath, $postxmlpath, $name) = @_;
    if (my $texstrings = postprocess_xmlfile($xmlpath, $name)) {
        if (my $xmlstrings = process_xmlfile($postxmlpath, $name)) {
            return is_strings($texstrings, $xmlstrings, $name);
        }
    }
}

sub make_latexmlpost {
    my ($xmlpath, $postxmlpath, $name) = @_;
    my $xmlstrings = postprocess_xmlfile($xmlpath, $name);
    return unless $xmlstrings;
    return dump_domstring($xmlstrings, $postxmlpath);
}

# These return the list-of-strings form of whatever was requested, if successful,
# otherwise undef; and they will have reported the failure

sub process_texfile {
    # read the options passed
    my (%options)    = @_;
    my $texpath      = $options{texpath};
    my $name         = $options{name};
    my %core_options = $options{core_options} ? %{ $options{core_options} } : (
        preload => [], searchpaths => [], includecomments => 0, verbosity => -2
    );
    # create a latexml instance
    my $latexml = eval { LaTeXML::Core->new(%core_options) };
    unless ($latexml) {
        do_fail($name, "Couldn't instanciate LaTeXML: " . @!);
        return;
    }

    # convert the file
    my $dom = eval { $latexml->convertFile($texpath); };
    unless ($dom) {
        do_fail($name, "Couldn't convert $texpath: " . @!);
        return;
    }
    
    # and process the dom
    return process_dom($dom, $name);
}

# 'postprocess_xmlfile' runs postprocessing on a single xmlfile
sub postprocess_xmlfile {
    # read options
    my ($xmlpath, $name) = @_;

    # create XMath object
    my $xmath = LaTeXML::Post::XMath->new();
    return do_fail($name, "Couldn't instanciate LaTeXML::Post::XMath") unless $xmath;
    $xmath->setParallel(LaTeXML::Post::MathML::Presentation->new());

    # create a new latexmlpost
    my @procs       = ($xmath);
    my $latexmlpost = LaTeXML::Post->new(verbosity => -1);
    return do_fail($name, "Couldn't instanciate LaTeXML::Post:") unless $latexmlpost;

    # run the processing
    my ($doc) = $latexmlpost->ProcessChain(
        LaTeXML::Post::Document->newFromFile("$name.xml", validate => 0), # TODO: We skip validation for now
    @procs);
    return do_fail($name, "Couldn't process $name.xml") unless $doc;
    
    # and canonicalize
    return process_dom($doc, $name);
}

# 'process_dom' canonicalizes the domstring
sub process_dom {
    my ($xmldom, $name) = @_;
    
    # Parse the string accordingly
    # We want the DOM to be BOTH indented AND canonical!!\
    my $domstring = eval {
        my $string = $xmldom->toString(1);
        my $parser = XML::LibXML->new(load_ext_dtd => 0, validation => 0, keep_blanks => 1);
        $parser->parse_string($string)->toStringC14N(0);
    };

    # if things didn't work, bail out
    unless($domstring) {
        do_fail($name, "Couldn't convert dom to string: " . $@);
        return;
    }

    # and canonicalize!
    return process_domstring($domstring, $name);
}

# 'process_xmlfile' canonicalizes an xmlfile
sub process_xmlfile {
    my ($xmlpath, $name) = @_;
    my $domstring = eval {
        my $parser = XML::LibXML->new(load_ext_dtd => 0, validation => 0, keep_blanks => 1);
        $parser->parse_file($xmlpath)->toStringC14N(0);
    };
    
    unless ($domstring) {
        do_fail($name, "Could not convert file $xmlpath to string: " . $@);
        return;
    }

    return process_domstring($domstring, $name);
}

# 'process_dom' canonicalizes a dom string
sub process_domstring {
    my ($domstring, $name) = @_;
    return [split('\n', $domstring)];
}

# 'dump_domstring' writes domstring to $FILE
sub dump_domstring {
    my ($string, $path) = @_;
    my $domstring = join("\n", @$string);
    open my $fh, '>', $path or die "Can't open file $path: $!";
    print $fh encode( 'utf-8', $domstring );
    close $fh;
}

# $strings1 is the currently generated material
# $strings2 is the stored expected result.
sub is_strings {
    my ($strings1, $strings2, $name) = @_;

    my $ok  = 1; # by default, everything went fine
    my $max = $#$strings1 > $#$strings2 ? $#$strings1 : $#$strings2;

    for (my $i = 0 ; $i <= $max ; $i++) {
        my $string1 = $$strings1[$i];
        my $string2 = $$strings2[$i];

        # chomp string1, or let it be ""
        if (defined $string1) {
            chomp($string1);
        } else {
            $ok = 0;
            $string1 = "";
        }
        
        # chomp string2 or let it be ""
        if (defined $string2) {
            chomp($string2);
        } else {
            $ok = 0;
            $string2 = "";
        }

        if (!$ok || ($string1 ne $string2)) {
            return do_fail($name,
                "Difference at line " . ($i + 1) . " for $name\n"
                . "      got : '$string1'\n"
                . " expected : '$string2'\n"
            );
        }
    }

    return ok(1, $name);
}
1;