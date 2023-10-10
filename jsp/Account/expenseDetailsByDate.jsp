<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- Developed by: Pranjali Deshmukh
	 Date: 11/09/2014
	 Purpose: Expenses Details By Date
-->
<!--***********Start java Script ********************************-->
<script type="text/javascript">
	$("#document").ready(function(){
		//Datepicker
		$("#fromDate").datepicker({
			defaultDate: "-1w",
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#toDate" ).datepicker( "option", "minDate", selectedDate );
				 }
		});
		//Datepicker
		$("#toDate").datepicker({
			defaultDate: "+1w",
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#fromDate" ).datepicker( "option", "maxDate", selectedDate );
				 }
		});
		$("#expensesDetailsByDate").validate({
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


</head>
<body>
<s:form id="expensesDetailsByDate" theme="css_xhtml">
<div>
<fieldset>
   <legend>Expenses Details By Date</legend>
   <table>
     <tr>
       <td><label>From Date<span class="required">*</span></label></td>
       <td><label>To Date<span class="required">*</span></label></td>
     </tr>
     <tr>
      <td><s:textfield id="fromDate" name="fromDate" ></s:textfield></td>
      <td><s:textfield id="toDate" name="toDate"></s:textfield></td>
     </tr>
   </table>
   
   <table>
   <tr>
    <td>
    <s:submit id="print" name="print" value="GetDetails" action="printexpenseDetailsByDate" cssClass="smallBtn"></s:submit>
    <td>
   <tr>
    </table>
    
    
</fieldset>
</div>
</s:form>

</body>
</html>