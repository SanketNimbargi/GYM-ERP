<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*,java.text.*" %>
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
	/* 	
var today1 = new Date();

		var dd = today1.getDate()+5;
		
		var mm = today1.getMonth()+1; //January is 0!

		var yyyy = today1.getFullYear();
		if(dd<10){
   			 dd='0'+dd
		} 
		if(mm<10){
   			 mm='0'+mm
		} 
		var today1 = yyyy+"-"+mm+"-"+dd;
		var oneday=1000*60*60*24;
		alert("HAHAHA"); */
		/* Date tomorrow = now().plusDays(1).toDate();
		alert(tomorrow); */
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
				/* var areaId = "#notification_area_"+$(".click_notification_header").attr('id'); */
				var areaId = "#notification_area_"+$(".notification_header").attr('id');
				$(areaId).hide();
				//$(".click_notification_header").attr('class',"notification_header");
				$(".notification_area").hide();
				$("#notification_area_"+$(this).attr('id')).show('slow');
				//$(this).attr('class','click_notification_header');
				$(".notification_header").css('color','');
				$(this).css('color','blue');
				$("#container").hide();
			}
		});
	
	
		 //$("#1").css("color","red");
		 $(".pending").css("color","red");
		 $(".totalFees").css("color","#990099");		 
	});
	function closeAction(id){
		$(".notification_header").css('color','');
		$(".notification_area").hide();
		$("#container").show();
		
	}
		
	function activeHide(){
		alert("Hi...");
		//var memberId=$("#memberId").val().substring(1);
		$.getJSON('fetchActiveMembers.action').done(function(data){
 		
			if(today > data.activeMemberList[0].endDate){
				alert("Bye");
				$("#tr").css("background","red");
			}else
				if(today < data.activeMemberList[0].endDate){
					
					if(( (new Date(convertToUserDate(today)).getTime() - new Date(convertToUserDate(data.activeMemberList[0].endDate)).getTime())/(oneday)) > 5){
						
						$("#tr").css("background", "green");
				
					} else
						 $("#tr").css("background","yellow");
				}else
			$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error While Fetching. Please Try Again...").show();
			 
			});
	
	};
	
</script>

<!-- Body starts here -->

<!-- <div id="dialog" title="Notification"> -->
<div class="notification" >
<div class="navbar-inner" style="background:none;">
	<div class="span3"  style="position:fixed; top:100px; left:0px; margin-top: 20px; width: 120px;">
	<div class="notification_header" id="1" > 
	<!-- <div class="notification_header" id="1"> -->
		<span class="required"><s:property value="%{pendingFeesList.size()}"/></span> Pending Fees
	</div>
	 <div class="notification_header" id="2" style="width:120px;"> 
		<span class="required"><s:property value="%{(reNewBeforList.size())+(reNewAfterList.size())}" /></span> Re-New 
	</div>
	<div class="notification_header" id="3">
		<span class="required"><s:property value="%{birthDayList.size()}" /></span> BirthDay Today
	</div>
	<div class="notification_header" id="7" style="width:120px;">
		<span class="required"><s:property value="%{anniversaryDayList.size()}" /></span> Anniversary Today
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
	
	<div class="notification_header" id="8" style="width:120px;"> 
		<span class="required"><s:property value="%{activeMemberList.size()}"/></span> Active Members 
		<input type="button" value="" onclick="activeHide();">
	</div>
	
	<div class="notification_header" id="9" style="width:120px;"> 
		<span class="required"><s:property value=""/></span> Inactive Members 
	</div>
	
	<div class="notification_header" id="10" style="width:120px;"> 
		<span class="required"></span> Presenty 
	</div>
	
	</div>
	<!-- <div class="span12"  style="padding-top:50px;margin-left:188px; padding-top: 24px;"> -->
	<div  style="padding-top:50px;margin-left:188px; padding-top: 24px;width: 80%;">
	<hr> 
	<!-- <div  class="notification_area" id="notification_area_1" style="display: inline;"> -->
	<div  class="notification_area" id="notification_area_1">
		<s:form theme="css_xhtml">
		<a href="javascript:void(0);" onclick="closeAction('notification_area_1');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="memberId" />]" style="display: none;" checked="checked"/>
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
		<a href="javascript:void(0);" onclick="closeAction('notification_area_2');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="memberId" />]" style="display: none;" checked="checked"/>
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
		<a href="javascript:void(0);" onclick="closeAction('notification_area_3');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="memberId" />]" style="display: none;" checked="checked"/>
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
		<a href="javascript:void(0);" onclick="closeAction('notification_area_4');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="memberId" />]" style="display: none;" checked="checked"/>
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
		<a href="javascript:void(0);" onclick="closeAction('notification_area_5');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="memberId" />]" style="display: none;" checked="checked"/>
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
		<a href="javascript:void(0);" onclick="closeAction('notification_area_6');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="displayEnquiryId" />]" style="display: none;" checked="checked"/>
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
		<a href="javascript:void(0);" onclick="closeAction('notification_area_7');"><img alt="" src="images/cancel.png"/></a>
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
												name="check[<s:property value="memberId" />]" checked="checked" style="display: none;"/>
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
	
	 <div class="notification_area" id="notification_area_8">
	<s:form theme="css_xhtml">
		<a href="javascript:void(0);" onclick="closeAction('notification_area_8');"><img alt="" src="images/cancel.png"/></a>
		<s:if test="activeMemberList.size() > 0">
				<table>
					<s:iterator value="activeMemberList" status="currentRecord">
						<s:if test="(#currentRecord.index % 2) == 0">
							<s:if test="#currentRecord.index > 0">
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
			
			
			<%-- 	<s:if test="nearToInactive.size() > 0">	
				<s:iterator value="nearToInactive" status="nearInaciveRecord">
				<s:if test='%{elements(#nearInaciveRecord.index).status.equals (#currentRecord.index)} '> 
				 --%>
		
				
  <%-- <%  			
  Date dNow = new Date( );
  SimpleDateFormat ft = 
  new SimpleDateFormat ("yyyy.MM.dd ");
  out.print( "<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
  %>   
          

  	<s:if test="#currentRecord.endDate >= <% out.print(currentDate.toString()); %>">
      <td style="background: #CCCCCC"><s:property/></td> 
   
     <s:elseif test="#comboMealsStatus.first == true">
      <td><s:property/> (This is first value) </td>
    </s:elseif>
    <s:else>
      <td><s:property/></td>
    </s:else>  --%>
  

					
					
					
						<td style="padding:5px 10px;">
							<div class="member" id="<s:property value="memberId" />">
								<table>
									<tr>
										<td rowspan="5">
											<input type="checkbox" id="check<s:property value="memberId"  />" 
												name="check[<s:property value="memberId" />]" checked="checked" style="display: none;"/>
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
										<td>End date<s:property value="%{endDate}"/></td>
									</tr>
									<tr>
										<td id="activeMembers<s:property value="memberId" />"><s:property value="activeMembers" /></td>
									</tr>
									<tr height="50"></tr>
								</table>
							</div>
						</td>
						<%-- </s:if>
					</s:iterator>
					</s:if> --%>
					</s:iterator>
					<!-- close last open row -->
				</table>
				<table>
					<tr>
						<td><label>Send Message :</label></td>
						<td><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" value=""/></td>
						<td><s:submit action="sendSMS" value="Send" cssClass="smallBtn" />
						<td>
					</tr>
				</table>
				 </s:if> 
			
			</s:form>
	</div> 
	<div class="notification_area" id="notification_area_10">
		<div style="width: 90%;margin-left: 5%;">
		<s:form theme="css_xhtml">
		<div style="width: 100%;">
			<fieldset>
				<legend>Member Details</legend>
			<table>
				<tr>
					<td><label>Member Id</label></td>
					<td><s:hidden name="memberId" id="memberId" value="" />
						<s:hidden name="attendanceId" id="attendanceId" value="" />
						<s:textfield name="displayMemberId" id="displayMemberId" 
							placeholder="M1" onkeyup="upperCase(this); " tabindex="0" />
					</td>
					<td><label>Member Name</label></td>
					<td><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
					<td><label>Contact No.</label></td>
					 <td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
				</tr>
			</table>
			
			<hr />
			<table class="display" id="attendanceDetails" style="display: none;" border="">
				<tr>
					<td id="image" rowspan="3"></td>
					<td><label>Member name</label></td>
					<td><label>Date</label></td>
					<td><label>In Time</label></td>
					<td><label>Out Time</label></td>
				</tr>
				<tr id="tr">
					<td><label id="memberName"></label></td>
					<td><s:textfield name="attendanceDate" id="attendanceDate" readonly="true" cssStyle="width:80px;">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
					</td>
					<td><input type="button" id="in" class="mybtn"  tabindex="1" value="In" cssClass="smallBtn"/>
						<s:textfield name="inTime" id="inTime" readonly="true" value="00:00" cssStyle="width:40px; display:none;" /></td>
					<td><input type="button" id="out" class="mybtn"  tabindex="2" value="Out" cssClass="smallBtn"/>
						<s:textfield name="outTime" id="outTime" readonly="true" value="00:00" cssStyle="width:40px; display:none;" /></td>
				</tr>
				<tr height="50px;"></tr>
			</table>
			</fieldset>
			</div>
		</s:form>
	</div>
	</div>
	
	</div>
	</div>
	</div>
<!-- </div>	 -->
</body>

<script type="text/javascript">
	
		var today = new Date();
		
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!

		var yyyy = today.getFullYear();
		if(dd<10){
   			 dd='0'+dd
		} 
		if(mm<10){
   			 mm='0'+mm
		} 
		var today = yyyy+"-"+mm+"-"+dd;
		var oneday=1000*60*60*24;
		
		
	$("#document").ready(function(){
		
		
		//Auto Complete for Search By Member Name
		autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		
		 //Auto Complete for Search By number
		autoCompleteSearchMember("contactNo","displayMemberId",onMemberIdChange);
		
		// fetch member details
		$("#displayMemberId").change(function(){
			onMemberIdChange();						//Fetch Members Details On Change of Member Id
		});
		
		//Save In time
		$("#in").click(function(){
			var now = new Date($.now());
			var inTime = now.getHours()+":"+now.getMinutes();
			$("#inTime").val(inTime);
			$("#inTime").show();
			$("#in").hide();
			var memberId = $("#memberId").val();
			$.getJSON('saveInTime',{inTime : inTime , memberId : memberId}).done(function(data){
				$("#attendanceId").val(data.attendanceId);
				$("#message").text("").hide();
			});
		});
		
		//Save Out Time
		$("#out").click(function(){
			if($("#inTime").val()!="00:00"){
				$("#message").text("").hide();
				var now = new Date($.now());
				var outTime = now.getHours()+":"+now.getMinutes();
				$("#outTime").val(outTime);
				$("#outTime").show();
				$("#out").hide();
				var attendanceId = $("#attendanceId").val();
				$.getJSON('saveOutTime',{outTime : outTime , attendanceId : attendanceId}).done(function(data){});
			}
			else{
				$("#message").text("Please click on In Time First...").show();
			}
		});
		
	}); //End Of Document ready
	
         
         
         
     
	
	//Function to Fetch Members Details On Change of Member Id
	var onMemberIdChange = function(){
		clearForm();
		var memberId=$("#displayMemberId").val().substring(1);
		var checkMemberString=$("#displayMemberId").val().substring(0,1);
		if(memberId > 0 && checkMemberString == 'M')
		{
			$("#memberId").val(parseInt(memberId));
			$.getJSON('fetchMemberAttendance',{memberId : memberId}).done(function(data){		//Json To Fetch Data
				if(data.memberDetailsList[0] != undefined){
					
					assignData(data.memberDetailsList[0],data.attendanceDetailsList[0]);
					if(today > data.memberDetailsList[0].endDate){
						
						$("#tr").css("background","red");
					}else
						if(today < data.memberDetailsList[0].endDate){
							
							if(( (new Date(convertToUserDate(today)).getTime() - new Date(convertToUserDate(data.memberDetailsList[0].endDate)).getTime())/(oneday)) > 5){
								
								$("#tr").css("background", "green");
						
							} else
								 $("#tr").css("background","yellow");
						}	
					
				}else
					$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
	};
	
	//Assign Data
	var assignData = function(memberData,attendanceData){
		$("#attendanceDetails").show();
		$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+memberData.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" alt="Image Not Added" />');
		$("#membersNameAutocomplete").val(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
		$("#memberName").text(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
		$("#contactNo").val(memberData.contactNo);
		if(attendanceData != undefined)
		{
			if(attendanceData.inTime != null){
				$("#inTime").show();
				$("#in").hide();
				$("#inTime").val(attendanceData.inTime);
			}
			if(attendanceData.outTime != null){
				$("#outTime").show();
				$("#out").hide();
				$("#outTime").val(attendanceData.outTime);
			}
			$("#attendanceId").val(attendanceData.attendanceId);
		}
	};
	
	//Clear all Data
	var clearForm = function(){
		$("#message").hide();
		$("#attendanceDetails").hide();
		$("#imageMember").remove();
		$("#memberName").text("");
		$("#attendanceId").val(0);
		$("#inTime").hide();
		$("#in").show();
		$("#inTime").val("00:00");
		$("#outTime").hide();
		$("#out").show();
		$("#outTime").val("00:00");
		$("#membersNameAutocomplete").val("");
		$("#contactNo").val("");
	};
</script>







<%-- <%@taglib uri="/struts-tags" prefix="s"%>

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


<div class="span3"  style="position:fixed; top:100px; left:0px; color:#000; font-size:14px;">
	<div class="click_notification_header" id="1">
		<span class="required"><s:property value="%{pendingFeesList.size()}"/></span> Pending Fees
	</div><br/>
	 <div class="notification_header" id="2"> 
		<span class="required"><s:property value="%{(reNewBeforList.size())+(reNewAfterList.size())}" /></span> Re-New 
	</div><br/>
	<div class="notification_header" id="3">
		<span class="required"><s:property value="%{birthDayList.size()}" /></span> BirthDay&nbsp;Today
	</div><br/>
	<div class="notification_header" id="7">
		<span class="required"><s:property value="%{birthDayList.size()}" /></span> Anniversary&nbsp;Today
	</div><br/>
	<div class="notification_header" id="4"> 
		<span class="required"><s:property value="%{attendanceList.size()}" /></span> Attendance
	</div><br/>
	
	<div class="notification_header" id="5"> 
		<span class="required"><s:property value="%{appointmentList.size()}" /></span> Today Appointment
	</div><br/>
	
	<div class="notification_header" id="6"> 
		<span class="required"><s:property value="%{enquirytList.size()}" /></span> Enquiry 
	</div><br/>
</div>

</body> --%>