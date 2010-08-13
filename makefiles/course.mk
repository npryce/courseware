# To use this template makefile, define COURSE to be the filename of the course to build
# and then include this file.


# Optionally, define this variable to specify the directory containing the course files
COURSEDIR?=courses

# Optionally, define this variable to specify where the output documents will be built to
OUTDIR?=output

# You can define this variable on the command-line to build only a subset of the courses
COURSES?=$(shell find $(COURSEDIR) -name "*.course")

XSLT2=$(COURSEWARE_HOME)/bin/saxon

BUILD:=$(shell whoami)@$(shell hostname)
TIMESTAMP:=$(shell date)

all: slides student-notes presenter-notes
slides: $(COURSES:$(COURSEDIR)/%.course=$(OUTDIR)/pdf/%-slides.pdf)
student-notes: $(COURSES:$(COURSEDIR)/%.course=$(OUTDIR)/pdf/%-student-notes.pdf)
presenter-notes: $(COURSES:$(COURSEDIR)/%.course=$(OUTDIR)/pdf/%-presenter-notes.pdf)


$(OUTDIR)/pdf/%.pdf: $(OUTDIR)/fo/%.fo
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@


$(OUTDIR)/fo/%-student-notes.fo: $(COURSEDIR)/%.course
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/course-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .course) \
		format=Student > $@

$(OUTDIR)/fo/%-presenter-notes.fo: $(COURSEDIR)/%.course
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/course-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .course) \
		format=Presenter > $@

$(OUTDIR)/fo/%-slides.fo: $(COURSEDIR)/%.course
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/slides/slides-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .course) > $@

clean:
	rm -rf $(OUTDIR)

again: clean all

.PHONY: clean again all slides student-notes presenter-notes


# IN PROGRESS
#
# Generate a PDF for each referenced presentation and share them between
# courses

$(OUTDIR)/shared/%.fo: %.presentation
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/single-slides-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .course)

$(OUTDIR)/shared/%.pdf: $(OUTDIR)/shared/%.fo
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@

