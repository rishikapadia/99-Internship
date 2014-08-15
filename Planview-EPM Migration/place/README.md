Place
=====

Just like on Planview, I needed to recreate the folder hierarchy with the documents within them on a shared network drive.

This assignment relied heavily on my experience with web crawlers and scrapers.

On the main screen of the Planview documents center:

![Main Screen](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/main.jpg)

There is a hierarchy view on the left-hand side. It is relatively easy to parse this HTML iframe once to obtain a list of all document names in a hashtable (the keys will be the folder names, and values are to be explained later).

In the main frame on this page, we can do the same to obtain a list of the names of all documents and folders in the current folder:

![Current Items](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/doc_find.jpg)

Using the list of items in the current view, we can iterate over all items and determine which ones are folders by O(1) time lookup in our hashtable.

For all documents in the list of items, we use the url method described in [download](https://github.com/rishikapadia/99-Internship/tree/master/Planview-EPM%20Migration/download) and download that document to the current folder.

For each folder in the list of items, we create and enter a new folder in the current working directory, crawl the Planview site by "clicking" on the corresponding link in the navigation menu on the page, and use recursion to repeat the process.

The "clicking" behavior can be mimicked by inspecting the source code of the navigation iframe:

![Navigation](https://github.com/rishikapadia/99-Internship/blob/master/Planview-EPM%20Migration/planview-pics/doc_select.jpg)

Each entry in this navigation list contains a link, which calls a javascript function with a unique parameter to update the main folder view. We now know how to crawl through different folders on the online Planview site. Thus, the values in our hashtable should be that unique parameter.

In conclusion, we are now able to crawl through the Planview site, determine the contents of each folder, download documents, and recurse through the subdirectories to recreate the entire structure on a local or shared drive.

(In Progress)

