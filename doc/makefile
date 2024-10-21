SRCDIR=src
SRC=$(wildcard $(SRCDIR)/*.tex)
PDF=$(notdir $(SRC:.tex=.pdf))
AUX=$(PDF:.pdf=.aux)
LOG=$(PDF:.pdf=.log)
MD=$(notdir $(SRC:.tex=.md))
WIKI=Home.md
WIKI_DIR=bus_1553.wiki

.phony: clean

all: $(PDF) $(MD) $(WIKI_DIR)/$(WIKI)

$(PDF): $(SRC)
	pdflatex -interaction=batchmode $<
	rm $(AUX) $(LOG)

$(MD): $(SRC)
	pandoc -f latex -t markdown -s -o $@ $<

$(WIKI_DIR)/$(WIKI): $(SRC)
	pandoc -f latex -t markdown -s -o $@ $<

clean:
	rm -rf $(PDF) $(MD)
