Python 2.7.14 (v2.7.14:84471935ed, Sep 16 2017, 20:25:58) [MSC v.1500 64 bit (AMD64)] on win32
Type "copyright", "credits" or "license()" for more information.
>>> import openpyxl
>>> openpyxl.__version__
'2.5.7'
>>> os.chdir('c:\pythonexcel')

Traceback (most recent call last):
  File "<pyshell#2>", line 1, in <module>
    os.chdir('c:\pythonexcel')
NameError: name 'os' is not defined
>>> os.chdir('c:\\pythonexcel')

Traceback (most recent call last):
  File "<pyshell#3>", line 1, in <module>
    os.chdir('c:\\pythonexcel')
NameError: name 'os' is not defined
>>> import os
>>> os.chdir('c:\\pythonexcel')
>>> wb=openpyxl.load_workbook('mybook.xlsm')
>>> sheet=wb.get_sheet_by_name('Sheet1')

Warning (from warnings module):
  File "__main__", line 2
DeprecationWarning: Call to deprecated function get_sheet_by_name (Use wb[sheetname]).
>>> type(wb)
<class 'openpyxl.workbook.workbook.Workbook'>
>>> wb.get_sheet_names()

Warning (from warnings module):
  File "__main__", line 2
DeprecationWarning: Call to deprecated function get_sheet_names (Use wb.sheetnames).
[u'Sheet1']
>>> sheet = wb['Sheet1']
>>> sheet['A1'].value
>>> sheet['A2'].value
u'Item 1'
>>> sheet['A2'].value = 'ITEM 7'
>>> sheet['A2'].value = 'ITEM 7'
>>> sheet['A11'].value = 999
>>> wb.save('example.xlsx')
>>> sheet['A17'].value = '=xltest()'
>>> wb
<openpyxl.workbook.workbook.Workbook object at 0x0000000003F59B00>
>>> sheet['A12'].value = 8982456
>>> sheet['A12'].value = 8982456
>>> wb.save('example.xlsx')
>>> 
