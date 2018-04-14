import os
from typing import Sequence

DIRECTORY = os.path.dirname(os.path.realpath(__file__))

def get(xs: Sequence[int], position: int, offset: int) -> int:
    return xs[(position + offset) % len(xs)]

def solution(captcha: Sequence[int], comp_offset: int) -> int:
    return sum((x for i, x in enumerate(captcha) if x == get(captcha, i, comp_offset)))

def solution_part1(captcha: Sequence[int]) -> int:
    return solution(captcha, 1)

def solution_part2(captcha: Sequence[int]) -> int:
    return solution(captcha, int(len(captcha) / 2))

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        captcha = [int(x) for x in fin.read().strip()]
    print(solution_part1(captcha))
    print(solution_part2(captcha))

if __name__ == '__main__':
    main()