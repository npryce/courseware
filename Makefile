

SCHEMA:=$(shell find schema/*)
XSLT:=$(shell find xslt -not \( -name test -and -prune \))
XXE:=$(shell find xxe/*)

all: build/xxe/courseware-xxe-config.zip

build/xxe/courseware-xxe-config.zip: $(SCHEMA:schema/%=build/xxe/courseware/%) $(XXE:xxe/%=build/xxe/courseware/%)
	zip $@ $^

build/xxe/courseware/%: xxe/%
	@mkdir -p $(dir $@)
	cp $< $@

build/xxe/courseware/%: schema/%
	@mkdir -p $(dir $@)
	cp $< $@

build/tests.xslt: testing/tests.xslt
	@mkdir -p $(dir $@)
	bin/saxon -xsl:xslt/testing/testing.xslt -s:$< -o:$@

build/testing/results.xml: build/tests.xslt $(XSLT)
	bin/saxon -xsl:$< -it:tests -o:$@

check: build/testing/results.xml
	bin/saxon -xsl:xslt/testing/test-abort-build.xslt -s:$<

clean:
	rm -rf build

again: clean all

.PHONY: all check clean again

