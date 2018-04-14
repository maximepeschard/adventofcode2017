.PHONY: all clean

DAY = $(shell ls | grep day | sort -n -k 1.4 | tail -n 1)
OCB_FLAGS = -lib str -I common -I $(DAY)
OCB = ocamlbuild $(OCB_FLAGS)

all: tests main

clean:
	$(OCB) -clean

%.native: ${DAY}/*.ml
	$(OCB) $@

%.byte: ${DAY}/*.ml
	$(OCB) $@

tests: ${DAY}/tests.native
	./tests.native $(DAY)/input_tests.txt

main: ${DAY}/main.native
	./main.native $(DAY)/input.txt
