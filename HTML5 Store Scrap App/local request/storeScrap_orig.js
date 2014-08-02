/*
 * Created by Rishi Kapadia
 * 6/9/14
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
			if (typeof xmlhttp.overrideMimeType != 'undefined') {
				result.overrideMimeType('text/xml');
			}
			return result;
		}
		catch (error) {}
		try {return new ActiveXObject("Msxml2.XMLHTTP");}
		catch (error) {}
		try {return new ActiveXObject("Microsoft.XMLHTTP");}
		catch (error) {}
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
		//var respdata = XML2json(resp);
		//alert(JSON.stringify(respdata));

		for (var i = 0, len = resp.length; i < len; i++) {
			//weed out unnecesary data
			if (resp[i] == '<' && resp[i+1] == '?') {
				while (resp[i] != '>') i++;
			}
			else if (resp[i] == '<' && (resp.indexOf("anyType", i) == i+1)) {
				while (resp[i] != '>') i++;
			}
			else if (resp[i] == '<' && resp[i+1] == '/') {
				while (resp[i] != '>') i++;
			}
			else if (resp[i] == '<' && (resp.indexOf("<Products>", i) == i)) {
				while (resp[i] != '>') i++;
			}
			else if (resp[i] == '<' && (resp.indexOf("<Product>", i) == i)) {
				while (resp[i] != '>') i++;
			}

			//usuable data
			else if (resp[i] == '<') {
				data += "<b>";
				while (resp[i+1] != '>') {
					i++;
					data += resp[i];
				}
				data+= ": </b>";
				i++;
				while (resp[i+1] != '<') {
					i++;
					data+=resp[i];
				}
				data+="<br>";
			}
		}
		$("#articlebox2").html(data);
	};
	request.open("POST", "http://localhost/TestingProductLookUpWebService/ProductLookUp.asmx/GetProductInformation", true);
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	request.send("productNoList="+String(productNoList));
}


//to be implemented
function cycle() {
	//$("#main").css({"display":"none"});
	//$("#cycle").css({"display":"block"});
}

