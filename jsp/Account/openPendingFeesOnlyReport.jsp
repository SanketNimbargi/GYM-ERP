<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Sunil JAGTAP
	 Date: 12/09/2014
	 Purpose: send message to member
-->

<!-- Java Script -->

<script type="text/javascript">
var auditDataList = [];
	$("#document").ready(function(){	
		//Datepicker
		$('#fromDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
		});
		
		//Datepicker
		$('#toDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
		});
		//date 
		 $.each($('.date'), function() {
			 $(this).text(convertToUserDate( $(this).text()));
	    }); 
		
			
	  $("#getList").click(function(){
		  var fromDate=$("#fromDate").val();
		  var toDate=$("#toDate").val();
		  var feeStatus=$("#feeStatus").val();		 
		  $.getJSON('fetchMemberPendingFeesList',{fromDate : fromDate, toDate : toDate, feeStatus : feeStatus}).done(function(data){				 
				$('<div class="errors" id="message" style="width: 400px; display: none;"></div>)').appendTo($("#errorContainer"));
				if(data.memberPendingFeesList == undefined || parseInt(data.memberPendingFeesList.length)==0 ){
					$("#message").text("No one members fee completed...").show();
				}
				else{
					//Table created again. Delete previous Table.
					var tableDivId = $("#divTable");			    
					tableDivId.empty();
					$('<table class="display" id="auditDetailTable">'+
						'<thead><tr height="30px" bgcolor="CACECF">'+
						'<th>Sr. No.</th><th>Receipt Date</th><th>Member Name</th><th>Receipt Number</th>'+
						'<th>Mobile Number</th><th>Ledger Total Amount</th><th>Discount</th><th>Already Paid</th><th>Last Paid</th><th>Pending Fees</th><th>Tax %</th><th>Tax Type</th>'+
						'<th style="display:none">FirstName</th><th style="display:none">MiddleName</th><th style="display:none">LastName</th>'+
						'</tr></thead><tbody></tbody></table>').appendTo(tableDivId);		
					 
					createTable($("#auditDetailTable tbody"),data.memberPendingFeesList);						
				}
		 })
		 .fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
		 });
		 
	  });   
	  
	$(function(){			
			$("#number_selection").change(function(){
				var opt = $("#number_selection").val();
				if(opt == "All")
				{
					$("#1").css("visibility","hidden");
					$("#2").css("visibility","hidden");
					$("#3").css("visibility","hidden");
					$("#4").css("visibility","hidden");
					$("#5").css("visibility","hidden");
					$('input:checkbox').prop('checked', true).attr('checked', true);
					 pushTableData();
				}
				
				if(opt == "Particular")
				{
					$('input:checkbox').prop('checked', false).removeAttr("checked");
					$("#1").css("visibility","visible");
					$("#2").css("visibility","visible");
					$("#3").css("visibility","visible");
					$("#4").css("visibility","visible");
					$("#5").css("visibility","visible");
				}
				
			});
			
		});
		
		
		$(function(){			
			$("#check").click(function(){
				
				$('input:checkbox').prop('checked', false).removeAttr("checked");
				var from = $("#from").val();
				var to = $("#to").val();
				$('input:checkbox').slice( parseInt(from)-1, parseInt(to) ).prop('checked', true).attr('checked', 'checked');			
				 pushTableData();
			});
		});
	

	function addContactHiddenTable(){
		var contactNo = [];
		$(':checkbox:checked').each(function(i){
			contactNo[i] = $(this).val();
	    	{
	      		var table = document.getElementById("tbl_CheckedContactNo");
	      		var rowCount = table.rows.length;
	      		var counts = rowCount - 1;
	      		var row = table.insertRow(rowCount);
	      		
	      		var cellSubExamId = row.insertCell(0);
	      		var eleSubExamId = document.createElement("input");
	      		eleSubExamId.type = "text";
	      		eleSubExamId.name = "contactList[" + counts + "].contact_no";
	      		eleSubExamId.value = parseInt(contactNo[i]);
	      		cellSubExamId.appendChild(eleSubExamId);
	    	}
	    	
	    });
	}
		
		//Fields Validation
		$("#configureConnection").validate({
			debug : true,
			rules : {
				"operatorNo" : "required",
				"portNo" : "required"
			},
			messages : {
				"operatorNo" : "Please select operator name.",
				"portNo" : "Please select Device."
			},
			submitHandler : function(form) {				
				form.submit();
			}
		});
		$("#auditReportForm").validate({
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
				var checkCount=$("#checkboxlist input:checked").length;
				if(checkCount==0){
					$('<div class="errors" id="message" style="width: 400px; display: none;"></div>)').appendTo($("#errorContainer"));
					$("#message").text("Please Select Members List  (at list 1)...").show();
				}else{
				  form.submit();
				}
			}
		});  
		
		 $("#auditReportAction").click(function() {					 
			 var dataObj = {"auditReportList": auditDataList};
	      	 var dataList = JSON.stringify(dataObj);	      	
			$("#auditDataList").val(dataList);		
			// document.forms["auditReportForm"].submit();		 
		 });
		
	});
/* 	<th>Sr.No.</th>	
	<th>Receipt Date</th>						
	<th>Member Name</th>
	<th>Receipt Number</th>								
	<th>Mobile Number</th>
	<th>Ledger Total Amount</th>
	<th>Ledger Gross Amount</th>
	<th>Discount</th>																								
	<th>Tax %</th>
	<th>Tax Type</th>
	<th>Paid Fees</th>	 */
	function pushTableData(){
	
		/* look for all checkboes that have a parent id called 'checkboxlist' attached to it and check if it was checked */
		auditDataList.length=0;
		  $("#checkboxlist input:checked").each(function() {	
				
				var rowId=$(this).val();	
				var receiptDate=$('#tr'+rowId).find('td').eq(1).text().replace(/\s/g, '');
				var name=$('#tr'+rowId).find('td').eq(2).text();
				var finalReceiptNo=$('#tr'+rowId).find('td').eq(3).text().replace(/\s/g, '');
				
				var contactNo=$('#tr'+rowId).find('td').eq(4).text().replace(/\s/g, '');
				var ledgerTotalFees=$('#tr'+rowId).find('td').eq(5).text().replace(/\s/g, '');
				var discount=$('#tr'+rowId).find('td').eq(6).text().replace(/\s/g, '');
				var alreadyPaid=$('#tr'+rowId).find('td').eq(7).text().replace(/\s/g, '');	
				var lastPaid=$('#tr'+rowId).find('td').eq(8).text().replace(/\s/g, '');
				var pendingFees=$('#tr'+rowId).find('td').eq(9).text().replace(/\s/g, '');
				
				var tax=$('#tr'+rowId).find('td').eq(10).text().replace(/\s/g, '');
				var taxType=$('#tr'+rowId).find('td').eq(11).text().replace(/\s/g, '');	
				 
				 
				
				auditDataList.push({receiptDate:receiptDate,name:name,finalReceiptNo:finalReceiptNo,
					contactNo:contactNo,
					ledgerTotalFees:ledgerTotalFees,
					discount:discount,
					ledgerAlreadyPaid:alreadyPaid,ledgerLastPaid:lastPaid,ledgerPendingFees:pendingFees,		
					tax:tax,taxType:taxType
				}); 
				//console.log(auditDataList);
				//alert(JSON.stringify(auditDataList));
				 //alert(auditDataList.length);
			});
		 
	};
	
	
	//Create Table
	var createTable = function(tableName,data){
		//tableName.empty();		
		for (var i = 0; i < data.length; i++) {
			var row = $('<tr id="tr'+i+'"></tr>').appendTo( tableName);		
			$('<td  align="center" style="width: 8%"><div style="float: left;"><label>'+(i+1)+'</label></div>'
					+'<input type="checkbox" class="checkbox" id="check" name="check'+(i+1)+'" value="'+i+'"></td>').appendTo(row);			
			$('<td></td>').text(data[i].finalReceiptNo).appendTo(row);
			$('<td style="width: 50%"></td>').text(data[i].memberfName+" "+data[i].memberlName).appendTo(row);
			$('<td></td>').text(data[i].finalReceiptNo).appendTo(row);	
			
			$('<td></td>').text(data[i].contact).appendTo(row);
			$('<td></td>').text(data[i].ledgerTotalFees).appendTo(row); /* totalMount */
			$('<td></td>').text(data[i].discount).appendTo(row);
			$('<td></td>').text(data[i].ledgerPaidFees).appendTo(row);
			$('<td></td>').text(data[i].ledgerAlreadyPaidFees).appendTo(row);
			$('<td></td>').text(data[i].ledgerPendingFees).appendTo(row);
			
			$('<td></td>').text(data[i].tax).appendTo(row);
			$('<td></td>').text(data[i].taxType).appendTo(row);
			
			
			$('<td style="display:none"></td>').text(data[i].firstName).appendTo(row);
			$('<td style="display:none"></td>').text(data[i].middleName).appendTo(row);			
			$('<td style="display:none"></td>').text(data[i].lastName).appendTo(row);			
			pushTableData();
		}
		//date 
		 $.each($('.date'), function() {
			 $(this).text(convertToUserDate( $(this).text()));
	    });
		// $("#auditDetailTable").dataTable();
		 $(".checkbox").click(function(){			
			  pushTableData();		
		  });
	
	};	
	
</script>

<!-- Body starts here -->
<div style="width: 90%;margin-left:5%">
	<!-- <div style="width: 120%;margin-left:-12%"> -->
		<s:form id="auditReportForm" theme="css_xhtml">
		 <s:hidden id="auditDataList" name="auditDataList" value=""/>
			<fieldset>
				<legend>Audit Report</legend>
				<table >
					
					<tr>
						<%-- <td ><label>Select Members According to Fee Status</label></td>
						<td ><s:select name="feeStatus" id="feeStatus" cssStyle="width:160px;"
								list="#{'complete':'Fee complete Member'}" />
						</td> --%>
						<td colspan="4">Complete Fees Member Report Between Dates</td>						
				  </tr>	
				  <tr height="10px;"></tr>	
				  <tr>
				  	<td>From<span  class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;</td>
				  		<td><s:textfield name="fromDate" id="fromDate" class="date" >								
							</s:textfield>
						</td>
						<td>To<span  class="required">*</span>&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td><s:textfield name="toDate" id="toDate" class="date">
								
							</s:textfield>
						</td>
				  </tr>		 
				</table>
				<hr/>
				<table>
					 <tr>						
						<td>
							<input type="button" id="getList" value="Get Member List" class="mybtn" /> 							
					   </td>						
					</tr>
				</table>	
			</fieldset>	
			
			<fieldset id="contactField" >
				<div id="count" style="float: right; font-weight: bolder; color: green; font-family: cursive;"></div>
				<table>
					<tr>
						<td style="vertical-align: top;">Number Selection :</td>
						<td>
							<s:select name="number_selection" id="number_selection" cssStyle="width:140px;"
								headerKey="-1" headerValue="--- Select ---"
								list="#{'All':'Select All',
										'Particular':'Select Particular'}">
							</s:select>
						</td>
						<td style="vertical-align: top; visibility: hidden;" id="1">From Sr. No. :</td>
						<td style="visibility: hidden;" id="2">
							<s:textfield name="from" id="from"/>
						</td>
						<td style="vertical-align: top; visibility: hidden;" id="3">To Sr. No. :</td>
						<td style="visibility: hidden;" id="4">
							<s:textfield name="to" id="to"/>
						</td>
						<td style="visibility: hidden;" id="5">
							<input type="button" name="check" id="check" value="Check" class="mybtn"/>
						</td>
					</tr>
				</table>
				
				<fieldset style="width:98%;">
				<div id="checkboxlist">
				<div id="divTable">
					<table class="display" id="auditDetailTable">
						<thead>
							<tr height="30px" bgcolor="CACECF">
								<th>Sr.No.</th>	
								<th>Receipt Date</th>						
								<th>Member Name</th>
								<th>Receipt Number</th>								
								<th>Mobile Number</th>
								<th>Ledger Total Amount</th>
								<th>Discount</th>
								<th>Already Paid</th>
								<th>Last Paid</th>
								<th>Pending Fees</th>
								<th>Tax %</th>
								<th>Tax Type</th>
									<!-- FinalPaidFees -->
								<th style="display:none">FirstName</th><th style="display:none">MiddleName</th><th style="display:none">LastName</th>							
							</tr>
							</thead>
							<tbody>
							</tbody>
												
					</table>
					</div>
					</div>
				</fieldset>
			</fieldset>
			<fieldset>
			<table>
					 <tr>						
						<td>
							 <s:submit action="pendingAuditReportPrintAction" id="auditReportAction" align="center" value="Audit Report"  />  
					   </td>						
					</tr>
				</table>	
			</fieldset>
			
			
		</s:form>
		
	</div>
	
	
	
	
	
<%-- 	
	<tbody>
						
	<% int sr_no = 0; %>
		<s:iterator value="auditMemberList">
			<% sr_no = sr_no + 1; %>
				<tr id="tr<%= sr_no-1 %>">
					<td align="center" style="width: 8%">										
							<div style="float: left;"><label><%= sr_no %></label></div>
							<input type="checkbox" class="checkbox" id="check" name="check[<s:property value='memberId'/>]" value="<%= sr_no-1 %>">
									</td>
									<td align="center">
										M<s:property value="memberId"/>
									</td>
									<td style="width: 50%">
										<s:property value="name"/>
									</td>									
								<td>             
									<s:property value="receiptNo"/></td>
								<td class="date" style="width: 20%;">
								<s:property value="startDate"/></td>
								
								<td class="date" style="width: 20%;">
								<s:property value="endDate"/></td>
								
								<td align="center">
										<s:property value="contactNo"/></td>
								<td>
								<s:property value="ledgerTotalFees"/></td>
								<td>								
								<s:property value="discount"/></td>
								<td>
								<s:property value="ledgerAlreadyPaidFees"/></td>
								<td>
								<s:property value="ledgerPaidFees"/></td>
								<td>
								<s:property value="ledgerPendingFees"/></td>
								<td>
								<s:property value="tax"/></td>									
								<td>
								<s:property value="taxValue"/></td>
								
								
									<td style="display:none">
										<s:property value="firstName"/>
									</td> 
									<td style="display:none">
										<s:property value="middleName"/>
									</td>
									
									<td style="display:none">
										<s:property value="lastName"/>
									</td>
									
							
								</tr>
							</s:iterator>
							
						</tbody> --%>