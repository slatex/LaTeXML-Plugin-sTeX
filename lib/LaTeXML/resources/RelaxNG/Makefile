RNC.imported = $(shell ls omdoc/*.rnc) $(shell ls LaTeXML/*.rnc)
RNC =  $(shell ls *.rnc) 
RNG =  $(RNC:%.rnc=%.rng)
MOD =  omdoc+ltxml.model

all: $(MOD)

omdoc+ltxml.model: %.model: $(RNG) compileSchema-omdoc+ltxml.pl
	perl compileSchema-omdoc+ltxml.pl


$(RNG): %.rng: %.rnc $(RNC) $(RNC.imported)
		trang -I rnc -O rng $< $@
clean:		
		rm -f *~ 
distclean:	clean
		rm -f *.rng
