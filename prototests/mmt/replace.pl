# -*- mode: Perl -*-
######################################
## Temporary hack for MMT delimiter ##
## Replace the placeholder with     ##
## delimiters that aren't valid   ##
## valid xml characters             ##  
######################################

use warnings;
use strict;
use Path::Tiny qw(path);

my $filename = $ARGV[0];
die "Need file name\n" unless $filename;

my $file = path($filename);
my $data = $file->slurp_utf8;
$data =~ s/\^\^1e/\/g;
$data =~ s/\^\]/\/g;
$file->spew_utf8( $data );
