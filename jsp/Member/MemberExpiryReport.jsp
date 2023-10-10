<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Raju Sable 
	 Date: 22/10/2016
	 Purpose: Member Expiry Report
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
		$("#memberExpiryDetails").validate({
			debug : true,
			rules : {
				"fromDate":{required:true ,checkDate:true},
				"toDate":{required:true ,checkDate:true},
				"status":{required:true},
			},
			messages : {
				"fromDate":{required:"Enter Date From"},
				"toDate":{required:"Enter Date of To"},
				"status":{required:"Select Member Status"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
	});
</script>
<!--************************************************************* -->
<!--************Start Body here********************************** -->
	
	<s:form id="memberExpiryDetails" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Member Expiry Details Report</legend>
				<table>
					<tr>
						<td><label>Select Member Status<span class="required">*</span></label></td>
						<td><label>From Date<span class="required">*</span></label></td>
						<td><label>To Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:select name="status" id="status"
								cssStyle="width:140px;"
								list="#{'registered':'Registered','remove':'Canceled'}" headerKey="" headerValue="Select Member Status"/></td>
						<td><s:textfield id="fromDate" name="fromDate"/></td>
						<td><s:textfield id="toDate" name="toDate"/></td>
					</tr>
				</table>
	
				<s:submit id="print" value="GetDetails" action="printMemberExpiryDetailsByDate" align="center"/>
			</fieldset>
		</div>
	</s:form>