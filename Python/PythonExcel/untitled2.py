Python 2.7.14 (v2.7.14:84471935ed, Sep 16 2017, 20:25:58) [MSC v.1500 64 bit (AMD64)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> import openpyxl
>>> openpyxl.__version__
'2.5.7'
>>> import os
>>> os.chdir('c:\\pythonexcel')
>>> wb = openpyxl.load_workbook('mybook.xlsm')
>>> wb.get_sheet_names()

Warning (from warnings module):
  File "__main__", line 2
DeprecationWarning: Call to deprecated function get_sheet_names (Use wb.sheetnames).
[u'Sheet1']
>>> sheet = wb.get_sheet_by_name('Sheet1')

Warning (from warnings module):
  File "__main__", line 2
DeprecationWarning: Call to deprecated function get_sheet_by_name (Use wb[sheetname]).
>>> sheet['A2'].value
u'Item 1'
>>> 
>>> sheet['A3'].value
u'Item 2'
>>> sheet['A3'].value = "ITEM 10"
>>> wb.save('example9212018.xlsx')
>>> import xlwings as xw

Traceback (most recent call last):
  File "<pyshell#12>", line 1, in <module>
    import xlwings as xw
ImportError: No module named xlwings
>>> import xlwings as xw

Traceback (most recent call last):
  File "<pyshell#13>", line 1, in <module>
    import xlwings as xw
  File "C:\Python27\lib\site-packages\xlwings\__init__.py", line 23, in <module>
    from . import _xlwindows as xlplatform
  File "C:\Python27\lib\site-packages\xlwings\_xlwindows.py", line 10, in <module>
    import win32api
ImportError: No module named win32api
>>> 
