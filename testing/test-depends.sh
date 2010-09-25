#!/bin/bash

BASE=$(readlink -f $(dirname $0)/..)
COURSE=$BASE/testing/examples/small-course/small-course.course

COURSECODE=$(basename $COURSE .course)
ACTUAL=$BASE/build/test/$COURSECODE-actual.mk
EXPECTED=$BASE/build/test/$COURSECODE-expected.mk

mkdir -p $(dirname $ACTUAL)
sort $(dirname $COURSE)/expected-dependencies.mk > $EXPECTED
$BASE/bin/depends output testing/examples $COURSE | sort > $ACTUAL
diff $EXPECTED $ACTUAL
