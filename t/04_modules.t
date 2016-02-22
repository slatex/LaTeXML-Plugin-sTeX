# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
use strict;
use warnings;
use sTeXTest qw(evaluate);

use Test::Simple tests => 1;

ok evaluate('modules');

