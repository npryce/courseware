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

# Optionally, define this variable to specify where the source documents are
SRCDIR?=.

# Optionally, define this variable to specify where the output documents will be built to
OUTDIR?=build


ifndef PRESENTATIONS
$(error PRESENTATIONS variable not set)
endif

all: $(PRESENTATIONS:%=$(OUTDIR)/pdf/%.pdf)

$(OUTDIR)/pdf/%.pdf: $(OUTDIR)/fo/%.fo
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@

$(OUTDIR)/fo/%.fo: $(SRCDIR)/%.presentation
	@mkdir -p $(dir $@)
	saxon -xsl:$(COURSEWARE_HOME)/xslt/slides/single-slides-to-fo.xsl -s:$< > $@

clean:
	rm -rf $(OUTDIR)/

again: clean all

.PHONY: clean again all

