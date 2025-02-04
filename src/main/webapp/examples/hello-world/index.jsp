<%@ page import="canvas.SignedRequest" %>
<%@ page import="java.util.Map" %>
<%
    // Pull the signed request out of the request body and verify/decode it.
   Map<String, String[]> parameters = request.getParameterMap();
   String[] signedRequest = parameters.get("signed_request");
   if (signedRequest == null) {%>This App must be invoked via a signed request!<%
        return;
    }
	String yourConsumerSecret="B629EE7D33D6F4F852021605C60F6BD0B787453721ABD979CD3C922653F49855";
    String signedRequestJson = SignedRequest.verifyAndDecodeAsJson(signedRequest[0], yourConsumerSecret);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>

    <title>Hello World Canvas Example</title>

    <link rel="stylesheet" type="text/css" href="/sdk/css/canvas.css" />

    <!-- Include all the canvas JS dependencies in one file -->
    <script type="text/javascript" src="/sdk/js/canvas-all.js"></script>
    <!-- Third part libraries, substitute with your own -->
    <script type="text/javascript" src="/scripts/json2.js"></script>

  
</head>
  
<body>
    <br/>
	
    <h1>Hello   <span id='username'></span></h1>
	<h1>Hello 1  <span id='username1'></span></h1>
	
	<script>
        if (self === top) {
            // Not in Iframe
            alert("This canvas app must be included within an iframe");
        }
		else{
			var sr1 = '<%=signedRequestJson%>';
			console.log(sr1);
		}
        Sfdc.canvas(function() {
		 var sr = JSON.parse('<%=signedRequestJson%>');
              var sr1 = '<%=signedRequestJson%>';
            // Save the token
         Sfdc.canvas.oauth.token(sr.oauthToken);
         Sfdc.canvas.byId('username').innerHTML = sr.context.user.fullName;
				
	    });
    </script>
</body>
</html>
