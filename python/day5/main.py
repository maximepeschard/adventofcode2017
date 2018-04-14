import os
from typing import Sequence, Callable

DIRECTORY = os.path.dirname(os.path.realpath(__file__))

def exit(offsets: Sequence[int], update: Callable[[int], int]) -> int:
    offsets = list(offsets)
    position, size, steps = 0, len(offsets), 0
    while position >= 0 and position < size:
        jump = offsets[position]
        offsets[position] = update(jump)
        position += jump
        steps += 1
    return steps

def exit_part1(offsets: Sequence[int]) -> int:
    return exit(offsets, lambda x: x + 1)

def exit_part2(offsets: Sequence[int]) -> int:
    return exit(offsets, lambda x: x - 1 if x >= 3 else x + 1)

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        offsets = [int(line) for line in fin]
    print(exit_part1(offsets))
    print(exit_part2(offsets))

if __name__ == '__main__':
    main()