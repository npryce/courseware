# To use this template makefile, define COURSE to be the filename of the course to build
# and then include this file.

# Optionally, define this variable to specify where the output documents will be built to
OUTDIR?=output

XSLT2=$(COURSEWARE_HOME)/bin/saxon

TIMESTAMP:=$(shell date)


$(OUTDIR)/pdf/%.pdf: $(OUTDIR)/fo/%.fo
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@


$(OUTDIR)/fo/%-student-notes.fo: %.course
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/course-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build=n/a \
		courseCode=$(shell basename $< .course) \
		format=Student > $@

$(OUTDIR)/fo/%-presenter-notes.fo: %.course
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/course-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build=n/a \
		courseCode=$(shell basename $< .course) \
		format=Presenter > $@

$(OUTDIR)/shared/%.fo: %.presentation
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/single-slides-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build=n/a \
		courseCode=$(shell basename $< .course)

$(OUTDIR)/shared/%.pdf: $(OUTDIR)/shared/%.fo
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@

