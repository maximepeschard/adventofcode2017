# Advent of Code 2017

My attempt at solving the series of programming puzzles from [Advent of
Code](http://adventofcode.com/2017).

Each day has a directory, with a `<puzzle_related_name>.ml` file containing the
core code, a `main.ml` file for I/O and possibly some input file.

## Running

To get my answers for the most recent day :

```sh
make main
```

To get my answers for day `N` :

```sh
make main DAY=dayN
```

## Tests

I try to include tests from the puzzle wording, to run them for day `N` :

```sh
make tests DAY=dayN
```
