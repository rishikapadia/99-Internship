"""
python2.7

run:
C:\Python27\python.exe .\Documents\Planview_EPM\modifytasklist.py
"""

import os, sys, glob, csv, xlwt, xlrd
from os import listdir
from xlwt import Font, XFStyle

#task_lists = raw_input("Enter the path to the directory of task lists: ")
#task_lists = "M:\pv-download\\task-lists"
task_lists = "C:\Users\Rishi.kapadi.DOMAIN99\Documents\Planview_EPM\\task-lists"
#new_lists = raw_input("Enter the path where to place the modified task lists: ")
#new_lists = "M:\pv-download\\task_lists_modified"
new_lists = "C:\Users\Rishi.kapadi.DOMAIN99\Documents\Planview_EPM\\task_lists_modified"

os.chdir(task_lists)
tasks = listdir(".")


def xlsx_to_csv(excel_name, csv_name):
	wb = xlrd.open_workbook(excel_name)
	sh = wb.sheet_by_name('Sheet1')
	your_csv_file = open(csv_name, 'wb')
	wr = csv.writer(your_csv_file, quoting=csv.QUOTE_ALL)
	for rownum in xrange(sh.nrows):
		wr.writerow(sh.row_values(rownum))
	your_csv_file.close()


for excel in tasks:
	output_name = new_lists + "\\" + excel.replace(".xlsx", ".csv")
	task = output_name.replace(".csv", "___temp.csv")
	xlsx_to_csv(excel, task)
	output = open (output_name, 'a+')
	with open(task) as f:
		firstline = True
		for line in f:
			if firstline:
				output.write(str(line))
				firstline = False
				continue
			fields = line.split(",")
			lineNum = fields[0].replace('"', "").replace("'", "")
			if lineNum == "":
				output.write(str(line))
				continue
			lineNum = int(float(lineNum))
			fields[0] = lineNum
			descr = fields[1].replace('"', "").replace(">: ", "")
			phase = fields[7].replace('"', "").strip()
			phaseType = ""
			if phase == "Design" or phase == "Develop" or phase == "Debug":
				phaseType = "CAP"
			else:
				phaseType = "Expense"
			fields[1] = str(lineNum)+" "+str(descr)+" ("+phase+") ("+phaseType+")"
			newline = ""
			for i in fields:
				newline += str(i) + ","
			newline = newline[:-1]
			output.write(str(newline))
	output.close()

os.chdir(new_lists)

for csvfile in glob.glob(os.path.join('.', '*___temp.csv')):
	os.remove(csvfile)


def is_float(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

def is_int(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

"""#csv to xls
for csvfile in glob.glob(os.path.join('.', '*.csv')):
	wb = xlwt.Workbook()
	ws = wb.add_sheet('data')
	with open(csvfile, 'rb') as f:
		reader = csv.reader(f)
		for r, row in enumerate(reader):
			for c, col in enumerate(row):
				if r == 0:
					font0 = Font()
					font0.bold = True
					style0 = XFStyle()
					style0.font = font0
					ws.write(r, c, col, style0)
				elif is_int(col):
					ws.write(r, c, int(col))
				elif is_float(col):
					ws.write(r, c, float(col))
				else:
					ws.write(r, c, col)
	wb.save(csvfile.replace(".csv", ".xls"))
	os.remove(csvfile)
"""

#csv to xlsx
import xlsxwriter
for csvfile in glob.glob(os.path.join('.', '*.csv')):
	wb = xlsxwriter.Workbook(csvfile.replace(".csv", ".xlsx"))
	ws = wb.add_worksheet('Sheet1')
	bold = wb.add_format({'bold': True})	
	with open(csvfile, 'rb') as f:
		reader = csv.reader(f)
		i = 0
		for r, row in enumerate(reader):
			for c, col in enumerate(row):
				if r == 0:
					ws.write(r, c, col, bold)
				elif is_int(col):
					ws.write(r, c, int(col))
				elif is_float(col):
					ws.write(r, c, float(col))
				else:
					ws.write(r, c, col)
	wb.close()
	os.remove(csvfile)	


print("Successful!")

