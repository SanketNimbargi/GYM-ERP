<%@ taglib uri="/struts-tags" prefix="s"%>
<%-- action=<s:property value="#session.paymentActionType"/> --%>
<%-- <script type="text/javascript">alert('Form submission Error.Please try again......'+'<s:property value="#session.paymentActionType"/>'); </script>
<s:if test="#session.paymentActionType=='makePayment'">
  <script type="text/javascript">
      window.location='openMakePayment';
  </script>
</s:if>
<s:else>
   <script type="text/javascript">
   window.location='openMakePaymentUpdate'; 
   </script>
</s:else> --%>
<script type="text/javascript">
	//alertMsg('Form submission Error.Please try again......'+sessionStorage.paymentActionType); 
	 var pageToRefresh = "";
	if(sessionStorage.paymentActionType=='makePayment'){
		pageToRefresh ='Reload Make Payment.';
	  }else{
		pageToRefresh ='Reload Update Payment.';
	  }
	alertMsg({  	title: "Token does not match.",	 			   		
   		text: 'Form submission Error.Please try again......'+pageToRefresh,
   		imageUrl:"<%=request.getContextPath()%>/images/alert.png",
   		 imageSize:"40x40", 
   		type: "", 		   		
   		showCancelButton: false,
   		confirmButtonColor: '#DD6B55',
   		''
   		confirmButtonText: 'Refresh',
   		animation: "slide-from-top",
   		//closeOnConfirm: false
   	},
   	function(isConfirm){
   		
   		if (isConfirm){		   			
   			if(sessionStorage.paymentActionType=='makePayment'){
   	    	 window.location='openMakePayment';
	   	    }else{
	   	    	 window.location='openMakePaymentUpdate';
	   	    }
   		} else {
   			//skip 
   		}
   	});
    
</script>
