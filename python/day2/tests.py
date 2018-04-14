import unittest
from main import checksum_part1, checksum_part2

class TestDay2(unittest.TestCase):
    def test_part1(self):
        spreadsheet = [[5,1,9,5], [7,5,3], [2,4,6,8]]
        self.assertEqual(checksum_part1(spreadsheet), 18)

    def test_part2(self):
        spreadsheet = [[5,9,2,8], [9,4,7,3], [3,8,6,5]]
        self.assertEqual(checksum_part2(spreadsheet), 9)

if __name__ == '__main__':
    unittest.main()