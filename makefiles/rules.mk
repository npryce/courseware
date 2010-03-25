# To use this template makefile, define PRESENTATIONS to be a space-separated list of
# presentation names and then include this file.
#
# For example, to build the two presentations ./sheep.presentation and ./cheese.presentation,
# your Makefile only needs to contain:
#
#     PRESENTATIONS=sheep cheese
#     
#     include $(COURSEWARE_HOME)/makefiles/rules.mk
#
#
# If you the PDFVIEWER variable to a program that can view PDF files, then it will be used to
# open PDF files whenever they are built

# Optionally, define this variable to specify where the source documents are
SRCDIR?=.

# Optionally, define this variable to specify where the output documents will be built to
OUTDIR?=build

ifndef PRESENTATIONS
$(error PRESENTATIONS variable not set)
endif

STUDENT_NOTES=$(PRESENTATIONS:%=$(OUTDIR)/pdf/%-student-notes.pdf)
PRESENTER_NOTES=$(PRESENTATIONS:%=$(OUTDIR)/pdf/%-presenter-notes.pdf)
SLIDES=$(PRESENTATIONS:%=$(OUTDIR)/pdf/%-slides.pdf)
FIGURES?=*.svg #TODO compute dependencies by walking XML files

all: slides student-notes presenter-notes
slides: $(SLIDES) 
student-notes: $(STUDENT_NOTES) 
presenter-notes: $(PRESENTER_NOTES)

$(OUTDIR)/pdf/%.pdf: $(OUTDIR)/fo/%.fo $(FIGURES)
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@
	$(if $(PDFVIEWER),$(PDFVIEWER) $@)

$(OUTDIR)/fo/%-slides.fo: $(SRCDIR)/%.presentation
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HOME)/xslt/slides/single-slides-to-fo.xsl -s:$< > $@

$(OUTDIR)/fo/%-student-notes.fo $(OUTDIR)/fo/%-presenter-notes.fo: $(SRCDIR)/%.presentation
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HOME)/xslt/notes/single-notes-to-fo.xsl -s:$< > $@

clean:
	rm -rf $(OUTDIR)/

again: clean all

.PHONY: clean again all notes student-notes presenter-notes

