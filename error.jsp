<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Shailesh Halor
	 Date: 19/07/2014
	 Purpose:To Display Exception
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link type="text/css" href="<%=request.getContextPath()%>/css/om_style.css" rel="stylesheet">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.3.min.js"></script>

<script type="text/javascript">

	$(document).ready(function() {
		if($("#exception").val()=="java.lang.reflect.InvocationTargetException")
			 $('#errorMsg').text("InvocationTargetException:  Please Check Xml file for Databse Connection or Mapping in Hibernate.cfg.");
		else if($("#exception").val()=="org.hibernate.SessionException: Session is closed!")
			$('#errorMsg').text("SessionException:  Session Is closed. Use open session insted of get session.");
		else if($("#exception").val()=="org.hibernate.TransactionException: Transaction not successfully started")
			$('#errorMsg').text("TransactionException:  Please Check query.");
		else if($("#exception").val()=="org.hibernate.TransactionException: nested transactions not supported")
			$('#errorMsg').text("TransactionException:  Use open session insted of get session. and close session before return.");
		else if($("#exception").val()=="org.hibernate.exception.JDBCConnectionException")
			$('#errorMsg').text("Initial Sqlserver Session Factory Creation Failed. org.hibernate.exception.JDBCConnectionException: Error calling Driver#connect.");

		else 
			$('#errorMsg').text("");
	}); 
</script>

<s:head />
</head>
<body>
	<div class="exception">
		<s:hidden id="exception" value="%{exception}" />
		<label id="errorMsg"></label>
	</div>
	<h4>
		Exception Name:<br> <s:property value="exception" />
		<li>Please update Tax Amount.</li>
		<li>Please update Registration Fees</li>
		<li>Please assign Ledger Name</li>
		<li>Please assign Ledger Month</li>
		<li>Please assign Ledger Fees</li>
	</h4>

</body>
</html>