import unittest
from main import exit_part1, exit_part2

class TestDay5(unittest.TestCase):
    def setUp(self):
        self.offsets = [0,3,0,1,-3]

    def test_part1(self):
        self.assertEqual(exit_part1(self.offsets), 5)

    def test_part2(self):
        self.assertEqual(exit_part2(self.offsets), 10)

if __name__ == '__main__':
    unittest.main()