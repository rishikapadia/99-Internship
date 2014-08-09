Hierarchy
=========

The task was to recreate the folder hierarchy from Planview onto a shared network drive. Here is the hierarchy as shown as Planview, after expanding all folders using [expandAll.js](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/hierarchy/expandAll.js):

![Hierarchy](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/select.jpg)

I have copied this list into [hierarchy_full.txt](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/hierarchy/hierarchy_full.txt).

I then used macros in a text editor to format that file to create [hierarchy.txt](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/hierarchy/hierarchy.txt), where I prefixed each line by dashes to indicate which level in the structure each folder occupied.

[createhierarchy.py](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/hierarchy/createhierarchy.py) is the script that takes the hierarchy text file and produces the hierarchy folder structure at the location specified upon input.

[final\_structure.txt](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/hierarchy/final_structure.txt) is the final folder hierarchy created by the script. The text file has been obtained by running <code>tree -A > final\_structure.txt</code> in Windows PowerShell.

