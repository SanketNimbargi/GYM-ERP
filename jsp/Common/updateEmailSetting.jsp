<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="/struts-jquery-tags" prefix="sj"%>
<script>
	$("#document").ready(function() {				    
		   
		//Validation for form
	$("#updateEmailAndPasswordForm").validate({
					debug:true,
					rules:{	
						emailId:{required:true ,checkMail:true},
						password: { required: true, minlength: 6, maxlength: 12,} , 
						confPassword: {equalTo: "#password",minlength: 6,maxlength: 12 }
					
					},
					messages:{		
						emailId:{required:"Enter Email Id"},
						password: { required:"The password is required"},
						confPassword: { required:"The confirm password is required"}
					},
					submitHandler:function(form){
						form.submit();
					}

		});
		
});
		

</script>
<div style="width: 100%; ">

	<s:form theme="css_xhtml" action="updateEmailAndPasswordAction" id="updateEmailAndPasswordForm"
		name="updateEmailAndPasswordForm">		
		<fieldset>
			<legend>
				<span class="legendtext">Update Email</span>
			</legend>
			<table>
				<tr>
					<td>Enter Email <span class="required">*</span> &nbsp; </td>					
					<td><s:textfield name="emailId" id="emailId" value="" cssStyle="width:200px;"/></td>
					
				</tr>
				<tr>
					<td>Password <span class="required">*</span>&nbsp; </td>					
					<td><s:password name="password" id="password" value="" cssStyle="width:200px;"/></td>
					
				</tr>
				<tr>
					<td>Confirm Password &nbsp; </td>					
					<td><s:password name="confPassword" id="confPassword" value="" cssStyle="width:200px;"/></td>
					
				</tr>
			</table>
		</fieldset>
		<fieldset>
			<table>
				<tr>				
					<td id="submitBtn">
						 <s:submit id="submitButton" value="Update" cssClass="myButton" /> 
					</td>				
				</tr>
			</table>
		</fieldset>

		<s:token />
	</s:form>
</div>


