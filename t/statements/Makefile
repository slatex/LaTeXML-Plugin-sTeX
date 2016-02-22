MODS = foo.tex 
XML = $(MODS:%.tex=%.xml)

all: $(XML)

$(XML): %.xml: %.tex
	latexmlc --profile stex-module.opt\
	         --preamble pre.tex --postamble post.tex\
	         --output $@ --log $@.log\
		 $< 


echo:
	@echo $(XML)
