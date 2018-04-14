import unittest
from main import redistributions

class TestDay6(unittest.TestCase):
    def setUp(self):
        self.banks = [0,2,7,0]

    def test_part1(self):
        self.assertEqual(redistributions(self.banks)[0], 5)

    def test_part2(self):
        self.assertEqual(redistributions(self.banks)[1], 4)

if __name__ == '__main__':
    unittest.main()