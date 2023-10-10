<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- Developed by: Pranjali Deshmukh
	 Date: 12/09/2014
	 Purpose: Payment Details By One Date
-->
<!--***********Start java Script ********************************-->
<script type="text/javascript">
	$("#document").ready(function(){
		 
		//Datepicker
		$("#enteredDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'
		});
		$("#paymentDetailsByoneDate").validate({
			debug : true,
			rules : {
				
				"enteredDate":{required:true ,checkDate:true},
			},
			messages : {
				
				"enteredDate":{required:"Enter Date"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		});  
	});
	</script>


</head>
<body>
<s:form id="paymentDetailsByoneDate" name="paymentDetailsByoneDate" theme="css_xhtml">
<div>
<fieldset>
   <legend>Payment Details By Single Date</legend>
   <table>
     <tr>
       <td><label>Enter Date<span class="required">*</span></label></td>
        
     </tr>
     <tr>
       
      <td><s:textfield id="enteredDate" name="enteredDate"></s:textfield></td>
     </tr>
   </table>
   
   <table>
   <tr>
    <td>
    <s:submit id="print" name="print" value="GetDetails" action="printpaymentDetailsByoneDate"></s:submit>
    <td>
   <tr>
    </table>
    
    
</fieldset>
</div>
</s:form>

</body>
</html>