<head>
<%-- <link href="<%=request.getContextPath()%>/css/tabmenu.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/js/tabmenu.js" type="text/javascript"></script> --%>
</head>
<script type="text/javascript">
	function activeMenu(id){
	/* 	//$(this).closest('ul').attr('id')	
		var id = $(id).parent().attr('id');		
		$('#'+id).attr('class','active'); */
	 }
</script>
<body>
<div id="menu" style="margin:0; flaot:left; clear:both;"> 
<ul id="tabmenu">
<li id="1"><a href="home">Home</a><ul><li></li></ul></li>

<!-- <li><a href="gymHome" onclick="activeMenu(this);">Notification</a><ul><li></li></ul></li> -->
<li id="2"><a href="javascript:void(0);" onclick="activeMenu(this);">Enquiry</a>
<ul>
<li style="margin-left:-650px;"><a href="fitnessgoal">Fitness Goal</a></li>
<li><a href="enquiry" target="_blank">Enquiry</a></li>
<li><a href="enquiryUpdate">Re-Enquiry</a></li>
<li><a href="appointment">Appointment</a></li>
</ul>
</li>
<li id="3"><a href="javascript:void(0);" onclick="activeMenu(this);">Personal Trainer</a>
 <ul>
<li style="margin-left:-500px;"><a href="personalTrainerRegistration">Registration</a></li>
<li><a href="personalTrainerUpdate">Update</a></li>
<li><a href="personalTrainerRemove">Remove</a></li>
<li><a href="personalTrainerReNew">Re-New</a></li>
<li><a href="personalTrainerDetailsByDate" target="_blank">Details&nbsp;Between&nbsp;Date</a></li>
<li><a href="printPTDetailsAll" target="_blank">All&nbsp;Details</a></li>
 </ul>
</li>
<li><a href="javascript:void(0);" onclick="activeMenu(this);">Member Registration</a>
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
</ul>
</li>
<li><a href="javascript:void(0);" onclick="activeMenu(this);">Account</a>
<ul>
<li><a href="openMakePayment" target="_blank">Make Payment</a></li>
<li><a href="openUpdateTaxWindow">Update Tax</a></li>
<li><a href="openUpdateRegistrationFee">Update Registration Fee</a></li>
<li><a href="openMakePaymentUpdate" target="_blank">Update Payment</a></li>
<li><a href="receiptByReceiptId" target="_blank">Fee Receipt By Member Id</a></li>
<li><a href="assignPackageFees"> Assign Package Fees</a></li>
<li><a href="ledgerMaster">Ledger Master</a></li>
<li><a href="packageMonth">Package Month</a></li>
</ul>
</li>
<li><a href="javascript:void(0);" onclick="activeMenu(this);">Report</a>
<ul>
<!-- <li><a style="margin-left:300px;">&nbsp;</a></li> -->
<li style="margin-left:300px;"><a href="paymentDetailsByoneDate" target="_blank">Payment By One Date</a></li>
<li><a href="paymentDetailsBetweenDate" target="_blank">Payment Between Date </a></li>
<li><a href="totalPendingFees" target="_blank">Pending Fees</a></li>
<li><a href="totalpaymentDetailsById" target="_blank">Payment Details By Id</a></li>
<li><a href="openGymAuditReport" target="_blank">Audit Report</a></li>
</ul>
</li>
<li><a href="javascript:void(0);" onclick="activeMenu(this);">Attendance</a>
<ul>
<!-- <li><a style="margin-left:425px;">&nbsp;</a></li> -->
<!-- <li style="margin-left:450px;"><a href="attendance">Attendance</a></li> -->
<li><a href="attendanceListBetweenDate" target="_blank">List Between Date</a></li>
<li><a href="attendanceListByDate" target="_blank">List By Date</a></li>
<li><a href="attendanceListByDateandId" target="_blank">Member Attendance By Date and Id </a></li>
<li><a href="ptAttendanceListByDateAndId" target="_blank">Personal Trainer Attendance By Date And Id</a></li>
</ul>
</li>
<li><a href="javascript:void(0);" onclick="activeMenu(this);">Expenses</a>
<ul><!-- 
<li><a style="margin-left:550px;">&nbsp;</a></li> -->
<li  style="margin-left:600px;"><a href="expenseMaster">Expenses Master</a></li>
<li><a href="expenseDetailsByDate" target="_blank">Details Between Date</a></li>
<li><a href="expenseDetailsByoneDate" target="_blank">Details By Single Date</a></li>
</ul>
</li>
<li><a href="javascript:void(0);" onclick="activeMenu(this);">Message &amp; Email</a>
<ul><!-- 
<li><a style="margin-left:550px;">&nbsp;</a></li> -->
<li  style="margin-left:600px;"><a href="configureConnection">Configure Connection</a></li>
<li><a href="sendMessageToMember"> Send Message To Member </a></li>
<li><a href="openEmailSetting">Update Email Setting</a></li> 
<li><a href="openSendEmailToMemberAction">Send Email To Member</a></li> 
</ul>
</li>
</ul>
</div>
</body>