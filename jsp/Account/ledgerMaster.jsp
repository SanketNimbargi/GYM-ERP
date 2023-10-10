<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Yogesh Gavate
	 Date: 15/09/2014
	 Purpose: ledger master
-->
<!--*****************start Script *************************  -->
<script type="text/javascript">
	$("#document").ready(function()
   {
		 
		$("#ledger").validate({
			debug:true,
			
													
			rules:{
				"ledgerName":{required:true/* ,textOnly:true */},
				"ledgerType":{required:true},
			},
			messages:{
				"ledgerName":{required:"Enter Ledger Name"},
				"ledgerType":{required:"Select Ledger Type"}
			},
			submitHandler:function(form){
				form.submit();
			}
		}); 
		
	});
	var showData = function($this){
		$("#ledgerId").val($($this).find("td").eq(0).text());
		$("#ledgerName").val($($this).find("td").eq(1).text());
		$("#ledgerType").val($($this).find("td").eq(2).text());
		var setValue=($($this).find("td").eq(3).find("input:checkbox").prop("checked"));
		if(setValue==true){
			$("#activeStatus").val(1);
		} else{
			$("#activeStatus").val(0);
		}
		$("#update").show("fast");
		$("#delete").show("fast");
		$("#save").hide();
		$("#month").attr("disabled", true);
	};
	</script>
<!-- ******************************************************* -->

<!--*************Body start here *************************** -->
<s:form id="ledger" theme="css_xhtml">

	<div style="width: 80%;margin-left: 10%;">
	<!-- <div> -->
		<fieldset>
			<legend>Ledger master</legend>
			<table>
				<tr>
					<td><label>Ledger Type<span class="required">*</span></label>
					<td><label>Ledger<span class="required">*</span></label></td>
				</tr>
				<tr>
					<td>
						<s:hidden id="ledgerId" name="ledgerId" value=""/>
						<s:hidden id="activeStatus" name="activeStatus" value=""/>
						<s:select list="#{'Ledger Package':'Ledger Package','Trainer Package':'Trainer Package' }" id="ledgerType" 
						name="ledgerType" value="" headerKey="" headerValue="Select Type"  cssStyle="width:150px;"/></td>
						<td><s:textfield id="ledgerName" name="ledgerName" value="" onkeyup="firstUpper(this);" /></td>
				</tr>
			</table>
			<table>
				<tr>
					<td><s:submit id="save" value="Save" action="saveLedgerMaster" /></td>
					<td><s:submit id="update" value="Update" action="updateLedgerMaster" style="display:none" /></td>
					<%-- <td><s:submit id="delete" value="Delete" action="deleteLedgerMaster" style="display:none" /></td> --%>
				</tr>
			</table>
		</fieldset>
	
	<fieldset>
		<div id="demo">
			<table id="ledgerTable" class="display">
				<thead>
					<tr>
						<th>Sr. No.</th>
						<th>Ledger</th>
						<th>Ledger Type</th>
						<th>Enable/Disable</th>
					</tr>
				<tbody>
					<s:iterator value="ledgerModelsList">
						<tr onclick="showData(this);">
							<td><s:property value="ledgerId" /></td>
							<td><s:property value="ledgerName" /></td>
							<td><s:property value="ledgerType"/></td>
							<td>
								<s:if test = "%{activeStatus==1}">
								    <s:checkbox name = "" class="disActiveStatus" fieldValue="true" value="true"/>
								 
								</s:if>
								<s:else>
								    <s:checkbox name = ""  class="disActiveStatus" fieldValue="true" value="false" />
								</s:else>
										 
							</td>
						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</fieldset>
	<s:token />
	</div>
</s:form>


<!-- ******************************************************* -->
