Download
========

The way to download documents manually, one at a time, was to click on a particular document's name:

![Main Page](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/main.jpg)

This would take you to a detail-view. From here, clicking on <code>Read</code> would automatically download the file to your computer.

![Read Document](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/read.jpg)

My task was to figure out how to automate the process to download about 1400 documents, without having to click on each one manually. Fortunately, a quick look at the page source of the HTML and JavaScript code enabled me to do just that.

In the image directly above, the cursor hovers above the <code>Read</code> option. We can see in the bottom-left corner that this is actually a link, to a url. Upon closer inspection of the url, we can deduce that this looks similar to an <code>HTTP GET request</code>, with <code>id=1334</code> as a parameter. This hints to us that each document has a unique id that is used to download that document via a simple HTTP call.

To automate downloading all files from Planview, I needed to find a list of all documents. If we look back to the main documents page:

![Main Page](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/main.jpg)

I found this by clicking on <code>View all content</code> in the upper-right corner:

![View all content](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/view_content.jpg)

A look at the source code of this page:

![Vew all content source](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/doc_ids.jpg)

Looking through the different HTML tables on this page, it is confirmed that each document link has a document ID associated with it.

The entire source code can be seen in [frame_source.txt](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/download/frame_source.txt).

I created and ran the script in [downloadcodes.py](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/download/downloadcodes.py) to extract all document IDs into a list, which was saved in [content_codes.txt](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/download/content_codes.txt).

Using the list of document IDs, [downloadfiles.js](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/download/downloadfiles.js) makes a call to the <code>Read</code> url pattern discussed above for each of the documents.

[change_filenames.py](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/download/change_filenames.py) was used after the files were downloaded to a local computer to remove the internal references that Planview prefixed to the document names.

