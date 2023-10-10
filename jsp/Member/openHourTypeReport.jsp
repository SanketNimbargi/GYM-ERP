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
		 $("#openHourTypeReport").validate({			
			debug:true,			
			rules:{				
				"hourType":{required:true},				
			},
			messages:{				
				"hourType":{required:"Select Gender Type"},
			},
			submitHandler:function(form){
				
				form.submit();
			}
		});  
		
		
	});
	</script>
	
<s:form id="openHourTypeReport" theme="css_xhtml">
	<div>
		<fieldset>
			<legend>Member Registration Details By Hour Type</legend>
			<table>
				<tr>
					<td><label>Hour Type<span class="required">*</span></label></td>
				</tr>
				<tr>
					<td><s:select name="hourType" id="hourType"
							cssStyle="width:140px;" list="#{'Happy Hour':'Happy Hour','Regular Hour':'Regular Hour'}" headerKey=""
							headerValue="Select HourType"/> </td>
				</tr>
			</table>
			
			<s:submit id="print" value="GetDetails" align="center" action="printMemberDetailsByHourType"/>
		</fieldset>
	</div>
</s:form>