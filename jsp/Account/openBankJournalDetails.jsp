<%@taglib uri="/struts-tags" prefix="s"%>

<script type="text/javascript">
	$("#document").ready(function() {

		$('#record').dataTable({});
		  var actionName = '';
		 $(":submit").click(function() { actionName = this.name });
		//Date Picker
		$('#journalEntrydate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'

		});
		//Date Picker
		$('#date').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'

		});
		//date 
		$.each($('.date'), function() {
			$(this).text(convertToUserDate($(this).text()));
		});
		
		//Validation for form
		$("#journalEntryForm").validate({
			debug : true,
			rules : {
				"journalEntrydate":{required:true ,checkDate:true},
				"amount":{required:true},
				"bankName":{required:true},	
				"accountName":{required:true},				
			},
			messages : {
				"journalEntrydate":{required:"Enter Date"},
				"amount":{required:"Enter First Name"},		
				"bankName":{required:"Enter Bank name"},
				"accountName":{required:"Enter Account Name/Number"},
			},
			submitHandler : function(form) {		
				actionName = actionName.split(':')[1];				
				 if(checkAmount(actionName)){
					form.submit();
				}else{
					//skip;
				} 
			
				
			}
		}); 
		
	});
	var checkAmount=function(actionName){		
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));	
		 if(actionName=="debitAction"){
			 	var amount=parseFloat($("#amount").val());
				var amountATGym=parseFloat($("#amountATGym").val());
				if(amount<=amountATGym){
					//skip;
				}else{
					$("#message").text("You could not debit amount greator than amount at Gym.").show();
					return false;
				}
		 }else{			 
			 var amount=parseFloat($("#amount").val());
				var amountAtBank=parseFloat($("#amountAtBank").val());
				if(amount<=amountAtBank){
					//skip;
				}else{
					$("#message").text("You could not credited amount greator than amount at Bank.").show();
					return false;
				}
		 }
		
		 return true;
	};
		/* <a href="javascript:void(0);"
		NAME="Detail Window" title=" My title here "
		onClick=window.open("window-child.html","Ratting","width=550,height=170,0,status=0,scrollbars=1");>
		Click here to open the child window</a>  
		 */
		 
	
	var openWindow=function(whichDetail,entryDate){		
		var  width=screen.width*2/3;
		var height=screen.height*2/3;
		var left = 50;var top = 50;			 
		var childWidowParamString="width="+width+",height="+height+",0,status=0,scrollbars=1 top="+top+", left="+left;
		entryDate=convertToUserDate(entryDate);		
		if(whichDetail=="debitDetails"){
			//window.open("expenseMaster","Ratting",childWidowParamString);
		}else if(whichDetail=="creditDetails"){			
		}else if(whichDetail=="expenseDetails"){			
		}
	};
	
	//End Of Document ready
</script>

<!-- Body Starts Here -->

<s:form id="journalEntryForm" theme="css_xhtml">
	<!-- 	<div style="width: 80%;"> -->
	<s:if test="hasActionErrors()"> <div class="errors" style="width: 530px;"> <s:actionerror /> </div> </s:if>
			<s:if test="hasActionMessages()"> <div class="welcome" style="width: 430px;"> <s:actionmessage /> </div> </s:if>
	<div style="width: 90%; margin-left: 5%;">
	
	<fieldset>
			<legend>Bank Transfer Details</legend>	
									
				<table>					
					<tr>					
					<td>Total Amount At Gym</td>
					<td>Amount To Debit/Credit<span class="required">*</span></td>
					<td>Bank Name<span class="required">*</span></td>
					<td>Account Name/Number<span class="required">*</span></td>
					<td>Reason Any</td>					
					<td>Date<span class="required">*</span></td>						
					</tr>						
					<tr>			
					<td><s:textfield name="amountATGym" id="amountATGym" value="%{amountATGym}" readonly="true"/></td>				
					<td><s:textfield name="amount" id="amount" value="" /></td>
					<td><s:textfield name="bankName" id ="bankName" value=""/></td>
					<td><s:textfield name="accountName" id="accountName" value=""/></td>
					<td><s:textarea name="reason" id="reason" value=""/></td>
					<td><s:textfield name="journalEntrydate" id="journalEntrydate" value="">
								<s:param name="value"> <s:date name="new java.util.Date()" format="dd/MM/yyyy" /> </s:param>
					</s:textfield></td>
					
					</tr>
					<tr>
					<td colspan="2"></td>
					<td><s:submit name="debitAction" id="debitAction" value="Debit Action" action="debitAction"/></td>
					<td><s:submit name="creditAction" id="creditAction"  value="Credit Action" action="creditAction"/></td>
					<td colspan="2"></td>
					</tr>
					
				
				</table>
	</fieldset>	
		<!-- .......Display....... -->

		<fieldset>
			<legend>Bank Journal Details</legend>
			<div id="demo">
				<table class="display" id="record">
					<thead>
						<tr>
							<th>Sr.No</th>
							<th>Date</th>							
							<th>Debit Amount</th>
							<th>Credit Amount</th>
							<th>Expense Amount</th>							
						</tr>
					</thead>
					<tbody>
						<%
							int i = 1;
						%>
						<s:iterator value="journalEntryList" var="entry">
							<tr>
								<td style="text-align: center;"><%=i%></td>
								<td class="date" style="text-align: center;"><s:property value="entryDate" /></td>								
								<td style="text-align: right;">
								<a href="javascript:void(0);" onClick="openWindow('debitDetails','<s:property value="entryDate" />')";><s:property value="debitAmount" /></a>
								<td  style="text-align: right;">
								<a href="javascript:void(0);" onClick="openWindow('creditDetails','<s:property value="entryDate" />')";><s:property value="creditAmount" /></a>
								</td>	
								<td  style="text-align: right;">
								<a href="javascript:void(0);" onClick="openWindow('expenseDetails','<s:property value="entryDate" />')";><s:property value="expenseAmount" /></a>
								</td>							
								<%i++;%>
							</tr>
						</s:iterator>
					</tbody>
				</table>
			</div>
		</fieldset>
		<fieldset>
			<legend>Bank Journal Summary</legend>										
				<table>					
					<tr>
					<td>Total Amount At Gym<br/>Already + Credited Amount</td><td></td>
					<td>Total Amount At <br/> Bank(Debited)</td><td></td>
					<!-- <td>Total Amount Drawn<br/>From Bank(Credited)</td><td></td> -->
					<td>Total Expense Amount</td><td></td>
					<td>Total Amount</td>
					</tr>					
					<tr>
					<td><s:textfield value="%{amountATGym}" readonly="true"/></td><td>+&nbsp;&nbsp;&nbsp;</td>
					<td><s:textfield value="%{amountAtBank}" id="amountAtBank" name="amountAtBank" readonly="true"/></td><td>+&nbsp;&nbsp;&nbsp;</td>
					<%-- <td><s:textfield value="%{amountCredetedAtBank}" readonly="true"/></td><td>+&nbsp;&nbsp;&nbsp;</td> --%>
					<td><s:textfield value="%{amountConsumed}" readonly="true"/></td><td>=&nbsp;&nbsp;&nbsp;</td>
					<td><s:textfield value="%{total}" readonly="true"/></td>
					</tr>
				
				</table>
	</fieldset>
	</div>
</s:form>