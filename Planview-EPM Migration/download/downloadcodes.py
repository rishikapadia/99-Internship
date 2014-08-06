"""
python2.7

run:
C:\Python27\python.exe .\Documents\Planview_EPM\downloadcodes.py


http://www.pythonregex.com/

"""

import os, sys, re#, urllib2
from os import listdir
#import urllib

#file_name = raw_input("Enter the path to the frame_source.txt file: ")
file_name = "C:\Users\Rishi.kapadi.DOMAIN99\Documents\Planview_EPM\\frame_source.txt"
#output = raw_input("Enter the path where to download the codes: ")
output = "C:\Users\Rishi.kapadi.DOMAIN99\Documents\Planview_EPM\content_codes.txt"
#downloads = raw_input("Enter the path to the directory of downloaded files: ")
downloads = "C:\Users\Rishi.kapadi.DOMAIN99\Downloads\PV Downloaded"


# create a list of source docID's
docIDs = []
docMap = {}
with open(file_name) as f:
	for line in f:
		try:
			regex = re.compile("\"contentdetail\.asp\?code=(.+?)\">(.+?)</a>")
			r = regex.search(line)
			found = r.group(1)
			nameSearch = r.group(2)
			docIDs.append(int(found)) #codeID appended
			#nameSearch = search+found+'">(.+?)\<\\a>'
			docMap[int(found)] = str(nameSearch)
		except AttributeError:
			pass
		#docIDs.append(code)

docIDs.sort()

#print(docIDs)
#print("\n"+str(len(docIDs)))

#urllib.urlretrieve("https://99store.planflex.net/planview/contentmanagement/readdoc.asp?id=722&pe=1", "C:\Users\Rishi.kapadi.DOMAIN99\Documents\Planview_EPM\\722")

mapping = "\n\nMapping:\n\n"
for i in range(len(docIDs)):
	mapping += str(docIDs[i]) + ": " + str(docMap[docIDs[i]]) + "\n"

files = listdir(downloads)
diff_files = {}
for key in docMap:
	if key in diff_files.keys():
		print("Duplicate: "+ str(key))
	else:
		diff_files[docMap[key]] = key

names = diff_files.keys()
names.sort()
for name in names:
	print(name+"\t"+str(diff_files[name]))

#print(len(diff_files))
for f in files:
	if f in diff_files.keys():
		del diff_files[f]
	else:
		pass
		#print("File not found: " + f)
#print(len(diff_files))


output = open(output, 'w+')
output.write(str(docIDs))
output.write(str("\n\n\n"))
output.write(str(mapping))
output.close()


print("Successful!")



"""
regex: "contentdetail.asp?code=(%)"

goal: https://99store.planflex.net/planview/contentmanagement/readdoc.asp?id=(%)&pe=1
"""
