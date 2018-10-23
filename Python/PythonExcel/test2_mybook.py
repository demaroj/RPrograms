import unittest
import xlwings as xw

class TestMyBook(unittest.TestCase):
    def setUp(self):
        # setUp will be called before the execution of each unit test
        self.wb = xw.Book('mybook.xlsm')  # map workbook
        self.mysum = self.wb.macro('Module1.mysum')  # map function

    def test_mysum(self):
        result = self.mysum(1, 2)  # get result from VBA
        self.assertAlmostEqual(3, result)  # test if result corresponds to the expected value

if __name__ == '__main__':
    # This allows us to easily run the tests from the command prompt
    unittest.main()