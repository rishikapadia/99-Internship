"""
python2.7

run:
C:\Python27\python.exe .\Documents\Planview_EPM\change_filenames.py


http://www.pythonregex.com/

"""

import os, sys, re
from os import listdir

#downloads = raw_input("Enter the path to the directory of downloaded files: ")
downloads = "M:\pv-download\SAP-P2P Docs\\346"
files = listdir(downloads)
os.chdir(downloads)

i = 0
for filename in files:
	for pattern in ["\.7346\.(.+?)$", "\.7346_(.+?)$", "^1\.(.+?)$"]:
		try:
			regex = re.compile(pattern)
			r = regex.search(filename)
			newname = r.group(1)
			newname = newname.strip()
			i += 1
			break
			#os.rename(filename, newname)
		except AttributeError:
			#print("ATTRIBUTE ERROR! No regex found: " + str(filename))
			pass
		except IndexError:
			pass
		#except OSError:
		#	print("OSError: "+str(filename))

print(str(i))
print("Successful!")



"""
goal: remove prefix (%1).736.(%2), change filename to (%2)
"""
