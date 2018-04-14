import os
from operator import itemgetter
from typing import Sequence, Tuple, Dict

DIRECTORY = os.path.dirname(os.path.realpath(__file__))

def imax(xs: Sequence[int]) -> Tuple[int, int]:
    return max(enumerate(xs), key=itemgetter(1))

def snapshot(xs: Sequence[int]) -> str:
    return '.'.join(str(x) for x in xs)

def redistributions(banks: Sequence[int]) -> Tuple[int, int]:
    banks, iteration, size = list(banks), 0, len(banks)
    snapshots = {} # type: Dict[str, int]
    banks_snapshot = snapshot(banks)
    while banks_snapshot not in snapshots:
        snapshots[banks_snapshot] = iteration
        idx, blocks = imax(banks)
        banks[idx] = 0
        for it in range(1, blocks + 1):
            banks[(idx + it) % size] += 1
        iteration += 1
        banks_snapshot = snapshot(banks)
    return iteration, iteration - snapshots[banks_snapshot]

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        banks = [int(x) for x in fin.read().split()]
    part1, part2 = redistributions(banks)
    print(part1)
    print(part2)

if __name__ == '__main__':
    main()