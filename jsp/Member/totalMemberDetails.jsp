<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 03/09/2014
	 Purpose: Member details by package
-->

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
				
							
			},
			messages : {
				"status":{required:"Select Member Status"},
				
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
			<fieldset >
				<legend>Member Details</legend>
				<table>
					<tr>
						
						<td><label>Select Member Status<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:select name="status" id="status"
								cssStyle="width:160px;"
								list="#{'all':'All Members','registered':'Registered Members','remove':'Cancelled Members'}" headerKey="" headerValue="Select Member Status"/></td>
					</tr>
				</table>
				
		
				<table>
					<tr>
						<td><s:submit align="center" action="printTotalMemberDetails"
								id="rejoin" value="Get-Details" /></td>
					</tr>
				</table>
			</fieldset>
			<s:token />
		</div>
	</s:form>
</body>
</html>