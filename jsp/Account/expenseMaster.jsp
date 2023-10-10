<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Pranjali Deshmukh
	 Date: 09/09/2014
	 Purpose: expenses master
-->

<!-- Scripting Starts Here -->

<script type="text/javascript">
	$("#document").ready(function() {
		
		$('#record').dataTable({});
		  var actionName = '';
			 $(":submit").click(function() { actionName = this.name });

 		//On click on Table
		 /* 	$("#record tr").click(function() {
			$("#expenseid").val($(this).find("td").eq(0).text());
			$("#expensename").val($(this).find("td").eq(1).text());
			$("#amount").val($(this).find("td").eq(2).text());
			$("#date").val($(this).find("td").eq(3).text());
			$("#add").hide();
			$("#update").show("fast");
			$("#delete").show("fast");
		});  */  
		
		//Date Picker
		$('#date').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'
			
				
		});
		//date 
		 $.each($('.date'), function() {
			 $(this).text(convertToUserDate( $(this).text()));
	    });
		
		//Validation for form
		 $("#expense").validate({
			debug:true,
			rules:{
				"date":{required:true ,checkDate:true},
				"expensename":{required:true ,textOnly:true},
				"amount":{required:true ,number:true},
				
				
			},
			messages:{
				"date":{required:"Enter Date"},
				"expensename":{required:"Enter Expense Name"},
				"amount":{required:"Enter Amount"},
				
			},
			submitHandler:function(form){
				actionName = actionName.split(':')[1];				
				 if(checkExpenseAmount(actionName)){
					form.submit();
				}else{
					//skip;
				} 
			}
		}); 
	});
	var checkExpenseAmount=function(actionName){		
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));	
		 if(actionName!="deleteExpenseDetails"){
			 	var amount=parseFloat($("#amount").val());
				var amountATGym=parseFloat($("#amountATGym").val());
				//alert((parseFloat(amount) < parseFloat(amountATGym))+" and "+(amount<=amountATGym));
				if(amount<=amountATGym){
					//skip;
				}else{
					$("#message").text("You could not consume amount more than amount at Gym.").show();
					return false;
				}
		 }
		 return true;
	};
	var showData = function($this){
		
		$("#expenseid").val($($this).find("td").eq(0).text());
		$("#expensename").val($($this).find("td").eq(1).text());
		$("#amount").val($($this).find("td").eq(2).text());
		$("#date").val($($this).find("td").eq(3).text());
		$("#add").hide();
		$("#update").show("fast");
		$("#delete").show("fast");
	};
	//End Of Document ready
	
</script>
	
<!-- Body Starts Here -->
	
	<s:form id="expense" theme="css_xhtml">
		<!-- 	<div style="width: 80%;"> -->
	<div style="width: 80%;margin-left: 10%;">
			<fieldset>
				<legend>Expenses Master</legend>
				<table>
					<tr><td><label>Total Amount At Gym</label></td>
					<td><s:textfield name="amountATGym" id="amountATGym" value="%{amountATGym}" readonly="true"/></td>
					<td><label></label></td></tr>
					<tr>
						<td style="margin-left: 20px;"><label>Expense Name<span class="required">*</span></label></td>
						<td><label>Amount<span class="required">*</span></label></td>
						<td><label>Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:hidden name="expenseid" id="expenseid" />
							<s:textfield name="expensename" id="expensename" value="" /></td>
						<td><s:textfield name="amount" id="amount" value="" /></td>
						<td><s:textfield name="date" id="date">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
						</td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<table>
					<tr>
						<td><s:submit align="center" action="addExpenseDetails"
								id="add" value="Add" /></td>
						<td><s:submit align="center" action="updateExpenseDetails"
								id="update" value="Update" style="display:none" /></td>
						<td><s:submit align="center" action="deleteExpenseDetails"
								id="delete" value="Delete" style="display:none" /></td>
						<s:token />
					</tr>
				</table>
			</fieldset>
		
			<!-- .......Display....... -->
			<fieldset>
				<div id="demo">
					<table class="display" id="record">
						<thead>
							<tr>
								<th>Expense ID</th>
								<th>Expense Name</th>
								<th>Amount</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="list">
								<tr onclick="showData(this);">
									<td style="text-align: center;"><s:property value="expenseid" /></td>
									<td style="text-align: center;"><s:property value="expensename" /></td>
									<td style="text-align: right;"><s:property value="amount" /></td>
									<td class="date" style="text-align: center;"><s:property value="date" /></td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
			</fieldset>
		</div>
	</s:form>