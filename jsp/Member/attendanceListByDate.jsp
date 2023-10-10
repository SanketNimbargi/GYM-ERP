<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Gavate Yogesh 
	 Date: 11/09/2014
	 Purpose: Attendance List By Date
-->

<!--***********Start java Script ********************************-->

<script type="text/javascript">
	 $("#document").ready(function(){
		//Datepicker
		$("#fromDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'
		});
		
		$("#attendanceListByDate").validate({
			debug : true,
			rules : {
				
				"fromDate":{required:true ,checkDate:true},
			},
			messages : {
				"fromDate":{required:"Enter Date"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		});  
	});
</script>
<!--************************************************************* -->
<!--************Start Body here********************************** -->

	<s:form id="attendanceListByDate" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Attendance List By Date</legend>
				<table>
					<tr>
						<td><label>Attendance Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:textfield id="fromDate" name="fromDate"/></td>
					</tr>
				</table>
				<s:submit id="print" value="GetDetails" action="printAttendanceListByDate" align="center"/>
			</fieldset>
		</div>
	</s:form>
