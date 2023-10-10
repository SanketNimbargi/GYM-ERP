<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="/struts-jquery-tags" prefix="sj"%>
<script>
	$("#document").ready(function() {
		//Datepicker
		$('#billInstallationDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '2010:2050',
			 
		}); 
		$("#totalPaidAmount").blur(function(){
			var totalPaidAmount = $("#totalPaidAmount").val();				
			var pendingAmount = $("#pendingAmount").val();	
			if(compare(pendingAmount,totalPaidAmount)){	
				$("#totalPaidAmount").val("");
				$("#submitLabel").hide();
				$("#submitBtn").show();
				$('<div class="errors" id="message" style="width: 400px; display: none;"></div>)').appendTo($("#errorContainer"));
				$("#message").text("Paid amount must be less than or equal to Pending amount... ").show();
				
			}else if(!isNaN(parseInt(totalPaidAmount))){				
				$("#totalPendingAmount").val(pendingAmount-totalPaidAmount);
				$("#submitLabel").show();
				$("#submitBtn").hide();				
			}else{
				$("#submitLabel").hide();
				$("#submitBtn").show();
			}
		});
		
	//	$("#submit").click(function(){ document.forms["makeSellersPaymentForm"].submit(); CloseThis();});
		$("#cancelButton").click(function(){ CloseThis();});
		
		/* 
	$("#submitAmount").click(function() {
			
			var billId = $("#billId").val();
			var totalPaidAmount = $("#totalPaidAmount").val();		
			var pendingAmount = $("#pendingAmount").val();	
			var totalPaidAmount = $("#totalPendingAmount").val();
			
			if(isNaN(parseInt(totalPaidAmount))){	
				$("#message").text("Enter Amount").show();
			}else if(compare(pendingAmount,totalPaidAmount)){			
				$("#message").text("Paid amount must be less than or equal to Pending amount... ").show();
			}else{
			
			 $.getJSON('makeAndPrintBillDetails', {
				billId : billId,
				totalPaidAmount : totalPaidAmount
			}, function(data) {
				if(data.billPaymentReceiptList[0] == undefined){
					$("#message").text("Error while Making Payment. Please try again...").show();					 
				}else{
					$("#message").text("Payment Made Successfully").show();
					CloseThis();
				}
			})
			 .fail(function(){
					$("#message").text("Error while fetching info. Plaese try again...").show();
			});  
		}
					
	
	}); */
		//Validation for form
	$("#updateTaxForm").validate({
					debug:true,
					rules:{						
						"taxAmount":{required:true,valueOnly:true}						
					},
					messages:{				
						"taxAmount":{required:"Enter amount."}
					},
					submitHandler:function(form){
						form.submit();
					}

		});
		
});
		
	
function compare(number1, number2) {
			
				    var precision1, precision2, decimal1, decimal2, flag = false;
			     
				    precision1 = parseInt(number1.substr(0, String(number1).indexOf('.')));
				    decimal1 = parseInt(number1.substr(String(number1).indexOf('.') +1));		    
				     
				    
				    precision2 = parseInt(number2.substr(0, String(number2).indexOf('.')));
				    decimal2 = parseInt(number2.substr(String(number2).indexOf('.') +1));
				    if(isNaN(precision2)){
				    	precision2 = parseInt(number2);
					    decimal2 = parseInt(0);
				    }				    
				    if(precision1 < precision2) flag = true;
				    else if(precision1 == precision2 && decimal1 < decimal2) flag = true;
				     
				   /*  if(flag)
				        alert(number2 + " greater than " + number1);
				    else
				        alert(number1 + " greater than " + number2); */
				     
				    return flag;
	};
	function CloseThis() {
		self.close();	
	};
</script>
<div style="width: 100%; ">

	<s:form theme="css_xhtml" action="saveUpdateTax" id="updateTaxForm"
		name="updateTaxForm">		
		<fieldset>
			<legend>
				<span class="legendtext">Update Tax</span>
			</legend>
			<table>
				<tr>
					<td>Enter Tax Amount<span class="required">*</span> &nbsp; </td>					
					<td><s:textfield name="taxAmount" id="taxAmount" value="" /></td>
					
				</tr>
			</table>
		</fieldset>
		<fieldset>
			<table>
				<tr>				
					<td id="submitBtn">
						 <s:submit id="submitButton" value="Update Tax" cssClass="myButton"/> 
					</td>				
				</tr>
			</table>
		</fieldset>

		<s:token />
	</s:form>
</div>


