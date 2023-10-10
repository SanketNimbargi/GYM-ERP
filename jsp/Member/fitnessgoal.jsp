 
    <%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Pranjali Deshmukh
	 Date: 02/12/2014
	 Purpose: fitness goal master
-->

 
 
<script type="text/javascript">
 
		var showData = function($this){
				$("#fitnessid").val($($this).find("td").eq(0).text());
				$("#fitnessname").val($($this).find("td").eq(1).text());
				$("#add").hide();
				$("#update").show("fast");
				$("#delete").show("fast");
			};
			$("#document").ready(function() {
				$('#record').dataTable({});
			 $("#fitnessgoal").validate({
					debug:true,
					rules:{
						"fitnessname":{required:true ,textOnly:true},
						
					},
					messages:{
						"fitnessname":{required:"Enter Fitness Name"},
						
					},
					submitHandler:function(form){
						form.submit();
					}
				});
	});
		//End Of Document ready
		
	</script>

  
<s:form id="fitnessgoal" theme="css_xhtml"> 
	<!-- <div style="width: 80%;"> -->
	<div style="width: 80%;margin-left: 10%;">
			<fieldset>
				<legend>Fitness Goal Master</legend>
				<table>
					<tr>
						<td style="margin-left: 20px;"><label>Fitness Goal Name<span class="required">*</span></label></td>
						 
					</tr>
					<tr>
						<td><s:hidden name="fitnessid" id="fitnessid" />
							<s:textfield name="fitnessname" id="fitnessname" value="" /></td>
						 
						 
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<table>
					<tr>
						<td><s:submit align="center" action="addFitnessDetails"
								id="add" value="Add" cssClass="smallBtn" /></td>
						<td><s:submit align="center" action="updateFitnessDetails"
								id="update" value="Update" style="display:none" cssClass="smallBtn"/></td>
						<td><s:submit align="center" action="deleteFitnessDetails"
								id="delete" value="Delete" style="display:none" cssClass="smallBtn" /></td>
						<s:token />
					</tr>
				</table>
			</fieldset>
		
			<!-- .......Display....... -->
			<fieldset>
				<div id="demo">
					<table class="display" id="record">
						<thead>
							<tr>
								<th>Fitness ID</th>
								<th>Fitness Goal Name</th>
								 
							</tr>
						</thead>
						<tbody>
							<s:iterator value="list">
								<tr onclick="showData(this);">
									<td><s:property value="fitnessid" /></td>
									<td><s:property value="fitnessname" /></td>
									 
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
			</fieldset>
		</div>
	</s:form>
 
</html>