<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- /* Paste this css to your style sheet file or under head tag */ -->
<!-- /* This only works with JavaScript, 
if it's not present, don't show loader */ -->
<style type="text/css">
.no-js #loader { display: none;  }
.js #loader { display: block; position: absolute; left: 100px; top: 0; }
#se-pre-con {
	position: fixed;
	left: 45%;
	top: 30%;
	width: 10%;
	height: 30%;
	z-index: 9999;
	background: url(<%=request.getContextPath() %>/images/wait2.gif) center no-repeat #fff;
} 
</style>

<meta http-equiv="refresh" content="5;url=<s:url includeParams="all" />"/>
<title>Processing</title>
<script type="text/javascript">
//paste this code under head tag or in a seperate js file.
// Wait for window load
$(window).load(function() {
	// Animate loader off screen
	$("#se-pre-con").fadeOut("slow");;
});
	</script>
</head>
<script src="<%=request.getContextPath() %>/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath() %>/js/modernizr.js"></script>
 

<body>
<br>
<!-- <center><h3>Please Wait Result is Processing.............!!!</h3></center> -->
<center><div id="se-pre-con"></div></center>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<!-- <center><h2>Please Don't Refresh The Page........</h2></center> -->
</body>
</html>