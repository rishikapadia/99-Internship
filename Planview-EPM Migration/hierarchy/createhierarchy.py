"""
python2.7

run:
C:\Python27\python.exe .\Documents\Planview_EPM\createhierarchy.py

"""

import os, sys

file_name = raw_input("Enter the path to the hierarchy.txt file: ")
#file_name = "C:\Users\Rishi.kapadi.DOMAIN99\Documents\Planview_EPM\hierarchy.txt"
currLevel = 1
#root_dir = raw_input("Enter the path where to create the hierarchy: ")
root_dir = "C:\\test"
prev_dir = ""

#root_dir = '\\\\?\\' + root_dir
os.chdir(root_dir)

def makeDir(dir_name):
	#os.system('mkdir "'+dir_name+'"')
	#try:
	#os.mkdir(unicode("\\\\?\\"+root_dir+'\\'+dir_name))
	#except WindowsError as err:
	#	print("\nERROR ON: " + dir_name+"\n")
	#	print(err)
	os.system('mkdir "'+dir_name+'"')  #escape slashes and spaces

#"cd .." for num times
def cdup(num):
	for _ in range(num):
		os.chdir("..")

#cd to prev_dir
def cddown(prev_dir):
	os.chdir(".\\"+prev_dir)


with open(file_name) as f:
	for line in f:
		if line[0] == "F":
			print(line)
			continue
		i=1
		while (line[i] == "-"):
			i+=1
		#print("currLevel="+str(currLevel)+" i="+str(i))
		file_name = line[i:].strip().replace(">: ", "").replace('/', "-").replace('\\', "-").replace(":", "--").replace("*", "_").replace("?", "").replace('"', "'").replace("<", "(").replace(">", ")").replace("|", "--")
		if (currLevel > i):
			cdup(currLevel - i)
			currLevel = i
			makeDir(file_name)
		elif (currLevel == i-1):
			cddown(prev_dir)
			currLevel += 1
			makeDir(file_name)
		elif (currLevel == i):
			makeDir(file_name)
		else:
			ans = raw_input("Error! Quit? Y/N:")
			if ans == "Y":
				sys.exit(0)
		prev_dir = file_name
		print("-"*i + file_name)

print("Successful!")



"""
----------------


top
-L11
-L12
--L21
--L22
---L31
--L23
---L32
F
-L13
--L24
---L33
----L41
etc

"""
