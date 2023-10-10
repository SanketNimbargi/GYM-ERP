<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Gavate Yogesh 
	 Date: 10/09/2014
	 Purpose: Attendance List Between Date
-->
<!--***********Start java Script ********************************-->
<script type="text/javascript">
	 $("#document").ready(function(){
		//Datepicker
		$("#fromDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#toDate" ).datepicker( "option", "minDate", selectedDate );
				 }
		});
		//Datepicker
		$("#toDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#fromDate" ).datepicker( "option", "maxDate", selectedDate );
				 }
		});
		$("#attendanceListBetweenDate").validate({
			debug : true,
			rules : {
				
				"fromDate":{required:true ,checkDate:true},
				"toDate":{required:true ,checkDate:true},
			},
			messages : {
				
				"fromDate":{required:"Enter Date From"},
				"toDate":{required:"Enter Date of To"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		});  
	});
 
		

</script>
<!--************************************************************* -->
<!--************Start Body here********************************** -->

	<s:form id="attendanceListBetweenDate" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Attendance List Between Date</legend>
				<table>
					<tr>
						<td><label>From Date<span class="required">*</span></label></td>
						<td><label>To Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:textfield id="fromDate" name="fromDate" value=""/></td>
						<td><s:textfield id="toDate" name="toDate" value=""/></td>
					</tr>
				</table>
				
				<s:submit id="print" value="Print Details" action="printAttendanceListBetweenDate" align="center"/>
			</fieldset>
		</div>
	</s:form>