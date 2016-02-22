# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
package sTeXTest;
use strict;
use warnings;

use base 'Exporter';
our @EXPORT_OK = qw(evaluate);

sub evaluate{
  my $name = shift;
  chdir $name;
  my @output = `make -B`;
  # Find `error` string in log if `error` presents test fails
  # !Assume there is only one test file for each directory!
  # Needs to be expanded in the future
  my $result = `grep -i 'Error' foo.xml.log ` if -e 'foo.xml.log';
  $result .= `grep -i 'Error' foo.en.xml.log ` if -e 'foo.en.xml.log';
  $result ? return 0 : return 1;
}

1;
