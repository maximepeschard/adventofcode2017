import unittest
from main import count

class TestDay9(unittest.TestCase):
    def test_part1(self):
        self.assertEqual(count("{}")[0], 1)
        self.assertEqual(count("{{{}}}")[0], 6)
        self.assertEqual(count("{{},{}}")[0], 5)
        self.assertEqual(count("{{{},{},{{}}}}")[0], 16)
        self.assertEqual(count("{<a>,<a>,<a>,<a>}")[0], 1)
        self.assertEqual(count("{{<ab>},{<ab>},{<ab>},{<ab>}}")[0], 9)
        self.assertEqual(count("{{<!!>},{<!!>},{<!!>},{<!!>}}")[0], 9)
        self.assertEqual(count("{{<a!>},{<a!>},{<a!>},{<ab>}}")[0], 3)

    def test_part2(self):
        self.assertEqual(count("{<>}")[1], 0)
        self.assertEqual(count("{<random characters>}")[1], 17)
        self.assertEqual(count("{<<<<>}")[1], 3)
        self.assertEqual(count("{<{!>}>}")[1], 2)
        self.assertEqual(count("{<!!>}")[1], 0)
        self.assertEqual(count("{<!!!>>}")[1], 0)
        self.assertEqual(count('{<{o"i!a,<{i<a>}')[1], 10)

if __name__ == '__main__':
    unittest.main()