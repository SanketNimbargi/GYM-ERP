<%@ taglib uri="/struts-tags" prefix="s"%>
<head>
<%-- <link href="<%=request.getContextPath()%>/css/tabmenu.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/js/tabmenu.js" type="text/javascript"></script> --%>
</head>
<script type="text/javascript">
$("#document").ready(function(){ 
	$(".denied").click(function(){
		alertMsg("You are not authenticate User. Please contact Admin.");
	});
});
	function activeMenu(id){
		//$(this).closest('ul').attr('id')	
		var id = $(id).parent().attr('id');			
		var activeId= $('.active').attr('id');
		$('#'+activeId).attr('class','');
		$('#'+id).attr('class','active'); 
	 }

</script>
<body>

<div id="menu" style="margin:0; flaot:left; clear:both;"> 
<ul id="tabmenu">
<!-- ================================================================== -->
<li id="1"><a href="home">Home</a><ul><li></li></ul></li>
<!-- ================================================================== -->
<s:if test="%{#session.userType=='Admin'}">
		<li id="a2"><a href="createUser">Register New User</a>
		<li id="a3">
		<a href="javascript:void(0);" onclick="activeMenu(this);">BackUp and Restore</a>			
			<!-- <a>BackUp and Restore</a> -->
			<ul>
				<li><a href="backup">BackUp</a></li>
				<li><a href="restore">Restore</a></li>
				</ul>
		</li>
</s:if>

<!-- <li><a href="gymHome" onclick="activeMenu(this);">Notification</a><ul><li></li></ul></li> -->
<!-- ================================================================== -->
<s:if test="%{#session.Enquiry=='Enquiry' || #session.userType=='Admin'}">
<li id="2"><a href="javascript:void(0);" onclick="activeMenu(this);">Enquiry</a>

<ul>
<li style="margin-left:-650px;"><a href="fitnessgoal">Fitness Goal</a></li>
<li><a href="enquiry" target="_blank">Enquiry</a></li>
<li><a href="enquiryUpdate">Re-Enquiry</a></li>
<li><a href="appointment">Appointment</a></li>
<li><a href="EnquiryBetweenDateReport" target="_blank">Enquiry Between Date</a></li>
<li><a href="EnquiryByOneDateReport" target="_blank">Enquiry By One Date</a></li>
</ul>
</li>
</s:if>
<s:else>
	<li id="2" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Enquiry</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Personal Trainer']=='Personal Trainer'  || #session.userType=='Admin'}">
<li id="3"><a href="javascript:void(0);" onclick="activeMenu(this);">Personal Trainer</a>
 <ul>
<li style="margin-left:-500px;"><a href="personalTrainerRegistration">Registration</a></li>
<li><a href="personalTrainerUpdate">Update</a></li>
<li><a href="personalTrainerRemove">Remove</a></li>
<li><a href="personalTrainerReNew">Re-New</a></li>
<li><a href="personalTrainerDetailsByDate" target="_blank">Details&nbsp;Between&nbsp;Date</a></li>
<li><a href="printPTDetailsAll" target="_blank">All&nbsp;Details</a></li>
<!-- <li><a href="personalTrainerWiseMember" target="_blank">Personal Trainer Wise Member</a></li>
 --> </ul>
</li>
</s:if>
<s:else>
<li id="3" class="denied"><a href="javascript:void(0);"  onclick="activeMenu(this);">Personal Trainer</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Member Registration']=='Member Registration'  || #session.userType=='Admin'}">
<li id="4"><a href="javascript:void(0);" onclick="activeMenu(this);">Member Registration</a>
<ul>
<li><a href="memberRegistration" target="_blank">Registration</a></li>
<li><a href="updateMemberRegistration">Update</a></li>
<li><a href="cancelMember">Cancel</a></li>
<li><a href="reJoinMember">Re-Join</a></li>
<li><a href="searchMember">Search By Contact</a></li>
<li><a href="memberMedicalHistory">Medical</a></li>  
<li><a href="memberDetailsByPackage" target="_blank">Details By Package</a></li>
<li><a href="totalMemberDetails" target="_blank">Total Details</a></li>
<li><a href="totalMemberDetailsWithPayment" target="_blank">Total Details With Payment</a></li>
<li><a href="memberRegistrationDetailsByDate" target="_blank">Details B/W Package</a></li>
<li><a href="memberRegistrationDetailsByGender" target="_blank">Registration By Gender</a></li>
<li><a href="memberToPersonalTrainer" target="_blank">Assigned PT to Member</a></li>
<li><a href="memberDetailsByPackageAndLedger" target="_blank">Details By Package And Ledger</a></li>
<li><a href="memberExpiryReport">Member Expiry Report </a></li>
<li><a href="birthdayBetweenDate">Birthday Between Date </a></li>
<li><a href="anniversaryBetweenDate">Anniversary Between Date </a></li>
<li><a href="memberBodyDetailsOpen">memberBodyDetails</a></li>
<li><a href="memberBodyDetailsReport">memberBodyDetailsReport</a></li>
<li><a href="printMemberTransformationDetails" target="_blank">Membership Transformation Report</a></li>
</ul>
</li>
</s:if>
<s:else>
<li id="4" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Member Registration</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Account']=='Account'  || #session.userType=='Admin'}">
<li id="5"><a href="javascript:void(0);" onclick="activeMenu(this);">Account</a>
<ul>
<li><a href="openMakePayment" target="_blank">Make Payment</a></li>
<li><a href="openUpdateTaxWindow">Update Tax</a></li>
<li><a href="openUpdateRegistrationFee">Update Registration Fee</a></li>
 <li><a href="openMakePaymentUpdate" target="_blank" >Update Payment</a></li> 
<li><a href="receiptByReceiptId" target="_blank">Fee Receipt By Member Id</a></li>
<li><a href="assignPackageFees"> Assign Package Fees</a></li>
<li><a href="ledgerMaster">Ledger Master</a></li>
<li><a href="packageMonth">Package Month</a></li>

</ul>
</li>
</s:if>
<s:else>
	<li id="5" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Account</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Report']=='Report'  || #session.userType=='Admin'}">
<li id="6"><a href="javascript:void(0);" onclick="activeMenu(this);">Report</a>
<ul>
<!-- <li><a style="margin-left:300px;">&nbsp;</a></li> -->
<li style="margin-left:300px;"><a href="paymentDetailsByoneDate" target="_blank">Payment By One Date</a></li>
<li><a href="paymentDetailsBetweenDate" target="_blank">Payment Between Date </a></li>
<li><a href="packagewisePaymentReport" target="_blank">Packagewise Collection Report</a></li>
<li><a href="totalPendingFees" target="_blank">Pending Fees</a></li>
<li><a href="totalpaymentDetailsById" target="_blank">Payment Details By Id</a></li>
<li><a href="openGymAuditReport" target="_blank">Audit Report</a></li>
<li><a href="openHourTypeReport" target="_blank">HourType Report</a></li>
<li><a href="openRevenueReport" target="_blank">Revenue Report</a></li>
<!-- <li><a href="openPendingFeesOnlyReport" target="_blank">Pending Audit</a></li> -->
<li><a href="paymentUpdateTrack" target="_blank">Payment Update Track</a></li>

</ul>
</li>
</s:if>
<s:else>
	<li id="6" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Report</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Attendance']=='Attendance'  || #session.userType=='Admin'}">
<li id="7"><a href="javascript:void(0);" onclick="activeMenu(this);">Attendance</a>
<ul>
<!-- <li><a style="margin-left:425px;">&nbsp;</a></li> -->
<!-- <li style="margin-left:450px;"><a href="attendance">Attendance</a></li> -->
<li><a href="attendanceListBetweenDate" target="_blank">List Between Date</a></li>
<li><a href="attendanceListByDate" target="_blank">List By Date</a></li>
<li><a href="attendanceListByDateandId" target="_blank">Member Attendance By Date And Id </a></li>
<li><a href="ptAttendanceListByDateAndId" target="_blank">Personal Trainer Attendance By Date And Id</a></li>
</ul>
</li>
</s:if>
<s:else>
	<li id="7" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Attendance</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Expenses']=='Expenses'  || #session.userType=='Admin'}">
<li id="8"><a href="javascript:void(0);" onclick="activeMenu(this);">Expenses</a>
<ul><!-- 
<li><a style="margin-left:550px;">&nbsp;</a></li> -->
<li  style="margin-left:500px;"><a href="expenseMaster">Expenses Master</a></li>
<li><a href="expenseDetailsByDate" target="_blank">Details Between Date</a></li>
<li><a href="expenseDetailsByoneDate" target="_blank">Details By Single Date</a></li>
<li><a href="openBankJournalDetails">Bank Master</a></li>
<li><a href="DebitAmountReportByDate"  target="_blank">Debited Amount By Date</a></li>
<li><a href="CreditAmountReportByDate"  target="_blank">Credited Amount By Date</a></li>
</ul>
</li>
</s:if>
<s:else>
	<li id="8" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Expenses</a></li>
</s:else>
<!-- ================================================================== -->
<s:if test="%{#session['Message & Email']=='Message & Email'  || #session.userType=='Admin'}">
<li id="9"><a href="javascript:void(0);" onclick="activeMenu(this);">Message &amp; Email</a>
<ul><!-- 
<li><a style="margin-left:550px;">&nbsp;</a></li> -->
<li  style="margin-left:600px;"><a href="configureConnection" style="display:none;">Configure Connection</a></li>
<li><a href="sendMessageToMember"> Send Message To Member </a></li>
<li><a href="openEmailSetting">Update Email Setting</a></li> 
<li><a href="openSendEmailToMemberAction">Send Email To Member</a></li> 
</ul>
</li>
</s:if>
<s:else>
	<li id="9" class="denied"><a href="javascript:void(0);" onclick="activeMenu(this);">Message &amp; Email</a></li>
</s:else>
  <li><div style="color: red"><%= session.getAttribute("SMSCount") %></div></li>
 <!-- ================================================================== -->
<li><a href="uploadData">Upload Data</a></li>
</ul>
</div>
</body>

