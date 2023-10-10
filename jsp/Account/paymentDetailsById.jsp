<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- Developed by: Pranjali Deshmukh
	 Date: 12/09/2014
	 Purpose: Payment Details By Id
-->
<!--***********Start java Script ********************************-->
<script type="text/javascript">
	$("#document").ready(function(){
		 
		
		$("#paymentDetailsById").validate({
			debug : true,
			rules : {
				
				"enteredId":{required:true},
			},
			messages : {
				
				"enteredId":{required:"Enter Id"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		});  
	});
	</script>


</head>
<body>
<s:form id="paymentDetailsById" name="paymentDetailsById" theme="css_xhtml">
<div>
<fieldset>
   <legend>Payment Details By Member Id</legend>
   <table>
     <tr>
       <td><label>Member Id</label></td>
        
     </tr>
     <tr>
       
      <td><s:textfield id="enteredId" name="enteredId"></s:textfield></td>
     </tr>
   </table>
   
   <table>
   <tr>
    <td>
    <s:submit id="print" name="print" value="GetDetails" action="printpaymentDetailsById"></s:submit>
    <td>
   <tr>
    </table>
    
    
</fieldset>
</div>
</s:form>

</body>
</html>