import unittest
from main import root, tree, corrected_weight

class TestDay7(unittest.TestCase):
    def setUp(self):
        self.programs = {
            "pbga": (66, []),
            "xhth": (57, []),
            "ebii": (61, []),
            "havc": (66, []),
            "ktlj": (57, []),
            "fwft": (72, ["ktlj", "cntj", "xhth"]),
            "qoyq": (66, []),
            "padx": (45, ["pbga", "havc", "qoyq"]),
            "tknk": (41, ["ugml", "padx", "fwft"]),
            "jptl": (61, []),
            "ugml": (68, ["gyxo", "ebii", "jptl"]),
            "gyxo": (61, []),
            "cntj": (57, [])
        }

    def test_part1(self):
        self.assertEqual(root(self.programs), "tknk")

    def test_part2(self):
        self.assertEqual(corrected_weight(tree(root(self.programs), self.programs)), 60)

if __name__ == '__main__':
    unittest.main()