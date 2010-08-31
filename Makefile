

SCHEMA:=$(shell find schema/*)
XSLT:=$(shell find xslt -not \( -name test -and -prune \))
XXE:=$(shell find xxe/*)

all: build/xxe/courseware-xxe-config.zip

build/xxe/courseware-xxe-config.zip: $(SCHEMA:schema/%=build/xxe/courseware/%) $(XXE:xxe/%=build/xxe/courseware/%)
	(cd build/xxe && zip -r $(abspath $@) courseware)

build/xxe/courseware/%: xxe/%
	@mkdir -p $(dir $@)
	cp $< $@

build/xxe/courseware/%: schema/%
	@mkdir -p $(dir $@)
	cp $< $@

build/testing/tests.xslt: testing/tests.xslt
	@mkdir -p $(dir $@)
	bin/saxon -xsl:xslt/testing/testing.xslt -s:$< -o:$@

build/testing/results.xml: build/testing/tests.xslt $(XSLT)
	bin/saxon -xsl:$< -it:tests -o:$@

build/testing/report.html: build/testing/results.xml
	bin/saxon -xsl:xslt/testing/report.xslt -s:$< -o:$@

check: build/testing/report.html
	bin/saxon -xsl:xslt/testing/test-abort-build.xslt -s:build/testing/results.xml

clean:
	rm -rf build

again: clean all

install: build/xxe/courseware-xxe-config.zip
	(cd $(HOME)/.xxe4/addon && unzip $(abspath $<))

.PHONY: all check clean again install

