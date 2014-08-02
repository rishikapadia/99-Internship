HTML5 Store Scrap App
=====================

This is a prototype of an SSO Cycle Count to be used on handheld devices at the company's retail stores to keep track of item information. It is a display of an article-lookup database running on one of 99's servers.

The version in the folder [local request](https://github.com/rishikapadia/99-Internship/tree/master/HTML5%20Store%20Scrap%20App/local%20request) is an example of an HTTP POST Request using JavaScript. It was used to access the required database from a local server that was on the 99 network. Because of cross-domain issues, it is not properly functional on all browsers or from computers that are not the server itself. It can run on Internet Explorer 9 from a local computer on the 99 network.

Because of limitations such as these, the version in the folder [asp](https://github.com/rishikapadia/99-Internship/tree/master/HTML5%20Store%20Scrap%20App/asp) is the current solution. It uses ASP.NET and VB.NET as backend to the application, and runs on Microsoft Internet Information Services 7 (IIS). It works successfully on a handheld MC9090 and MC9190 for use in 99's retail stores on any browser, even if not connected to the 99 network.

The [asp](https://github.com/rishikapadia/99-Internship/tree/master/HTML5%20Store%20Scrap%20App/asp) app, once enhanced with live databases, will be the actual app used to replace some of the older technologies currently used at the company.

<br>

The following images display the behavior of the final app:

<br>

Main Screen:

<center>

![Image of Main Screen](https://github.com/rishikapadia/99-Internship/blob/master/HTML5%20Store%20Scrap%20App/StoreScrapApp%20Pics/pic-1-main.JPG)

</center>

<br>

Article Look-up Screen:

<center>

![Image of Article Look-up Screen](https://github.com/rishikapadia/99-Internship/blob/master/HTML5%20Store%20Scrap%20App/StoreScrapApp%20Pics/pic-2-article.JPG)

</center>

<br>

Data Detail View:

<center>

![Image of Data Detail Pull](https://github.com/rishikapadia/99-Internship/blob/master/HTML5%20Store%20Scrap%20App/StoreScrapApp%20Pics/pic-3-data.JPG)

</center>
