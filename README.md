# LaTeXML-Plugin-sTeX

This is a [LaTeXML](http://dlmf.nist.gov/LaTeXML/) plugin for
[sTeX](http://github.com/KWARC/sTeX). You will only be able to use
this plugin after you have LaTeXML installed, whose installation steps
can be found [here}(http://dlmf.nist.gov/LaTeXML/get.html).

### How to install 
Currently you can do the installation via `cpanm` or manually, however we recommend 
you to use only one installation approach, even though manual installation is no different
from `cpanm`. If you don't use the same installation approach through out the whole process,
things might not work. 

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
other files will be added to the resource directory respectively. Using this plugin is no different than
applying LaTeXML on a normal file. One should always be careful with all the options when calling 
LaTeXML. Here we provide a simple example:
```shell
latexmlc --profile stex-module pl1-semantics.tex  --preamble ../../../../meta-inf/lib/pre.tex 
--postamble ../../../../meta-inf/lib/post.tex --path ../../../../../../ext/sTeX/sty/etc/
```
* profile: we preload different bindings to facilitate the processing time.
*  pl1-semantics.tex: the file we want to transform.
* preamble, postamble: in case many tex files share the same preamble and postamble, we 
then only need one of each for all the fiels.
* path: add paths to search for files.
For more info on how to call LaTeXML, please refer to (commands)[http://dlmf.nist.gov/LaTeXML/manual/commands/].

### Documentation
Although LaTeXML-Plugin-sTeX doesn't come with much documentation itself, the use of 
this plugin is well documented. The documentation has two components:
* (sTeX)[https://github.com/KWARC/sTeX]: each sTeX package has its
  corresponding LaTeXML bining, by looking at the sTeX documentations
  is a good way to know an intuitive understanding of how all the
  packages work. The LaTeXML bindings do try to mimic the behavior of
  TeX workflow but just has different output format. The TeX workflow
  produces pdf and the LaTeXML workflow produces xml, omdoc, html
  (still under development).
* (LaTeXML)[http://dlmf.nist.gov/LaTeXML/docs.html]: having an
  intuitive understanding is beneficial and it is also important for
  you to understand how LaTeXML works if you want to change the
  behaviors of the bindings.


Copyright (c) 2015 Michael Kohlhase
The package is distributed under the terms of the LaTeX Project Public License (LPPL)

