import unittest
from main import run, Condition, Instruction

class TestDay8(unittest.TestCase):
    def setUp(self):
        self.instructions = [
            Instruction('b', 'inc', 5, Condition('a', '>', 1)),
            Instruction('a', 'inc', 1, Condition('b', '<', 5)),
            Instruction('c', 'dec', -10, Condition('a', '>=', 1)),
            Instruction('c', 'inc', -20, Condition('c', '==', 10))
        ]

    def test_part1(self):
        self.assertEqual(run(self.instructions)[0], 1)

    def test_part2(self):
        self.assertEqual(run(self.instructions)[1], 10)

if __name__ == '__main__':
    unittest.main()