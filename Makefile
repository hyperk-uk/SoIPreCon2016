
MAIN = mainfile

TEXFILES = $(MAIN).tex $(shell ls */*.tex)
#FIGURES = $(shell ls */*.eps)

PSFILE = $(MAIN).ps
PDFFILE = $(MAIN).pdf
DVIFILE = $(MAIN).dvi

REVTEX:=$(CURDIR)/revtex4-1/tex/latex/revtex
REVBST:=$(CURDIR)/revtex4-1/bibtex/bst/revtex
NATBIB:=$(CURDIR)/natbib

export TEXINPUTS:=$(CURDIR):$(REVTEX):$(TEXINPUTS)
export BSTINPUTS:=$(CURDIR):$(REVBST):$(BSTINPUTS)

LATEX = pdflatex
#LATEX = /usr/texbin/latex
BIBTEX = bibtex

#v : clean all
#	open $(MAIN).pdf

all : natbib $(MAIN).pdf

dvi : $(TEXFILES)
	xdvi $(MAIN)

ps : $(DVIFILE)

pdf : $(DVIFILE)

clean :
	$(RM) *~ */*~ $(DVIFILE) $(PSFILE) $(PDFFILE) *.aux *.log *.toc *.bbl *.blg *Notes.bib *.out 

revtex: 
	mktexlsr $(PWD)/revtex4-1

natbib: $(NATBIB)/natbib.sty

$(NATBIB)/natbib.sty:
	rm natbib.sty; cd $(NATBIB); ls; latex natbib.ins; cd ../; ln -s $(NATBIB)/natbib.sty .

$(MAIN).dvi : $(TEXFILES) #$(FIGURES)

# remove #'s in following five lines for pdflatex
$(MAIN).pdf :$(TEXFILES)
	$(LATEX) -shell-escape $(MAIN) || rm -f $(DVIFILE)
	$(BIBTEX) $(MAIN) || rm -f $(DVIFILE)
	$(LATEX)  $(MAIN) || rm -f $(DVIFILE)
	$(LATEX)  $(MAIN) || rm -f $(DVIFILE)

# remove #'s in following 12 lines for latex
#.tex.dvi :
#	$(LATEX) $(MAIN) || rm $(DVIFILE)
#	$(BIBTEX) $(MAIN) || rm $(DVIFILE)
#	$(LATEX) $(MAIN) || rm $(DVIFILE)
#	$(LATEX) $(MAIN) || rm $(DVIFILE)
#
#$(PSFILE) : $(DVIFILE) $(FIGURES)
#	dvips $(DVIFILE) -o $@
#
#$(PDFFILE) : $(DVIFILE) $(FIGURES)
#	dvipdf $(DVIFILE) $@


.dvi.pdf :
	dvipdf $< 


.SUFFIXES : .pdf .ps .dvi .tex 

