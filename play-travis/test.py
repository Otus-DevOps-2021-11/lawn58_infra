import unittest

class NumbersTest(unittest.TestCase):

    def test_equal(self):
play-travis
        self.assertEqual(1 + 1, 2)
=======
        self.assertEqual(1 , 1)
main

if __name__ == '__main__':
    unittest.main()
