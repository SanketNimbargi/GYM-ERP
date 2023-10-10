<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 20/09/2014
	 Purpose: Assign ledger Package
-->
<!--*****************start Script *************************  -->
<script type="text/javascript">
	$("#document").ready(function()
   {
		clearForm();
		$("#assignLedgerPackageFees").validate({
			debug:true,
			rules:{
				
				"ledgerName":{required:true },
				
			},
			messages:{
				
				"ledgerName":{required:"Select Ledger" },
				
			},
			submitHandler:function(form){
				form.submit();
			}
		}); 	
		
	});
	

	</script>
<!-- ******************************************************* -->

<!--*************Body start here *************************** -->
<s:form id="assignLedgerPackageFees" theme="css_xhtml">

	<div>
		<fieldset>
			<legend>Upload Ledger Data</legend>
			<%-- <table>
				<tr>
					<td><label>Select Ledger<span class="required">*</span></label></td>
				</tr>
				<tr>
					<td><s:select id="ledgerId" name="ledgerName" value="" cssStyle="width:240px;"
							headerKey="" headerValue="Select Ledger Name" list="ledgerNamesMap" /></td>
				</tr>
			</table>
			<table>
				<tr>
					<td><s:submit id="save" value="Upload Data" action="uploadUsertoEssl" cssClass="smallBtn"/></td>
					<s:token />
				</tr>
			</table> --%>
			<s:if test="ledgerNamesMap.size() > 0">
				<table>
					<s:iterator value="ledgerNamesMap" id="list" status="currentRecord">
						<s:if test="(#currentRecord.index % 3) == 0">
							<s:if test="#currentRecord.index > 0">
								<!-- It's not the first, close previous row -->
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td>
							<div>
								<table class="display" id="ledgerPackageFees">
									<tr>
										<td>
										<s:checkbox  name="checkList" fieldValue="%{#list.ledgerId}"></s:checkbox>
										</td>
										<td width="160px;">
											 <label><s:property value="#list.ledgerName"/> </label> 
											
										</td>
									</tr>
								</table>
							</div>
						</td>
					</s:iterator>
					
					<!-- close last open row -->
				</table>
			</s:if>
			<table>
				<tr>
					<td><s:submit id="save" value="Upload Data" action="uploadUsertoEssl" cssClass="smallBtn"/></td>
					<s:token />
				</tr>
			</table> 
		</fieldset>
	</div>
	<s:token />
</s:form>