import os
from typing import Sequence, Callable

DIRECTORY = os.path.dirname(os.path.realpath(__file__))

def no_duplicates(passphrase: Sequence[str]) -> bool:
    return len(passphrase) == len(set(passphrase))

def no_anagrams(passphrase: Sequence[str]) -> bool:
    return no_duplicates([''.join(sorted(word)) for word in passphrase])

def valid_passphrases(passphrases: Sequence[Sequence[str]],
                      is_valid: Callable[[Sequence[str]], bool]) -> int:
    return sum((1 for passphrase in passphrases if is_valid(passphrase)))

def valid_passphrases_part1(passphrases: Sequence[Sequence[str]]) -> int:
    return valid_passphrases(passphrases, no_duplicates)

def valid_passphrases_part2(passphrases: Sequence[Sequence[str]]) -> int:
    return valid_passphrases(passphrases, no_anagrams)

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        passphrases = [line.split() for line in fin]
    print(valid_passphrases_part1(passphrases))
    print(valid_passphrases_part2(passphrases))

if __name__ == '__main__':
    main()