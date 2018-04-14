import unittest
from main import solution_part1, solution_part2

class TestDay1(unittest.TestCase):
    def test_part1(self):
        self.assertEqual(solution_part1([1,1,2,2]), 3)
        self.assertEqual(solution_part1([1,1,1,1]), 4)
        self.assertEqual(solution_part1([1,2,3,4]), 0)
        self.assertEqual(solution_part1([9,1,2,1,2,1,2,9]), 9)

    def test_part2(self):
        self.assertEqual(solution_part2([1,2,1,2]), 6)
        self.assertEqual(solution_part2([1,2,2,1]), 0)
        self.assertEqual(solution_part2([1,2,3,4,2,5]), 4)
        self.assertEqual(solution_part2([1,2,3,1,2,3]), 12)
        self.assertEqual(solution_part2([1,2,1,3,1,4,1,5]), 4)

if __name__ == '__main__':
    unittest.main()