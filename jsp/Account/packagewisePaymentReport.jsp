<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Raju Sable
	 Date:22/10/2016
	 Purpose: Packagewise Payment Details Report By Date
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
		$("#packagewisePaymentDetailsReport").validate({
			debug : true,
			rules : {
				"ledger":{required:true},
				"fromDate":{required:true ,checkDate:true},
				"toDate":{required:true ,checkDate:true},
			},
			messages : {
				"ledger":{required:"Select Ledger"},
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

<s:form id="packagewisePaymentDetailsReport"  theme="css_xhtml">
	<div>
		<fieldset>
			<legend>Packagewise Payment Details By Date</legend>
			<table>
				<tr>
					<td><label>Select Ledger<span class="required">*</span></label></td>
					<td><label>From Date</label></td>
					<td><label>To Date</label></td>
				</tr>
				<tr>
							<td><s:select name="ledger" id="ledger"
								cssStyle="width:140px;"
								list="ledgerList" headerKey="" headerValue="Select Ledger" /></td>
		
					<td><s:textfield id="fromDate" name="fromDate"/></td>
					<td><s:textfield id="toDate" name="toDate"/></td>
				</tr>
			</table>
			<s:submit id="print" value="GetDetails" action="printPackagewisePaymentReport" align="center"/>
		</fieldset>
	</div>
</s:form>
