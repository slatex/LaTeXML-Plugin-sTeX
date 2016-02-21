MODS = foo.tex 
XML = $(MODS:%.tex=%.xml)

all: $(XML)

$(XML): %.xml: %.tex
	latexmlc --profile tex-slides-module.opt\
	         --output $@ --log $@.log\
		 $< 


echo:
	@echo $(XML)
