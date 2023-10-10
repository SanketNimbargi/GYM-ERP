<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 03/09/2014
	 Purpose: Personal Trainer Registration
-->

<!-- Java Script -->
<head>
<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/jquery-ui.js"></script>
<style>
body {
	font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
	font-size: 62.5%;
}
</style>
<script>
$(function() {
$( "#dialog" ).dialog();
});
</script>
</head>
<body>
<script type="text/javascript">
	$("#document").ready(function(){
		
		//$( "#accordion" ).accordion();
		
		//Change Pendinding Fees End Date to user format
		$("[id^='dueDate']").show(function(){
			$(this).text("Due Date: "+convertToUserDate($(this).text()));
		});
		//Change Fees End Date to user format
		$("[id^='endDate']").show(function(){
			$(this).text("End Date: "+convertToUserDate($(this).text()));
		});
		//Change Attendance Date to user format 
		$("[id^='attendanceDate']").show(function(){
			$(this).text("Last Attended: "+convertToUserDate($(this).text()));
		});
		
		//Change appointmentDate Date to user format 
		$("[id^='appointmentDate']").show(function(){
			$(this).text("Appointment Date: "+convertToUserDate($(this).text()));
		});
		//Change Birthday Date to user format
		$("[id^='birthDay']").show(function(){
			$(this).text("BirthDay: "+convertToUserDate($(this).text()));
		});  
		//Change AnniversaryDay Date to user format
		$("[id^='anniversaryDay']").show(function(){
			$(this).text("AnniversaryDay: "+convertToUserDate($(this).text()));
		});  
		//Change Reply Date to user format
		$("[id^='replyDate']").show(function(){
			$(this).text("Reply Date: "+convertToUserDate($(this).text()));
		});

		//Check unchake on click
		$(".member").click(function(){
			var check = "#check"+$(this).attr('id');
			if($(check).attr('checked')=='checked'){
				 $(check).removeAttr("checked");
				 $(this).attr("class","member");
			 }else{
				 $(check).attr("checked",'checked');
				 $(this).attr("class","checkedMember");
			 }
		});
		
		//Check unchake on click
		$(".renewBefore").click(function(){
			var check = "#check"+$(this).attr('id');
			if($(check).attr('checked')=='checked'){
				 $(check).removeAttr("checked");
				 $(this).attr("class","renewBefore");
			 }else{
				 $(check).attr("checked",'checked');
				 $(this).attr("class","checkedMember");
			 }
		});
		//Check unchake on click
		$(".renewAfter").click(function(){
			var check = "#check"+$(this).attr('id');
			if($(check).attr('checked')=='checked'){
				 $(check).removeAttr("checked");
				 $(this).attr("class","renewAfter");
			 }else{
				 $(check).attr("checked",'checked');
				 $(this).attr("class","checkedMember");
			 }
		});
		
		//Display Notification
		$("[class$='notification_header']").click(function(){
			var divClass = $(this).attr('class');
			if(divClass == "notification_header"){
				var areaId = "#notification_area_"+$(".click_notification_header").attr('id');
				$(areaId).hide();
				$(".click_notification_header").attr('class',"notification_header");
				
				$("#notification_area_"+$(this).attr('id')).show('slow');
				$(this).attr('class','click_notification_header');
			}
		});
		
		 $("#1").css("color","red");
		 $(".pending").css("color","red");
		 $(".totalFees").css("color","#990099");		 
	});
</script>

<!-- Body starts here -->

<!-- <div id="dialog" title="Notification"> -->
<div class="notification" >
<div class="navbar-inner" style="background:none;">
	<div class="span3"  style="position:fixed; top:100px; left:20px;">
	<div class="click_notification_header" id="1">
		<span class="required"><s:property value="%{pendingFeesList.size()}"/></span> Pending Fees
	</div>
	 <div class="notification_header" id="2" style="width:120px;"> 
		<span class="required"><s:property value="%{(reNewBeforList.size())+(reNewAfterList.size())}" /></span> Re-New 
	</div>
	<div class="notification_header" id="3">
		<span class="required"><s:property value="%{birthDayList.size()}" /></span> BirthDay Today
	</div>
	<div class="notification_header" id="7" style="width:120px;">
		<span class="required"><s:property value="%{birthDayList.size()}" /></span> Anniversary Today
	</div>
	<div class="notification_header" id="4"> 
		<span class="required"><s:property value="%{attendanceList.size()}" /></span> Attendance
	</div>
	
	<div class="notification_header" id="5" style="width:120px;"> 
		<span class="required"><s:property value="%{appointmentList.size()}" /></span> Today Appointment
	</div>
	
	<div class="notification_header" id="6" style="width:120px;"> 
		<span class="required"><s:property value="%{enquirytList.size()}" /></span> Enquiry 
	</div>
	
	</div>
	<div class="span12 pull-right"  style="padding-top:50px;">
	<!-- <hr> -->
	<div  class="notification_area" id="notification_area_1" style="display: inline;">
		<s:form theme="css_xhtml">
			<s:if test="pendingFeesList.size() > 0">
				<table>
					<s:iterator value="pendingFeesList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<div class="member" style="height: 120px" id="<s:property value="memberId" />">
								<table >
									<tr>
										<td rowspan="6">
											<input type="checkbox" id="check<s:property value="memberId"  />" 
												name="check[<s:property value="memberId" />]" style="display: none;" />
											<img src="<%=request.getContextPath()%>/MemberImages/<s:property value="memberId" />.jpg" width="80" height="90" alt="Image" />
										</td>
										<td id=memberId>Member ID: M<s:property value="memberId" /> </td>
									</tr>
									<tr>
										<td colspan="2">Name: <s:property value="%{name}" /></td> 
									</tr>
									<tr>
										<td colspan="2">Contact No: <s:property value="%{contactNo}" /></td> 
									</tr>
									<tr>
										<td colspan="2">Ledger: <s:property value="ledgerName" /></td>
									</tr>
									<tr>
										<td colspan="2" id="dueDate<s:property value="memberId" />"><s:property value="dueDate" /></td>
									</tr>
									<tr>
										<td class="totalFees"style="padding-right: 10px;">Total Fees: <s:property value="%{ledgerTotalFees}" /></td> 
										<td class="pending">Pending: <s:property  value="%{ledgerPendingFees}" /></td> 
									</tr>
									<tr height="50"></tr>
								</table>
							</div>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" /></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn"/>
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	 <div class="notification_area" id="notification_area_2">
		<s:form theme="css_xhtml">
			<s:if test="(reNewList.size()) > 0">
				<table>
					<s:iterator value="reNewList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<s:if test="#currentRecord.index < reNewAfterList.size()">
								<div class="renewAfter" id="<s:property value="memberId" />"> </div>
							</s:if>
							<s:else>
								<div class="renewBefore" id="<s:property value="memberId" />">
							
								<table>
									<tr>
										<td rowspan="5">
											<input type="checkbox" id="check<s:property value="memberId"  />" 
												name="check[<s:property value="memberId" />]" style="display: none;" />
											<img src="<%=request.getContextPath()%>/MemberImages/<s:property value="memberId" />.jpg" width="80" height="90" alt="Image" />
										</td>
										<td colspan="2">Name: <s:property value="%{name}" /></td>
									</tr>
									
									<tr>
										<td width="20px;">ID: M<s:property value="memberId" /> </td>
										<td id="endDate<s:property value="memberId" />"  width="60px" ><s:property value="endDate" /> </td>
									</tr>
									<tr>
										<td colspan="2">Contact No: <s:property value="%{contactNo}" /></td> 
									</tr>
									<tr>
										<td colspan="2">Package Name:</td>
									</tr>
									<tr>
										<td colspan="2"><s:property value="%{ledgerName}" /></td>
									</tr>
								</table>
							</div>
							</s:else>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" /></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn"/>
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	
	
	<div class="notification_area" id="notification_area_3">
		<s:form theme="css_xhtml">
			<s:if test="birthDayList.size() > 0">
				<table>
					<s:iterator value="birthDayList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<div class="member" id="<s:property value="memberId" />">
								<table>
									<tr>
										<td rowspan="5">
											<input type="checkbox" id="check<s:property value="memberId"  />" 
												name="check[<s:property value="memberId" />]" style="display: none;" />
											<img src="<%=request.getContextPath()%>/MemberImages/<s:property value="memberId" />.jpg" width="80" height="90" alt="Image"/>
										</td>
										<td id=memberId>Member ID: M<s:property value="memberId" /> </td>
									</tr>
									<tr>
										<td>Name: <s:property value="%{firstName+' '+middleName+' '+lastName}" /></td>
									</tr>
									<tr>
										<td colspan="2">Contact No: <s:property value="%{contactNo}" /></td> 
									</tr>
									<tr>
										<td id="birthDay<s:property value="memberId" />"><s:property value="dateOfBirth" /></td>
									</tr>
									<tr height="50"></tr>
								</table>
							</div>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" value="Dear Member, Wish you a Very Happy Birthday and a Great Year ahead ! !"/></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn"/>
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	<div class="notification_area" id="notification_area_4">
		<s:form theme="css_xhtml">
			<s:if test="attendanceList.size() > 0">
				<table>
					<s:iterator value="attendanceList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<div class="member" id="<s:property value="memberId" />">
								<table>
									<tr>
										<td rowspan="4">
											<input type="checkbox" id="check<s:property value="memberId"  />" 
												name="check[<s:property value="memberId" />]" style="display: none;" />
											<img src="<%=request.getContextPath()%>/MemberImages/<s:property value="memberId" />.jpg" width="80" height="90" alt="Image" />
										</td>
										<td id=memberId>Member ID: M<s:property value="memberId" /> </td>
									</tr>
									<tr>
										<td>Name: <s:property value="%{firstName+' '+middleName+' '+lastName}" /></td>
									</tr>
									<tr>
										<td colspan="2">Contact No: <s:property value="%{contactNo}" /></td> 
									</tr>
									<tr>
										<td id="attendanceDate<s:property value="memberId" />"><s:property value="attendanceDate" /></td>
									</tr>
									<tr height="50"></tr>
								</table>
							</div>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" /></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn" />
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	
	
	
	<div class="notification_area" id="notification_area_5" >
		<s:form theme="css_xhtml">
			<s:if test="appointmentList.size() > 0">
				<table>
					<s:iterator value="appointmentList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<div class="member" style="width:200px; height:90px;" id="<s:property value="appointmentId" />">
								<table >
									<tr>
										<td >
											<input type="checkbox" id="check<s:property value="appointmentId"  />" 
												name="check[<s:property value="memberId" />]" style="display: none;" />
											<%-- <img src="<%=request.getContextPath()%>/MemberImages/<s:property value="memberId" />.jpg" width="80" height="90" alt="Image" /> --%>
										</td>
										
									</tr>
									<tr>
										<td>Name: <s:property value="%{firstNameAppointment+' '+lastNameAppointment}" /></td>
									</tr>
									<tr>
										<td>Contact No: <s:property value="%{contactNoAppointment}" /></td>
									</tr>
									<tr>
										<td id="appointmentDate<s:property value="appointmentId" />"><s:property value="appointmentDate" /></td>
									</tr>
									<tr>
										<td>Time: <s:property value="%{appointmentTime}" /></td>
									</tr> 
									
									<tr height="50"></tr>
								</table>
							</div>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" /></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn" />
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	
			
	<div class="notification_area" id="notification_area_6" >
		<s:form theme="css_xhtml">
			<s:if test="enquirytList.size() > 0">
				<table>
					<s:iterator value="enquirytList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">						
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<div class="member" style="width:200px; height:90px;" id="<s:property value="displayEnquiryId" />">
								<table >
									<tr>
										<td >
											<input type="checkbox" id="check<s:property value="displayEnquiryId"  />" 
												name="check[<s:property value="displayEnquiryId" />]" style="display: none;" />
										</td>
										
									</tr>
									<tr>
										<td>Name: <s:property value="%{firstNameEnquiry+' '+lastNameEnquiry}" /></td>
									</tr>
									<tr>
										<td>Contact No: <s:property value="%{contactNoEnquiry}" /></td>
									</tr>
									<tr>
										<td id="replyDate<s:property value="replyDate" />"><s:property value="replyDate" /></td>
									</tr>
									<tr>
										 <td>Enquiry Handled By: <s:property value="enquiryHandledBy" /></td>
									</tr>
									<tr height="50"></tr>
								</table>
							</div>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" /></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn" />
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	<div class="notification_area" id="notification_area_7">
		<s:form theme="css_xhtml">
			<s:if test="anniversaryDayList.size() > 0">
				<table>
					<s:iterator value="anniversaryDayList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td style="padding:5px 10px;">
							<div class="member" id="<s:property value="memberId" />">
								<table>
									<tr>
										<td rowspan="5">
											<input type="checkbox" id="check<s:property value="memberId"  />" 
												name="check[<s:property value="memberId" />]" style="display: none;" />
											<img src="<%=request.getContextPath()%>/MemberImages/<s:property value="memberId" />.jpg" width="80" height="90" alt="Image"/>
										</td>
										<td id=memberId>Member ID: M<s:property value="memberId" /> </td>
									</tr>
									<tr>
										<td>Name: <s:property value="%{firstName+' '+middleName+' '+lastName}" /></td>
									</tr>
									<tr>
										<td colspan="2">Contact No: <s:property value="%{contactNo}" /></td> 
									</tr>
									<tr>
										<td id="anniversaryDay<s:property value="memberId" />"><s:property value="anniversaryDate" /></td>
									</tr>
									<tr height="50"></tr>
								</table>
							</div>
						</td>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" value="Dear Member, Happy Anniversary! May you celebrate many more years together, withstanding the tests of time to emerge stronger and happier !"/></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn" />
						<td>
					</tr>
				</table>
			</s:if>
		</s:form>
	</div>
	</div>
	</div>
	</div>
<!-- </div>	 -->
</body>