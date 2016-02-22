MODS = foo.tex 
XML = $(MODS:%.tex=%.xml)

all: $(XML)

$(XML): %.xml: %.tex
	latexmlc --profile stex-omdoc-modules --path ../../../sTeX/sty/etc/ \
	         --preamble pre.tex --postamble post.tex\
	         --output $@ --log $@.log\
		 $< 


echo:
	@echo $(XML)
