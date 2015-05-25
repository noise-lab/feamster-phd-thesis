REPORT=thesis
LATEX=latex
BIBTEX=bibtex --min-crossrefs=1000
REF1=ref
REF2=rfc
PICS=

SRCS= ./mitthesis.cls \
./abstract.tex \
./acknowledgements.tex \
./contents.tex \
./cover.tex \
./thesis.tex \
./intro.tex \
./rcc.tex \
./rcc/figures/conditional_ad.tex \
./rcc/figures/consistent_export.tex \
./rcc/figures/med_example.tex \
./rcc/figures/nexthop_example.tex \
./rcc/figures/rolex_design.tex \
./rcc/figures/routing_domains.tex \
./rcc/figures/rr_example_fig.tex \
./rcc/figures/rr_example.tex \
./rcc/figures/visibility_example.tex \
./rcc/introduction.tex \
./rcc/background.tex \
./rcc/overview.tex \
./rcc/signaling.tex \
./rcc/policy.tex \
./rcc/implementation.tex \
./rcc/evaluation.tex \
./rcc/conclusion.tex \
./rcc/design.tex \
./rcc/results_table.tex \
./sandbox/figures/med.tex \
./sandbox/figures/prototype_fig.tex \
./sandbox/introduction.tex \
./sandbox/setup.tex \
./sandbox/prediction.tex \
./sandbox/discussion.tex \
./sandbox/implementation.tex \
./sandbox/performance.tex \
./sandbox/validation.tex \
./policy/conclusion.tex \
./sandbox/conclusions.tex \
./policy/dw.tex \
./policy/i2.tex \
./policy/localnew.tex \
./policy/nexthop.tex \
./policy/notation.tex \
./policy/related.tex \
./related.tex \
./sandbox.tex \
./policy.tex \
./dynamic.tex \
./dynamic_intro.tex \
./concl.tex \
./dynamic/introduction.tex \
./dynamic/background.tex \
./dynamic/algorithms.tex \
./dynamic/results.tex \
./dynamic/conclusion.tex \
./dynamic/iBGPresult.tex \
./dynamic/expl.tex \
./rlogic.tex \
./rlogic/introduction.tex \
./rlogic/definitions.tex \
./rcp/introduction.tex \
./rcp/background.tex \
./rcp/strawman.tex \
./rcp/weaknesses.tex \
./rcp/related.tex \
./rcp/conclusions.tex \
./rcp/architecture.tex

REFS=$(REF1).bib $(REF2).bib

all: $(REPORT).dvi $(REPORT).ps  $(REPORT).ps.gz pdf
#.tex.dvi	
#       $(LATEX) $*.tex
$(REPORT).dvi: $(SRCS) $(REFS) Makefile $(PICS)
	@rm -f $(REPORT).out
	$(LATEX) $(REPORT)
	$(BIBTEX) $(REPORT)
	perl -pi -e "s/%\s+//" *.bbl
	$(LATEX) $(REPORT)
	$(LATEX) $(REPORT)
	perl addcontents.pl
	$(LATEX) $(REPORT)


$(REPORT).ps.gz: $(REPORT).ps
	gzip --best -c $(REPORT).ps > $(REPORT).ps.gz

$(REPORT).ps: $(REPORT).dvi
	dvips -z -t letter $(REPORT).dvi -o $(REPORT).ps

# not relevant here
#figures:
#	cd figures; make

2up: $(REPORT).ps
	 psnup -2 -pletter thesis.ps $(REPORT)_2.ps

4up: $(REPORT).ps
	 psnup -4 -pletter thesis.ps $(REPORT)_4.ps

pdf: $(REPORT).ps
	ps2pdf14 $(REPORT).ps $(REPORT).pdf

web: $(REPORT).ps.gz pdf
	cp $(REPORT).ps.gz /home/feamster/public_html/
	cp $(REPORT).pdf /home/feamster/public_html/

view: $(REPORT).dvi
	xdvi $(REPORT).dvi

print: $(REPORT).dvi
	dvips $(REPORT).dvi

printer: $(REPORT).ps
	lpr $(REPORT).ps

tidy:
	rm -f *.dvi *.aux *.log *.blg *.bbl

clean:
	rm -f *.dvi *.aux *.log *.blg *.bbl *.out $(REPORT)*.ps* $(REPORT).pdf *brf *lot *lof *toc

