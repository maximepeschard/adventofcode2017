import os
import re
from typing import Sequence, List, Tuple, Dict

DIRECTORY = os.path.dirname(os.path.realpath(__file__))
INSTRUCTION_REGEX = r"([a-z]+)\s+([a-z]+)\s+(-?\d+)\s+if\s+([a-z]+)\s+([<>=!]+)\s+(-?\d+)"

class Condition(object):
    op_to_func = {
        "==": lambda x, y: x == y,
        "!=": lambda x, y: x != y,
        ">=": lambda x, y: x >= y,
        "<=": lambda x, y: x <= y,
        "<": lambda x, y: x < y,
        ">": lambda x, y: x > y,
    }
    def __init__(self, register: str, operator: str, val: int) -> None:
        self._register = register
        self._operator = Condition.op_to_func[operator]
        self._val = val

    def evaluate(self, registers: Dict[str, int]) -> bool:
        return self._operator(registers.get(self._register, 0), self._val)

class Instruction(object):
    op_to_func = {
        "inc": lambda x, y: x + y,
        "dec": lambda x, y: x - y
    }
    def __init__(self, register: str, operation: str, val: int, condition: Condition) -> None:
        self._register = register
        self._operation = Instruction.op_to_func[operation]
        self._val = val
        self._condition = condition

    def execute(self, registers: Dict[str, int]) -> Dict[str, int]:
        if self._condition.evaluate(registers):
            new_registers = dict(registers)
            new_registers[self._register] = self._operation(registers.get(self._register, 0), self._val)
            return new_registers
        else:
            return registers

def run(instructions: Sequence[Instruction]) -> Tuple[int, int]:
    registers = {} # type: Dict[str, int]
    max_execution = 0
    for instruction in instructions:
        registers = instruction.execute(registers)
        max_execution = max(max_execution, max(registers.values(), default=0))
    return max(registers.values()), max_execution

def main() -> None:
    with open(os.path.join(DIRECTORY, 'input.txt')) as fin:
        instructions = [] # type: List[Instruction]
        for line in fin:
            reg, op, val, reg_cond, op_cond, val_cond = re.findall(INSTRUCTION_REGEX, line)[0]
            instructions.append(
                Instruction(reg, op, int(val), Condition(reg_cond, op_cond, int(val_cond)))
            )
    part1, part2 = run(instructions)
    print(part1)
    print(part2)

if __name__ == '__main__':
    main()