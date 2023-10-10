<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- Developed by:Yogesh Gavate
	 Date: 07/10/2014
	 Purpose:  member measurement card report By Id
-->
<!--***********Start java Script ********************************-->
 <script type="text/javascript">
	$("#document").ready(function() {

		$("#memberMeasurementCardById").validate({
			debug : true,
			rules : {
				"enteredId" : { required : true, checkMemberId:true },
			},
			messages : {
				"enteredId" : { required : "Enter Id" },
			},
			submitHandler : function(form) {
				form.submit();
			}
		});

		//Auto Complete for Search By Member Name
		autoComplete("membersNameAutocomplete","enteredId");
	});
</script>

</head>
<body>
	<s:form id="memberMeasurementCardById" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Member Measurement Card By Member Id</legend>
				<table>
					<tr>
						<td><label>Member Name</label></td>
						<td><label>Member Id</label></td>
					</tr>
					<tr>
						<td><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><s:textfield id="enteredId" name="enteredId" value=""  onkeyup="upperCase(this);"></s:textfield></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<s:submit id="print" value="GetDetails" action="printMemberMeasurementCardDetailsById" align="center"/>
			</fieldset>
		</div>
	</s:form>

</body>
</html>