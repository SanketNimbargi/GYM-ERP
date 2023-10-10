<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Gavate Yogesh 
	 Date: 11/09/2014
	 Purpose: Member Registration Details By Gender
-->
<!--************Start Body here********************************** -->

<script type="text/javascript">
	$("#document").ready(function() {
		//Validation for form
		 $("#memberRegistrationDetailsByGenders").validate({			
			debug:true,			
			rules:{				
				"gender":{required:true},				
			},
			messages:{				
				"gender":{required:"Select Gender Type"},
			},
			submitHandler:function(form){
				
				form.submit();
			}
		});  
		
		
	});
	</script>
	
<s:form id="memberRegistrationDetailsByGenders" theme="css_xhtml">
	<div>
		<fieldset>
			<legend>Member Registration Details By Gender</legend>
			<table>
				<tr>
					<td><label>Gender<span class="required">*</span></label></td>
				</tr>
				<tr>
					<td><s:select name="gender" id="gender"
							cssStyle="width:140px;" list="#{'Male':'Male','Female':'Female'}" headerKey=""
							headerValue="Select Gender Type"/> </td>
				</tr>
			</table>
			
			<s:submit id="print" value="GetDetails" align="center" action="printMemberRegistrationDetailsByGenders"/>
		</fieldset>
	</div>
</s:form>