<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<html  ng-app="plunker">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<!--  ...................add favicon................. -->
  <link rel="icon" href="<%=application.getAttribute("favicon")%>" type="image/x-icon">  
<!-- ...............................CSS Files.......................................... -->
<link type="text/css" href="<%=request.getContextPath()%>/css/bootstrap-cerulean.css" rel="stylesheet">	<!-- Bootstrap Css for design -->
<%-- <link type="text/css" href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">	 --%>			<!-- Css for Menu  -->
<link type="text/css" href="<%=request.getContextPath()%>/css/demo_table.css" rel="stylesheet">			<!-- Data table  -->
<link type="text/css" href="<%=request.getContextPath()%>/css/om_style.css" rel="stylesheet">			<!-- User Defined Css -->
<link type="text/css" href="<%=request.getContextPath()%>/css/notification.css" rel="stylesheet">			<!-- User Defined Css -->
<link type="text/css" href="<%=request.getContextPath()%>/css/jquery-ui.css" rel="stylesheet">			<!-- Css for Jquery UI design -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-theme.min.css"><%-- <link type="text/css" href="<%=request.getContextPath()%>/css/myMenustyle.css" rel="stylesheet"> --%>
<link href="<%=request.getContextPath()%>/css/tabmenu.css" rel="stylesheet" type="text/css" />
<!-- ...............................JS Files.......................................... -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>			<!-- Jquery Min  -->
<script src="<%=request.getContextPath()%>/js/jquery1.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap1.min.js"></script>
<!-- ...............................Alert js and CSS Files........... -->
<script src="<%=request.getContextPath()%>/userAlert/sweet-alert.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/userAlert/sweet-alert.css" >
 


<script type="text/javascript">
var clickno=0;
	$("#document").ready(function(){	
		if(typeof(Storage) !== "undefined") {
		    // Code for localStorage/sessionStorage.
			   //alertMsg("Browser supported storage.");
		} else {
		    // Sorry! No Web Storage support..
		    alertMsg("Browser not supported.Please update your browser.");
		}
		var width = screen.availWidth;	
		document.getElementById("mainContainer").style.width=width+"px";	
		document.getElementById("mainContainer").style.margin="0 auto";	
		 $("#bodyContainer, #sideMenu").click(function(){
			//alert(clickno);
			if(clickno>0){
			  	$("#errorContainer").empty();
				clickno=0;
			}
			else{
				clickno++;
			}
		}); 
		 
		
		 
		$('input:text').bind("keydown", function(e) {
		    var n = $("input:text").length;
		    if (e.which == 13) 
		    { //Enter key
		      e.preventDefault(); //Skip default behavior of the enter key
		      var nextIndex = $('input:text').index(this) + 1;
		      if(nextIndex < n)
		        $('input:text')[nextIndex].focus();
		      else
		      {
		        $('input:text')[nextIndex-1].blur();
		        $('input:submit').click();
		      }
		    }
		  });
	});
</script>

</head>
<body id="mainContainer">
<div style="height:100%;">
	<div class="header">
		<tiles:insertAttribute name="header" />
	</div>

	<div class="menu" style="clear:both;">
		<tiles:insertAttribute name="menu" />
	</div>

	<div class="sideMenu" id="sideMenu">
		<tiles:insertAttribute name="sideMenu"/>
	</div>
	<div class="container" style="width: 80%;  margin-top: 5px; margin-left: 190px;clear:both;font-size: 12px;" id="container">		
			<div id="errorContainer">
			<s:if test="hasActionErrors()"> <div class="errors" style="width: 530px;"> <s:actionerror /> </div> </s:if>
			<s:if test="hasActionMessages()"> <div class="welcome" style="width: 430px;"> <s:actionmessage /> </div> </s:if>
			<div class="errors" id="message" style="width: 430px; display: none;"></div>
		</div>
		<div id="bodyContainer" >
			<tiles:insertAttribute name="body" />
		</div>
	</div>	
</div>
<div class="footer">
		<tiles:insertAttribute name="footer" />
	</div>
	

<!-- ...............................JS Files.......................................... -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-ui.js"></script>			<!-- Jquery UI Plugin  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>	<!-- Validate Page  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/checkAvailable.js"></script>		<!-- Check Available  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.dataTables.js"></script>	<!-- Data table for searching  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>	<!-- Validate Page  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.datepick.js"></script>		<!-- Date picker  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/textUtil.js"></script>				<!-- Text Utility eg. UpperCase -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/validateMethods.js"></script>		<!-- Added validation Methods  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/autoCompleter.js"></script>		<!-- Auto Completer Methods  -->
<script data-require="angular.js@1.0.x" src="<%=request.getContextPath() %>/js/angular.min.js" data-semver="1.0.8"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/date.js" ></script>
<script src="<%=request.getContextPath() %>/js/tabmenu.js" type="text/javascript"></script>
<script> var app = angular.module('plunker', []); </script>
<script src="<%=request.getContextPath() %>/js/upload.js"></script>
<script src="<%=request.getContextPath() %>/js/app.js"></script>
<script src="<%=request.getContextPath() %>/js/jquery.confirm.js"></script>
<script src="<%=request.getContextPath() %>/js/bootstrap.min.js"></script>
 <%-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/load-image-exif.js"></script> --%>
<script type="text/javascript">
var msg = "<%= (String)session.getAttribute("message") %>";
if(msg!=null && msg != "" && msg != "null"){
	// imageUrl: "/images/student_details.jpg", 
	showMessage({
		title: "",	
		text: msg
		
	});
	//showMessage(msg);
}
<% session.setAttribute("message", ""); %>

</script>
</body>
 


</html>

