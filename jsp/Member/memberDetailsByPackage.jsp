<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 03/09/2014
	 Purpose: Member details by package
-->

	</script>
<html ng-app="plunker">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Member Details By package</title>
<script type="text/javascript">
	$("#document").ready(function() {
		$("#reJoinMember").validate({
			debug : true,
			rules : {
				"status":{required:true},
				"month":{required:true},
							
			},
			messages : {
				"status":{required:"Select Member Status"},
				"month":{required:"Select Package"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
		
	});
</script>
</head>

<s:head />
</head>
<body>

	<s:form id="reJoinMember" theme="css_xhtml" >
		<!-- 	<div style="width: 90%;"> -->
	<div style="width: 90%;margin-left: 5%;">
			<fieldset>
				<legend>Member Details By Package</legend>
				<table>
					<tr>
						
						<td><label>Select Package<span class="required">*</span></label></td>
						<td><label>Select Member Status<span class="required">*</span></label></td>
					</tr>
					<tr>
						 <td><s:select name="month" id="month"
								cssStyle="width:140px;"
								list="#{'1':'1 Month','3':'3 Month','6':'6 Month','12':'12 Month'}" headerKey="" headerValue="Select Package" /></td>
						<td><s:select name="status" id="status"
								cssStyle="width:140px;"
								list="#{'registered':'Registered','remove':'Canceled'}" headerKey="" headerValue="Select Member Status"/></td>
					</tr>
				</table>
				
		
				<table>
					<tr>
						<td><s:submit align="center" action="printMemberDetailsByPackage"
								id="rejoin" value="Get-Details" /></td>
					</tr>
				</table>
			</fieldset>
			<s:token />
		</div>
	</s:form>
</body>
</html>