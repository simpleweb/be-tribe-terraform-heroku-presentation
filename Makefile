CMD_CLEAVER := $(shell command -v cleaver 2> /dev/null)
CMD_PANDOC := $(shell command -v pandoc 2> /dev/null)

ifndef CMD_CLEAVER
	$(error "cleaver is required (npm install -g cleaver)")
endif

ifndef CMD_PANDOC
	$(error "pandoc is required to create PDFs (brew install pandoc)")
endif

.PHONY: clean all

all: slides.html printable-slides.html speaker-notes.pdf

setup:
	npm install -g cleaver
	brew install pandoc

slides.html: slides.md slides.css
	cleaver slides.md

printable-slides.html: slides.md slides.css
	cleaver slides.md --template templates/print.mustache --output printable-slides.html --theme default

speaker-notes.pdf: slides.html
	pandoc speaker-notes.md -f markdown --smart -s -o speaker-notes.pdf

clean:
	rm -f slides.html printable-slides.html speaker-notes.pdf
