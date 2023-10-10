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
	/* background: rgba(0,0,0,0.2); */
}

#contain {
	margin: 0;
	position: fixed;
	top:100px;
	left:20px;
}

.accordion,.accordion div,.accordion h1,.accordion p,.accordion a,.accordion img,.accordion span,.accordion em,.accordion ul,.accordion li {
	margin: 0;
	padding: 0;
	border: none;
}

/* Accordion Layout Styles */
.accordion {
	width: 200px;
	padding: 1px 5px 5px 5px;
	background: #141517;

	-webkit-box-shadow: 0px 1px 0px rgba(255,255,255, .05);
	-moz-box-shadow: 0px 1px 0px rgba(255,255,255, .05);
	box-shadow: 0px 1px 0px rgba(255,255,255, .05);

	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
}

.accordion .tab {
	display: block;
	height: 35px;
	margin-top: 4px;
	padding-left: 20px;
	font: bold 12px/35px Arial, sans-serif;
	text-decoration: none;
	color: #eee;
	text-shadow: 1px 1px 0px rgba(0,0,0, .2);

	-webkit-border-radius: 2px;
	-moz-border-radius: 2px;
	border-radius: 2px;
	background: #6c6e74; /* Old browsers */
background: -webkit-linear-gradient(top, #6c6e74 0%, #4b4d51 100%);

	background: -moz-linear-gradient(top, #6c6e74 0%, #4b4d51 100%);
	background: -o-linear-gradient(top, #6c6e74 0%, #4b4d51 100%);
	background: -ms-linear-gradient(top, #6c6e74 0%, #4b4d51 100%);
	background: linear-gradient(top, #6c6e74 0%, #4b4d51 100%); /* W3C */

-webkit-box-shadow: 0px 1px 0px rgba(0,0,0, .1), inset 0px 1px 0px rgba(255,255,255, .1);
	-moz-box-shadow: 0px 1px 0px rgba(0,0,0, .1), inset 0px 1px 0px rgba(255,255,255, .1);
	box-shadow: 0px 1px 0px rgba(0,0,0, .1), inset 0px 1px 0px rgba(255,255,255, .1);
}

.accordion .tab:hover,.accordion div:target .tab {
	color: #2b3b06;
	text-shadow: 0px 1px 0px rgba(255,255,255, .15);
	background: #a5cd4e; /* Old browsers */
background: -webkit-linear-gradient(top, #a5cd4e 0%, #6b8f1a 100%);

	background: -moz-linear-gradient(top, #a5cd4e 0%, #6b8f1a 100%);
	background: -o-linear-gradient(top, #a5cd4e 0%, #6b8f1a 100%);
	background: -ms-linear-gradient(top, #a5cd4e 0%, #6b8f1a 100%);
	background: linear-gradient(top, #a5cd4e 0%, #6b8f1a 100%); /* W3C */

-webkit-box-shadow: 1px 1px 1px rgba(0,0,0, .3), inset 1px 1px 1px rgba(255,255,255, .45);
	-moz-box-shadow: 1px 1px 1px rgba(0,0,0, .3), inset 1px 1px 1px rgba(255,255,255, .45);
	box-shadow: 1px 1px 1px rgba(0,0,0, .3), inset 1px 1px 1px rgba(255,255,255, .45);
}

.accordion div .content {
	display: none;
	margin: 5px 0;
}

.accordion div:target .content {
	display: block;
}

.accordion > div {
	height: 40px;
	overflow: hidden;

	-webkit-transition: all .3s ease-in-out;
	-moz-transition: all .3s ease-in-out;
	-o-transition: all .3s ease-in-out;
	-ms-transition: all .3s ease-in-out;
	transition: all .3s ease-in-out;
}

.accordion > div:target {
	height: 360px;
}

/* Accordion Content Styles */
.accordion .content h1 {
	color: white;
	font: 18px/32px Arial, sans-serif;
}

.accordion .content p {
	margin: 10px 0;
	color: white;
	font: 11px/16px Arial, sans-serif;
}

.accordion .content span {
	font: italic 11px/12px Georgia, Arial, sans-serif;
	color: #4f4f4f;
}

.accordion .content em.bullet {
	width: 5px;
	height: 5px;
	margin: 0 5px;
	background: #6b8f1a;
	display: inline-block;

	-webkit-box-shadow: inset 1px 1px 1px rgba(255,255,255, 0.4);
	-moz-box-shadow: inset 1px 1px 1px rgba(255,255,255, 0.4);
	box-shadow: inset 1px 1px 1px rgba(255,255,255, 0.4);

	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
}

.accordion .content ul li {
	list-style: none;
	float: left;
	margin: 5px 10px 5px 0;
}

.accordion .content img {
	-webkit-box-shadow: 2px 2px 6px rgba(0,0,0, .5);
	-moz-box-shadow: 2px 2px 6px rgba(0,0,0, .5);
	box-shadow: 2px 2px 6px rgba(0,0,0, .5);
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
	<div id="contain">
	<div class="accordion">
		<div id="PendingFee">
			<a href="#PendingFee" class="tab"><span class="required"><s:property value="%{pendingFeesList.size()}"/></span> Pending Fees</a>
			<div class="content">
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
		</div>
		</div>
		
		
		<div id="Enquiry"> 
			<a href="#Enquiry" class="tab"><span class="required"><s:property value="%{enquirytList.size()}" /></span> Enquiry</a> 
			<div class="content">
				<b style="color:#fff;">Hello You have <span class="required"><s:property value="%{enquirytList.size()}" /></span> Enquiry.</b>
			</div>
		</div>
		
		<div id="Bde"> 
			<a href="#Bde" class="tab"><span class="required"><s:property value="%{birthDayList.size()}" /></span> BirthDay Today</a> 
			<div class="content">
				<b style="color:#fff;">Hello You have <span class="required"><s:property value="%{birthDayList.size()}" /></span> BirthDay Today.</b>
			</div>
		</div>
		
		<div id="Anniversry"> 
			<a href="#Anniversry" class="tab"><span class="required"><s:property value="%{birthDayList.size()}" /></span> Anniversary Today</a> 
			<div class="content">
				<b style="color:#fff;">Hello You have<span class="required"><s:property value="%{birthDayList.size()}" /></span> Anniversary Today.</b>
			</div>
		</div>
				
		<div id="Attendence"> 
			<a href="#Attendence" class="tab"><span class="required"><s:property value="%{attendanceList.size()}" /></span> Attendance</a> 
			<div class="content">
				<b style="color:#fff;">Hello You have <span class="required"><s:property value="%{attendanceList.size()}" /></span> Attendance.</b>
			</div>
		</div>
		
		
		</div>
		</div>
	</div>
	</div>
<!-- </div>	 -->
</body>