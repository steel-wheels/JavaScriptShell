#
# Makefile
#

LIB_DIR	= ../Library

include $(LIB_DIR)/Makefile.inc

all: lib hello.js

lib: types/Library.d.ts

types/Library.d.ts: $(LIB_DIR)/types/Library.d.ts
	cp $< $@

clean:
	rm -f hello.js

