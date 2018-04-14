import os
import re
from operator import itemgetter
from typing import Sequence, List, Tuple, Dict, Optional

DIRECTORY = os.path.dirname(os.path.realpath(__file__))
INFO_REGEX = r"([a-z]+)\s+\((\d+)\)(?:\s+->\s+(.*))*"
CHILDREN_SPLIT_REGEX = r",\s+"

class Tree(object):
    def __init__(self, name: str, weight: int, children: Sequence['Tree'] = []) -> None:
        self.name = name
        self.weight = weight
        self.children = children

    @property
    def is_leaf(self):
        return len(self.children) == 0

def parent(program: str, programs: Dict[str, Tuple[int, Sequence[str]]]) -> Optional[str]:
    for name, info in programs.items():
        if program in info[1]:
            return name
    return None

def root(programs: Dict[str, Tuple[int, Sequence[str]]]) -> str:
    current_node = list(programs.keys())[0]
    current_parent = parent(current_node, programs)
    while current_parent is not None:
        current_node = current_parent
        current_parent = parent(current_node, programs)
    return current_node

def tree(root: str, programs: Dict[str, Tuple[int, Sequence[str]]]):
    weight, children = programs[root]
    return Tree(root, weight, [tree(c, programs) for c in children])

def imin(xs: Sequence[int]) -> int:
    return min(enumerate(xs), key=itemgetter(1))[0]

def outlier_index(xs: Sequence[int]):
    counts = [xs.count(x) for x in xs]
    return imin(counts)

def correct_helper(node: Tree) -> Tuple[bool, int]:
    if node.is_leaf:
        return False, node.weight
    res_children = [correct_helper(child) for child in node.children]
    corrected = [res for res in res_children if res[0]]
    if len(corrected) > 0:
        return corrected[0]
    cumulated_weights = [res[1] for res in res_children]
    if len(set(cumulated_weights)) == 1:
        return False, node.weight + sum(cumulated_weights)
    else:
        faulty_index = outlier_index(cumulated_weights)
        faulty = cumulated_weights[faulty_index]
        correct = cumulated_weights[(faulty_index + 1) % len(cumulated_weights)]
        return True, node.children[faulty_index].weight + correct - faulty

def corrected_weight(program_tree: Tree) -> int:
    return correct_helper(program_tree)[1]

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        programs = {} # type: Dict[str, Tuple[int, Sequence[str]]]
        for line in fin:
            name, weight, children = re.findall(INFO_REGEX, line)[0]
            programs[name] = (
                int(weight),
                re.split(CHILDREN_SPLIT_REGEX, children) if len(children) > 0 else []
            )
    programs_root = root(programs)
    print(programs_root)
    print(corrected_weight(tree(programs_root, programs)))

if __name__ == '__main__':
    main()