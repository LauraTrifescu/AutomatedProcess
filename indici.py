from openpyxl import Workbook, load_workbook
from contextlib2 import closing
from datetime import date

def make_excel_file(file_name):
    with closing(Workbook()) as wb:
        wb.save(file_name)

def add_values_for_indicators(file_name, value1, value2, value3, value4):
    with closing(load_workbook(filename=file_name)) as wb:
        today = date.today()
        print("Today's date:", today)
        sheet_to_focus = 'Indici'

        for s in range(len(wb.sheetnames)):
            if wb.sheetnames[s] == sheet_to_focus:
                break
        wb.active = s
        ws = wb.active
        ws.append([today,value1,value2, value3, value4])
        wb.save(file_name)