/*
 * Created by Rishi Kapadia
 * 6/9/14
 *
 * Accessible via:
 * http://ktmslwvd01.ad.99only.com/StoreScrapApp1/storeScrap.html
 *
 * Cites:
 * http://rest.elkstein.org/2008/02/using-rest-in-javascript.html
 * https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
 * http://www.w3schools.com/ajax/ajax_xmlfile.asp
 * http://eloquentjavascript.net/chapter14.html
 * http://stackoverflow.com/questions/4007969/application-x-www-form-urlencoded-or-multipart-form-data
 * 
 */

function article() {
	clearinputs();
	$("#main").css({"display":"none"});
	$("#article").css({"display":"block"});
}

function clearinputs() {
	var formInputs = document.getElementsByTagName('input');
    	for (var i = 0; i < formInputs.length; i++) {
        	var theInput = formInputs[i];
                if (theInput.type == 'text') {
                	theInput.value = "";
		}
	}
	$("#articlebox2").html("Information: <br>");
}

function articleback() {
	clearinputs();
	$("#article").css({"display":"none"});
	$("#main").css({"display":"block"});
}

function articlego() {
	var productNoList = $("#art-prod").val();
	$("#articlebox2").html("Please wait... <br>")
	if (isNaN(productNoList)) {
		clearinputs();
		alert("Must be numeric!");
		return;
	}
	function makeHttpObject() {
		try {
			var result = new XMLHttpRequest();
			return result;
		}
		catch (error) {}
		try {return new ActiveXObject("Msxml2.XMLHTTP");}
		catch (error) {}
		try {return new ActiveXObject("Microsoft.XMLHTTP");}
		catch (error) {
			alert("Please use a different browser.");
		}
		throw new Error("Could not create HTTP request object.");
	}
	
	var request = makeHttpObject();

	request.onreadystatechange = function() {
		if (request.readyState != 4) {
			return;
		}
		if (request.status != 200) {
			alert("Failed to fetch data! Error Status: "+request.status);
			return;
		}
		//successful fetch
		var resp = String(request.responseText);
		var data = "";

		resp = resp.replace(new RegExp('&gt;', 'g'), '>');
		resp = resp.replace(new RegExp('&lt;', 'g'), '<');

		var xml = resp,
		    xmlDoc = $.parseXML( xml),
		    $xml = $( xmlDoc );
		var fields = ["ProductID",
		    "SubClassID",
		    "ClassID",
		    "CategoryID",
		    "DepartmentID",
		    "Buyer",
		    "LongDescription",
		    "SellUnit",
		    "SellQty"];
		for (var i=0; i < fields.length; i++) {
			data += "<b>"+fields[i]+":</b> ";
			$field = $xml.find( fields[i] );
			data += $field.text();
			data += "<br>"
		}

		$("#articlebox2").html(data);
	};
	request.open("POST", "http://ktmslwvd02/TestingProductLookUpWebService/ProductLookUp.asmx/GetProductInformation", true);
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

	request.setRequestHeader("Access-Control-Allow-Origin", "*");
	request.setRequestHeader("Access-Control-Allow-Methods", "POST");

	request.send("productNoList="+String(productNoList));
}


//to be implemented
function cycle() {
	//$("#main").css({"display":"none"});
	//$("#cycle").css({"display":"block"});
}

