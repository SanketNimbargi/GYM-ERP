<%@taglib uri="/struts-tags" prefix="s"%>
 
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
	 
	});
 
		 
		  
	 
	
</script>

<!-- Body starts here -->
<div style="width: 90%;margin-left:5%;margin-top:5%;">
	<!-- <div style="width: 120%;margin-left:-12%"> -->
		<s:form id="paymentUpdateTrackReport" theme="css_xhtml">
		 
			<fieldset>
				<legend>Payment Tracking</legend>
				 
			</fieldset>	
			
			<fieldset id="contactField" >
				<div id="count" style="float: right; font-weight: bolder; color: green; font-family: cursive;"></div>
				<table>
					<tr>
						 
						<td>
							 
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
								<th>MID</th>	
								<th>Member Name</th>						
								<th>Contact</th>
								<th>hourType</th>								
								<th>startDate</th>
								<th>endDate</th>
								<th>dueDate</th>
								<th>ledgerTotalFees</th>
								<th> previousAmt</th>
								<th> updatedAmt</th>
								<th>currPayment</th>
								<th>date</th>	 
								 				
							</tr>
							</thead>
							<tbody>
							<s:iterator  value="paymentTrck">  
								<tr>
									<td><s:property value="memberId"/></td>
									<td><s:property value="firstName"/> <s:property value="lastName"/></td>
									<td><s:property value="contactNo"/></td>
									<td><s:property value="hourType"/></td>
									<td><s:property value="startDate"/></td>
									<td><s:property value="endDate"/></td>
									<td><s:property value="dueDate"/></td>
									<td><s:property value="ledgerTotalFees"/></td>
									<td><s:property value="previousAmt"/></td>
									<td><s:property value="updatedAmt"/></td>
									<td><s:property value="currPayment"/></td>
									<td><s:property value="date"/></td>
									 
								</tr>
							</s:iterator>  
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
							<s:submit action="paymentUpdateTrackReport" id="auditReportAction" align="center" value="Report"  />
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