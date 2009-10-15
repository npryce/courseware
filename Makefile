

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

clean:
	rm -rf build

again: clean all
