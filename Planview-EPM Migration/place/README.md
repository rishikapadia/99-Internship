Place
=====

Just like on Planview, I needed to recreate the folder hierarchy with the documents within them on a shared network drive.

This assignment relied heavily on my experience with web crawlers.

On the main screen of the Planview documents center:

![Main Screen](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/main.jpg)

There is a hierarchy view on the left-hand side. It is relatively easy to parse this HTML iframe once to obtain a list of all document names in a Hash Set.

In the main frame on this page, we can do the same to obtain a list of the names of all documents and folders in the current folder:

![Current Items](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/doc_find.jpg)

Using the list of items in the current view, we can iterate over all items and determine which ones are folders by O(1) time lookup in our Hash Set.

For all documents in the list of items, we use the url method described in [download](https://github.com/rishikapadia/99-Internship/tree/master/Planview-EPM%20Migration/download) and download that document to the current folder.

For all 

(In Progress)

