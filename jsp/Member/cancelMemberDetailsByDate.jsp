<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date:11/09/2014
	 Purpose: Member Registration Details By Date
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
		// validation
		$("#cancelmemberRegistrationDetails").validate({
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

<s:form id="cancelmemberRegistrationDetails"  theme="css_xhtml">
	<div>
		<fieldset>
			<legend>Cancel Member Registration Details By Date</legend>
			<table>
				<tr>
					<td><label>From Date</label></td>
					<td><label>To Date</label></td>
				</tr>
				<tr>
					<td><s:textfield id="fromDate" name="fromDate"/></td>
					<td><s:textfield id="toDate" name="toDate"/></td>
				</tr>
			</table>
			<s:submit id="print" value="GetDetails" action="printCancelMemberRegistrationByDate" align="center"/>
		</fieldset>
	</div>
</s:form>
