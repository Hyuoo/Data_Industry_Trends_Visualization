import unittest
from dec_to_hex import dec_to_hex

class my_test(unittest.TestCase):

    def test_case1(self):
        ans = dec_to_hex(1)
        self.assertEqual(ans, "%#x"%1)

    def test_case2(self):
        ans = dec_to_hex(100)
        self.assertEqual(ans, "%#x"%100)
    
    def test_case3(self):
        ans = dec_to_hex(0)
        self.asserNotEqual(ans, "0")

if __name__=="__main__":
    unittest.main()
