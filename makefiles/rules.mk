# To use this template makefile, define COURSE to be the filename of the course to build
# and then include this file.


# Optionally, define this variable to specify the directory containing the course files
COURSEDIR?=courses

# Optionally, define this variable to specify where the output documents will be built to
OUTDIR?=output


XSLT2=$(COURSEWARE_HOME)/bin/saxon

BUILD:=$(shell whoami)@$(shell hostname)
TIMESTAMP:=$(shell date)

all: slides student-notes presenter-notes

ifdef COURSEDIR
# You can predefine this variable to build only a subset of the courses
COURSES?=$(shell find $(COURSEDIR) -name "*.course")

SLIDES+=$(COURSES:$(COURSEDIR)/%.course=$(OUTDIR)/pdf/%-slides.pdf)
STUDENT_NOTES+=$(COURSES:$(COURSEDIR)/%.course=$(OUTDIR)/pdf/%-student-notes.pdf)
PRESENTER_NOTES+=$(COURSES:$(COURSEDIR)/%.course=$(OUTDIR)/pdf/%-presenter-notes.pdf)


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

$(OUTDIR)/course-depends.mk: $(COURSES)
	@mkdir -p $(dir $@)
	$(COURSEWARE_HOME)/bin/depends \
		$(abspath $(OUTDIR)) \
		$(abspath $(COURSEDIR)) \
		$(foreach c,$(COURSES),$(abspath $c)) > $@

include $(OUTDIR)/course-depends.mk

endif


ifdef PRESENTATIONDIR
# You can predefine this variable to build only a subset of the presentations
PRESENTATIONS?=$(shell find $(PRESENTATIONDIR) -name "*.presentation")

SLIDES+=$(PRESENTATIONS:$(PRESENTATIONDIR)/%.presentation=$(OUTDIR)/pdf/%-slides.pdf)
STUDENT_NOTES+=$(PRESENTATIONS:$(PRESENTATIONDIR)/%.presentation=$(OUTDIR)/pdf/%-student-notes.pdf)
PRESENTER_NOTES+=$(PRESENTATIONS:$(PRESENTATIONDIR)/%.presentation=$(OUTDIR)/pdf/%-presenter-notes.pdf)

$(OUTDIR)/fo/%-student-notes.fo: $(PRESENTATIONDIR)/%.presentation
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/single-notes-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .presentation) \
		format=Student > $@

$(OUTDIR)/fo/%-presenter-notes.fo: $(PRESENTATIONDIR)/%.presentation
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/notes/single-notes-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .presentation) \
		format=Presenter > $@

$(OUTDIR)/fo/%-slides.fo: $(PRESENTATIONDIR)/%.presentation
	@mkdir -p $(dir $@)
	$(XSLT2) -xsl:$(COURSEWARE_HOME)/xslt/slides/single-slides-to-fo.xsl \
		-s:$< \
		timestamp="$(TIMESTAMP)" \
		build="$(BUILD)" \
		courseCode=$(shell basename $< .course) > $@
endif

slides: $(SLIDES)
student-notes: $(STUDENT_NOTES)
presenter-notes: $(PRESENTER_NOTES)

$(OUTDIR)/pdf/%.pdf: $(OUTDIR)/fo/%.fo
	@mkdir -p $(dir $@)
	fop -fo $< -pdf $@

clean:
	rm -rf $(OUTDIR)

again: clean all

list:
	@echo slides: $(SLIDES)
	@echo student-notes: $(STUDENT_NOTES)
	@echo presenter-notes: $(PRESENTER_NOTES)

.PHONY: clean again all slides student-notes presenter-notes list

