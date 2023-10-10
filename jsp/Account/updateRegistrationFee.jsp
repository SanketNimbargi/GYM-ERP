<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="/struts-jquery-tags" prefix="sj"%>
<div style="width: 100%; ">
<script>
	$("#document").ready(function() {
		
		$("#RegistrationFeeForm").validate({
			debug:true,
			rules:{						
				"RegistrationFee":{required:true,valueOnly:true}						
			},
			messages:{				
				"RegistrationFee":{required:"Enter Registration Fee."}
			},
			submitHandler:function(form){
				form.submit();
			}

		});
	});
</script>
	<s:form theme="css_xhtml" action="saveRegistrationFee" id="RegistrationFeeForm"
		name="RegistrationFeeForm">		
		<fieldset>
			<legend>
				<span class="legendtext">Update Registration Fee</span>
			</legend>
			<table>
				<tr>
					<td>Enter Registration Fee<span class="required">*</span> &nbsp; </td>					
					<td><s:textfield name="RegistrationFee" id="RegistrationFee" value="" /></td>
					
				</tr>
			</table>
		</fieldset>
		<fieldset>
			<table>
				<tr>				
					<td id="submitBtn">
						 <s:submit id="submitButton" value="Update Registration Fee" cssClass="myButton"/> 
					</td>				
				</tr>
			</table>
		</fieldset>

	
	</s:form>
</div>
</body>
</html>