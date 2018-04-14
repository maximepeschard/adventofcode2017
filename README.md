# Advent of Code 2017

My attempt at solving the series of programming puzzles from [Advent of
Code](http://adventofcode.com/2017).

## Python

See the [python](python) directory. There is a directory for each day, with
a `main.py` file for both I/O and core core, plus a `tests.py` file contaning
a `unittest` test case.

### Running

To get my answers for day `N`, with `python` as the working directory :

```sh
python dayN/main.py
```

### Tests

To run tests for day `N` :

```sh
python dayN/tests.py -v
```

## OCaml

See the [ocaml](ocaml) directory. There is a directory for each day, with
a `<puzzle_related_name>.ml` file containing the core code, a `main.ml` file for I/O.

### Running

To get my answers for the most recent day, with `ocaml` as the working directory :

```sh
make main
```

To get my answers for day `N` :

```sh
make main DAY=dayN
```

### Tests

I try to include tests from the puzzle wording, to run them for day `N` :

```sh
make tests DAY=dayN
```
