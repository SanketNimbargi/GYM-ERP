<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- Developed by: Pranjali Deshmukh
	 Date: 18/09/2014
	 Purpose:  Total Payment Details By Id
-->
<!--***********Start java Script ********************************-->
<script type="text/javascript">
	$("#document").ready(function() {

		$("#totalpaymentDetailsById").validate({
			debug : true,
			rules : {
				"enteredId" : { required : true},
			},
			messages : {
				"enteredId" : { required : "Enter Id" },
			},
			submitHandler : function(form) {
				form.submit();
			}
		});
	
		// fetch member details
		$("#enteredId").blur(function(){
			onMemberIdChange();							//Fetch Members Details On Change of Member Id
		});
		//Auto Complete for Search By Member Name
		//autoComplete("membersNameAutocomplete","enteredId",onMemberIdChange);
		$("#membersNameAutocomplete").keyup(function(){			
			autoComplete("membersNameAutocomplete","enteredId",onMemberIdChange); 
		});
		//Auto Complete for Search By number
		autoCompleteSearchMember("contactNo","enteredId",onMemberIdChange);
		
	});
		var onMemberIdChange = function(){
			var fetchMemberId = $("#enteredId").val().substring(1);
			var checkMemberString=$("#enteredId").val().substring(0,1);
			clearForm();
			if(fetchMemberId > 0 && checkMemberString == 'M')
			{
				$("#memberId").val(parseInt(fetchMemberId));
				$('<div class="errors" id="message" style="width: 400px; display: none;"></div>)').appendTo($("#errorContainer"));
				$.getJSON('fetchMemberDetailsWithreceipt',{memberId : fetchMemberId}).done(function(data){
					
					if(data.memberList[0] == undefined)
						$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
					else
						assignData(data.memberList[0]);
					    
				})
				.fail(function(jqxhr, textStatus, error) {
					$("#message").text("Error While Fetching. Please Try Again...").show();
				});
			}
			else
				$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
		};
		var assignData = function(data){
			$("#message").hide();
			
			$("#contactNo").val(data.contactNo);
			$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
		};
		
		//Clear Form
		var clearForm = function() {
			$("#message").show();
			$("#contactNo").val("");
			$("#membersNameAutocomplete").val("");
		};
		
	
	
</script>


</head>
<body>
	<s:form id="totalpaymentDetailsById" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Total Payment Details By Member Id</legend>
				<table>
					<tr>
						<td><label>Member Name</label></td>
						<td><label>Member Id<span class="required">*</span></label></td>
						<td><label>Contact No.</label></td>
					</tr>
					<tr>
						<td><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><s:textfield id="enteredId" name="enteredId" value=""  onkeyup="upperCase(this);"></s:textfield></td>
					    <td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<s:submit id="print" value="GetDetails" action="totalprintpaymentDetailsById" align="center"/>
			</fieldset>
		</div>
	</s:form>

</body>
</html>