<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Yogesh Gavate
	 Date: 17/09/2014
	 Purpose: ledger master
-->
<!--*****************start Script *************************  -->
<script type="text/javascript">

	$("#document").ready(function()
   {
		$("#packageMonthTable").DataTable({});
		$("#packageMonthTable tr").click(function()
		{
			$("#packageMonthId").val($(this).find("td").eq(0).text());
			$("#packageMonth").val($(this).find("td").eq(1).text());
			$("#update").show("fast");
			$("#save").hide();
		
		}); 
	
		$("#packageMonthForm").validate({
			debug:true,
			rules:{
				"packageMonth":{required:true ,number:true,maxlength : 2, minlength : 1},
				
			},
			messages:{
				"packageMonth":{required:"Enter Month"},
			},
			submitHandler:function(form){
				form.submit();
			} 
		}); 
		
	
	});
	var showData = function($this){
		
		$("#packageMonthId").val($($this).find("td").eq(0).text());
		$("#packageMonth").val($($this).find("td").eq(1).text());
		$("#update").show("fast");
		$("#save").hide();
		
	};
	</script>
<!-- ******************************************************* -->
<!--*************Body start here *************************** -->
 <s:form id="packageMonthForm" theme="css_xhtml" name="ledger">
 
		<div style="width: 80%;margin-left: 10%;">
	<!-- <div> -->
			<fieldset>
				<legend>Package month</legend>
				<table>
					<tr>
						<td><label>Month<span class="required">*</span></label></td>
					</tr>
					<tr>  
						<td><s:textfield id="packageMonth" name="packageMonth" value=""/></td>
						<td><s:textfield id="packageMonthId" name="packageMonthId" style="display:none" /></td>
						
					</tr>
				</table>
				<table>
				<tr>
				<td><s:submit id="save" value="Save" action="savePackageMonthAction" cssClass="smallBtn"/></td>
				<td><s:submit id="update" value="Update" action="updatePackageMonthAction" style="display:none" cssClass="smallBtn"/></td>
				</tr>
				<s:token />
				</table>
			</fieldset>
		
		<fieldset>
		<div id="demo">
			<table id="packageMonthTable" class="display">
				<thead>
					<tr>

						<th>Id</th>
						<th>Month</th>
					</tr>
				<tbody>
					<s:iterator value="packageMonthList">
						<tr onclick="showData(this);">
							<td><s:property value="packageMonthId"/></td>
							<td><s:property value="packageMonth"/></td>

						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</fieldset>
	</div>
	</s:form>

<!-- ************************************************************************************ -->
