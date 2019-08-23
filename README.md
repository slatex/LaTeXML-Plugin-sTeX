## A [LaTeXML](http://dlmf.nist.gov/LaTeXML/) plugin for [sTeX](http://github.com/KWARC/sTeX).

[![Build Status](https://api.travis-ci.org/slatex/LaTeXML-Plugin-sTeX.svg?branch=master)](https://travis-ci.org/slatex/LaTeXML-Plugin-sTeX#) ![version](https://img.shields.io/badge/version-0.2.0-orange.svg)


### Prerequisites
#### LaTeXML
 You will only be able to use this plugin after you
have LaTeXML installed, whose installation steps can be found
[here](http://dlmf.nist.gov/LaTeXML/get.html).

#### Trang
This plug in will also need
[Trang](http://www.thaiopensource.com/relaxng/trang.html) for
transforming the schema. 
##### MAC OS 
```
brew install jing-trang
```
This may prompt you to cask-install `Java8`, for which you will need `sudo` rights. 
##### Linux
```
sudo apt-get install trang
```
##### Windows 
You can build trang from [Github](https://github.com/relaxng/jing-trang).

### How to install 
Currently you can do the installation via `cpanm` or manually. Even though the two methods
yield the same results we recommend to stick to only one installation approach for consistency.

First clone this repository somewhere on your computer and 
```shell
cd <PATH TO THE REPO>
```

##### Installation via `cpanm`
`cpanm` makes installation for modules much easier.
If you don't have `cpanm` yet, you can get it by 
```shell
cpan App::cpanminus
```
You can use it to install almost every perl module using one command
```shell
cpanm Module::Name
```
Now we can just let it do all the work 
```shell
cpanm .
```
`cpanm` will run the included testcases automatically, if any of these testcases failed,
the installation will be unsuccessful.

##### Manual installation
If the above steps don't work for you, you can try to install the plugin manually to see 
what's wrong.
```shell
perl Makefile.PL 
make	
make test 
```
Then we can finish the installation with 
```shell
sudo make install
```

### How to use this plugin 
This plugin is mainly composed of LaTeXML bindings, profiles, RelaxNG schemas and XSLT 
stylesheets. After installation, the bindings will go to the Package directory of LaTeXML, and the 
other files will be added to the resource directory respectively.

Using this plugin is no different than applying LaTeXML on a normal file, here a simple
example:
```shell
latexmlc --profile stex talk.tex 
```
* ```--profile```: we preload different bindings to facilitate the processing time, here the
  sTeX preloads the bindings provided by this plugin and sets the paths. 
* ```talk.tex```: the file we want to transform, here a talk with sTeX markup
This will transform ```talk.tex``` into OMDoc form. 

A more advanced usage would be to transform an sTeX module, i.e. a fragment that
encapsulates specific mathematical knowledge. 

```shell
latexmlc --profile stex-module pl1-semantics.tex  --preamble ../../../../meta-inf/lib/pre.tex 
--postamble ../../../../meta-inf/lib/post.tex --path ../../../../../../ext/sTeX/sty/etc/
```
As this is not a standalone LaTeX file we
have to specify preamble and postamble files in the ```--preamble``` and ```--postamble```
options. We can also give additional paths (e.g. for files that come with this plugin in
the ```--path``` option.

For more info on how to call LaTeXML, please refer to
[commands](http://dlmf.nist.gov/LaTeXML/manual/commands/).

### Documentation
Although LaTeXML-Plugin-sTeX doesn't come with much documentation itself, the use of 
this plugin is well documented. The documentation has two components:
* [sTeX](https://github.com/KWARC/sTeX): each sTeX package has its corresponding LaTeXML
  binding. The sTeX documentation gives an intuitive understanding of how all the packages
  work. The LaTeXML bindings do try to mimic the behavior of TeX workflow but just has
  different output format: OMDoc. The LaTeX workflow produces PDF and the LaTeXML workflow
  produces OMDoc or OMDoc-annotated HTML (still under development).
* [LaTeXML](http://dlmf.nist.gov/LaTeXML/docs.html): having an intuitive understanding is
  beneficial and it is also important for you to understand how LaTeXML works if you want
  to change the behaviors of the bindings.

### Copyright
Copyright (c) 2019 Michael Kohlhase
The package is distributed under the terms of the LaTeX Project Public License (LPPL)


<!--  LocalWords:  stex
 -->
