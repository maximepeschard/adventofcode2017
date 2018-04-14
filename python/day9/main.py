import os
import re
from typing import Tuple

DIRECTORY = os.path.dirname(os.path.realpath(__file__))

def remove_canceled(stream: str) -> str:
    return re.sub(r"!.", "", stream)

def count(stream: str) -> Tuple[int, int]:
    outer_score, score = 0, 0
    in_garbage, garbage_count = False, 0
    for c in remove_canceled(stream):
        if c == '{' and not in_garbage:
            score += outer_score + 1
            outer_score += 1
        elif c == '}' and not in_garbage:
            outer_score -= 1
        elif c == '<' and not in_garbage:
            in_garbage = True
        elif c == '>' and in_garbage:
            in_garbage = False
        elif in_garbage:
            garbage_count += 1
    return score, garbage_count

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        stream = fin.read()
    part1, part2 = count(stream)
    print(part1)
    print(part2)

if __name__ == '__main__':
    main()