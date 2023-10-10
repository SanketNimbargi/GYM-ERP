<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>


<!--***********Start java Script ********************************-->

<script type="text/javascript">
	$("#document").ready(function(){
		//Validation for form
		$("#birthdayDetailsBetweenDate").validate({
			debug : true,
			rules : {
				"fromDate":{required:true ,checkDate:true},
				"toDate":{required:true ,checkDate:true},
				
			},
			messages : {
				"fromDate":{required:"Enter From Date"},
				"toDate":{required:"Enter To Date"},
				
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
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
	});
	</script>
	
	<s:form id="birthdayDetailsBetweenDate" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Members birthday details Between Date</legend>
				<table>
					<tr>
						<td><label>From Date<span class="required">*</span></label></td>
						<td><label>To Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:textfield id="fromDate" name="fromDate"/></td>
						<td><s:textfield id="toDate" name="toDate"/></td>
					</tr>
				</table>
	
				<s:submit id="print" value="GetDetails" align="center" action="birthdayDetailsBetweenDateReport"/>
			</fieldset>
		</div>
	</s:form>