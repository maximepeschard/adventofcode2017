import unittest
from main import valid_passphrases_part1, valid_passphrases_part2

class TestDay4(unittest.TestCase):
    def test_part1(self):
        passphrase_1 = ["aa", "bb", "cc", "dd", "ee"]
        passphrase_2 = ["aa", "bb", "cc", "dd", "aa"]
        passphrase_3 = ["aa", "bb", "cc", "dd", "aaa"]
        self.assertEqual(valid_passphrases_part1([passphrase_1]), 1)
        self.assertEqual(valid_passphrases_part1([passphrase_2]), 0)
        self.assertEqual(valid_passphrases_part1([passphrase_3]), 1)

    def test_part2(self):
        passphrase_1 = ["abcde", "fghij"]
        passphrase_2 = ["abcde", "xyz", "ecdab"]
        passphrase_3 = ["a", "ab", "abc", "abd", "abf", "abj"]
        passphrase_4 = ["iiii", "oiii", "ooii", "oooi", "oooo"]
        passphrase_5 = ["oiii", "ioii", "iioi", "iiio"]
        self.assertEqual(valid_passphrases_part2([passphrase_1]), 1)
        self.assertEqual(valid_passphrases_part2([passphrase_2]), 0)
        self.assertEqual(valid_passphrases_part2([passphrase_3]), 1)
        self.assertEqual(valid_passphrases_part2([passphrase_4]), 1)
        self.assertEqual(valid_passphrases_part2([passphrase_5]), 0)

if __name__ == '__main__':
    unittest.main()