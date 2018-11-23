#======================================================================
# Makefile Maker for LaTeXML::MathSyntax
# m.kohlhase@jacobs-university.de, d.ginev@jacobs-university.de
#======================================================================
use ExtUtils::MakeMaker;
use strict;
use warnings;
require Term::ANSIColor;
use Term::ANSIColor;

#======================================================================
# Update omdoc+ltxml.model
#======================================================================
# \033[0m makes the output red and \033[0m resets the output color
my @args = ("bash", "-c", "type trang ||echo '\n\033[0;31mTrang is not found which could lead to a make failure.\nYou can ignore this message if you do not intend to change the schema.\nSee README for more info!\n \033[0m' ");
my $ifTrang = system(@args);
my $updateModel = `cd lib/LaTeXML/resources/RelaxNG/; make; make distclean`;

#======================================================================
# Use "perl Makefile.PL <options>"
#======================================================================
WriteMakefile(
  NAME => 'LaTeXML::Plugin::sTeX',
  AUTHOR => 'Deyan Ginev <d.ginev@jacobs-university.de>',
  ABSTRACT => "A LaTeXML extension for sTeX (Semantic LaTeX)",
  VERSION => "0.2",
  PREREQ_PM => { 
    'LaTeXML'=>'0.8.3',
  },
  (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
    'meta-spec' => { version => 2 },
      resources => {
        repository => {
          type => 'git',
          url => 'https://github.com/KWARC/LaTeXML-Plugin-sTeX.git',
          web => 'https://github.com/KWARC/LaTeXML-Plugin-sTeX',
        }}})
  : ()),
);
