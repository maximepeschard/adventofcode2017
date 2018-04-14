import os
from typing import Sequence, Callable

DIRECTORY = os.path.dirname(os.path.realpath(__file__))

def max_diff(xs: Sequence[int]) -> int:
    return max(xs) - min(xs)

def even_div(xs: Sequence[int]) -> int:
    for i, x in enumerate(xs):
        for y in xs[i+1:]:
            if max(x, y) % min(x, y) == 0:
                return int(max(x, y) / min(x, y))
    raise Exception('invalid spreadsheet')

def checksum(spreadsheet: Sequence[Sequence[int]],
             row_func: Callable[[Sequence[int]], int]) -> int:
    return sum((row_func(row) for row in spreadsheet))

def checksum_part1(spreadsheet: Sequence[Sequence[int]]) -> int:
    return checksum(spreadsheet, max_diff)

def checksum_part2(spreadsheet: Sequence[Sequence[int]]) -> int:
    return checksum(spreadsheet, even_div)

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        spreadsheet = [[int(x) for x in line.split()] for line in fin]
    print(checksum_part1(spreadsheet))
    print(checksum_part2(spreadsheet))

if __name__ == '__main__':
    main()