# -*- CPERL -*-
#**********************************************************************
# Test cases for LaTeXML-Plugin-sTeX
#**********************************************************************
package Test;
use strict;
use sTeXTest qw(evaluate);

use Test::Simple tests => 1;

ok evaluate('cds');


