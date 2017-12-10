.PHONY: all clean test main

DAY = $(shell ls | grep day | sort -n -k 1.4 | tail -n 1)
OCB_FLAGS = -lib str -I common -I $(DAY)
OCB = ocamlbuild $(OCB_FLAGS)

all: native byte

clean:
	$(OCB) -clean

%.native: ${DAY}/*.ml
	$(OCB) $@

%.byte: ${DAY}/*.ml
	$(OCB) $@

tests: ${DAY}/tests.native
	./tests.native

main: ${DAY}/main.native
	./main.native $(DAY)/input.txt
