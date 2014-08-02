<%@ Import Namespace="system.net" %>
<%@ Import Namespace="system.text" %>
<%@ Import Namespace="system.xml" %>
<%@ Import Namespace="system.io" %>
<%@ Page Language="vb" Debug="true" %>



<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<title>Store Scrap App</title>
	<meta name="description" content="Store Scrap info webpage"/>
	<meta name="author" content="99 Cents Only, inc. Developed by RK"/>
	<meta name="copyright" content="99 Cents Only, inc. Copyright (c) 2014"/>
	<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="storeScrap.css"></link>
</head>
<body>

<div class="outer" id="article">
	<div class="menu-title">
		<h1>Article Look-up</h1>
	</div>

	<div id="nav" style="position:absolute; z-index: 2; width: 265px;">
		<button name="article-back" type="submit" onclick="location.href='storeScrapMain.aspx';" style="float:left; width: 130px;">Back</button>
		<button name="article-refr" type="submit" onclick="location.href='storeScrapArticle.aspx';" style="float: right; width: 130px;">Refresh</button>
	</div>

	<form runat="server" style="position:absolute; z-index: 1; width: 400px;">

		<asp:button id="articlego" runat="server" text="GO" onclick="submitarticlego" width="130px" style="float: right;" /><br><br>
		<div style="background-color: #EEEEEE; padding-left: 5%;">
			Product #: <asp:textbox runat="server" id="artprod"/>
		</div>
		<br>
		<div id="articleInfo" runat="server" style="height: 200px; margin-left: 5px; margin-right: 20px; overflow-y: scroll;">
			Information: <br>
		</div>

	</form>
</div>



<script runat="server">
'http://www.808.dk/?code-vbnet-httpwebrequest


Function WRequest(URL As String, method As String, POSTdata As String) As String
  Dim responseData As String = ""
  Try
    Dim hwrequest As Net.HttpWebRequest = Net.Webrequest.Create(URL)
    hwrequest.Accept = "*/*"
    hwrequest.UseDefaultCredentials = true
    hwrequest.PreAuthenticate = true
    hwrequest.Credentials = CredentialCache.DefaultCredentials
    hwrequest.AllowAutoRedirect = true
    hwrequest.UserAgent = "http_requester/0.1"
    hwrequest.Timeout = 60000
    hwrequest.Method = method
    If hwrequest.Method = "POST" Then
      hwrequest.ContentType = "application/x-www-form-urlencoded"
      Dim encoding As New Text.ASCIIEncoding() 'Use UTF8Encoding for XML requests
      Dim postByteArray() As Byte = encoding.GetBytes(POSTdata)
      hwrequest.ContentLength = postByteArray.Length
      Dim postStream As IO.Stream = hwrequest.GetRequestStream()
      postStream.Write(postByteArray, 0, postByteArray.Length)
      postStream.Close()
    End If
    Dim hwresponse As Net.HttpWebResponse = hwrequest.GetResponse()
    If hwresponse.StatusCode = Net.HttpStatusCode.OK Then
      Dim responseStream As IO.StreamReader = _
        New IO.StreamReader(hwresponse.GetResponseStream())
      responseData = responseStream.ReadToEnd()
    End If
    hwresponse.Close()
    Catch e As Exception
      responseData = "An error occurred: " & e.Message
    End Try
  Return responseData
End Function


Function parseXml(xmlString as String) As String
	Dim data As String = ""

	'replacing < and >
	xmlString = Replace(xmlString, "&lt;", "<")
	xmlString = Replace(xmlString, "&gt;", ">")

	Dim i as Integer = 0
	While i < xmlString.length - 1
		Dim remaining as String = xmlString.Substring(i, xmlString.length-i)
		If xmlString(i) = "<" And xmlString(i+1) = "?" Then
			While xmlString(i) <> ">"
				i += 1
			End While
		ElseIf xmlString(i) = "<" And remaining.indexOf("anyType") = 1 Then
			While xmlString(i) <> ">"
				i += 1
			End While
		ElseIf xmlString(i) = "<" And remaining.indexOf("string ") = 1 Then
			While xmlString(i) <> ">"
				i += 1
			End While
		ElseIf xmlString(i) = "<" And xmlString(i+1) = "/"
			While xmlString(i) <> ">"
				i += 1
			End While
		ElseIf xmlString(i) = "<" And remaining.indexOf("<Products>") = 0 Then
			While xmlString(i) <> ">"
				i += 1
			End While
		ElseIf xmlString(i) = "<" And remaining.indexOf("<Product>") = 0 Then
			While xmlString(i) <> ">"
				i += 1
			End While
		'usuable data
		ElseIf xmlString(i) = "<" Then
			data = data + "<b>"
			While xmlString(i+1) <> ">"
				i += 1
				data = data + xmlString(i)
			End While
			data = data + ": </b>"
			i += 1
			While xmlString(i+1) <> "<"
				i += 1
				data = data + xmlString(i)
			End While
			data = data + "<br>"
		End If
		i += 1
	End While

	Return data
End Function


Sub submitarticlego()
	articleInfo.InnerHtml = "Please Wait... <br>"
	Dim prod as String = artprod.Text

	Dim url as String = "http://ktmslwvd02/TestingProductLookUpWebService/ProductLookUp.asmx/GetProductInformation"
	Dim params as String = "productNoList=" + prod
	Dim xmlString as String = WRequest(url, "POST", params).ToString()
	Dim data As String = parseXml(xmlString)

	If data = "" And xmlString.Substring(0, 18) = "An error occurred:"
		data = xmlString
	ElseIf data = "" Then
		data = "There is no record for this product number."
	End If
	articleInfo.InnerHtml = data
End Sub


</script>

</body>
</html>

