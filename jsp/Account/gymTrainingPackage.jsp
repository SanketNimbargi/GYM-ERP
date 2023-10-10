<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
$(document).ready(function()
{
	$("#gymPackageDetail").DataTable({});
	$("#gymPackageDetail tr").click(function(){
		$("#month").val($(this).find("td").eq(0).text());
		$("#packageFees").val($(this).find("td").eq(1).text());
		$("#update").show("fast");
		$("#save").hide();
		$("#month").attr("disabled", true);
	});
	
	
	//validation
	$("#gymTrainingPackage").validate({
		debug:true,
		rules:{
			"packageFees":{required:true ,number:true},
			
		},
		messages:{
			"packageFees":{required:"Enter Fees"},
		},
		submitHandler:function(form){
			form.submit();
		}
	}); 
		
		
	});
	

</script>


<s:form action="gymTrainingPackage" name="gymTrainingPackage"
	id="gymTrainingPackage" theme="css_xhtml">
	<fieldset>
		<legend>Gym Package Information</legend>

		<hr style="width: 60%; margin: 0 auto;">
		<table style="margin: 10px auto 0;">

			<tr>
				<td><label>No Of Month</label></td>
				<td><label>Fees</label></td>


			</tr>
			<tr>
				<td><s:select name="month" id="month" cssStyle="width:140px;"
						list="#{'1':'1','3':'3','6':'6','12':'12'}" /></td>
				<td><s:textfield name="packageFees" id="packageFees" value=""
						placeholder="fees" /></td>

			</tr>
		</table>
	</fieldset>
	<fieldset>
		<table style="margin: 0 auto;">
			<tr>
				<td><s:submit action="saveTrainingPackage" id="save"
						value="save" cssClass="myButton" /></td>
				<td><s:submit value="update" id="update"
						action="updateGymPackage" cssClass="myButton" style="display:none" /></td>
				<s:token />
			</tr>
		</table>
	</fieldset>

	<fieldset>
		<div id="demo">
			<table id="gymPackageDetail" class="display">
				<thead>
					<tr>

						<th>No.Of Month</th>
						<th>Fees</th>
					</tr>
				<tbody>
					<s:iterator value="list">
						<tr>
							<td><s:property value="month" /></td>
							<td><s:property value="packageFees" /></td>

						</tr>
					</s:iterator>
				</tbody>
			</table>
		</div>
	</fieldset>


</s:form>