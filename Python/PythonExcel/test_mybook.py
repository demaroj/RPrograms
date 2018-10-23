import xlwings as xw
import time

sheet = xw.book.active.sheets.active

x=sheet["A3"].value

while True:
    y = sheet["A3"].value
    if x != y:
        x=y
        print(x)
        
        time.sleep(0.5)