<%@taglib uri="/struts-tags" prefix="s"%>
 
<head>
<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/jquery-ui.js"></script>
<!-- This Java Script should be used for TTS. Text To Speech-->
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/tts/speakClient.js"></script> --%>

<style>

body {
	font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
	font-size: 62.5%;
}
</style>

<style type="text/css">
.topClass{
	margin: 0;
}
.labelClass{
font-size: 15px;
font-family: Verdana;
}
#notificationLists {
	width:160px;
    height: 450px;
    margin-left: 5px;
    float: left;
    overflow: auto;
    overflow-x: hidden;
    
}
 #toggle {
  /*   width: 100px;
    height: 100px;
    background: #ccc; */ 
  }
 #bgImg{
   width:100%;
   height:100%;  /*height of your image*/
   //background-image:url('') ;  
   //background-repeat: no-repeat;
   //background-position: center;
   //background-attachment:fixed;
   //background-size: cover;
   margin: 0px 0px 0px 0px;  /* If you want no margin */
   padding:0;
   text-align: center; 
}

</style>

</head>
<body>
<img src="<%=application.getAttribute("home_bg")%>" id="bgImg" />
		<!-- Working -->				
 <!-- <div>
		<fieldset id="fieldset1"><legend>Daily Attendance</legend>
		<div style="width: 100%;">	
		<table>
		<tr><td>Member Id <input type="hidden" name="memberId" id="memberId" value="" /><input type="hidden" name="attendanceId" id="attendanceId" value="" /></td>
		<td><input type="text" name="displayMemberId" id="displayNotificationMemberId" placeholder="" onkeyup="upperCase(this); " tabindex="0" /></td>
		<td>Member Name <input type="text" id="membersNameAutocompleteNotification" name="membersNameAutocomplete" placeholder="First Name Middle Name Last Name" style="width:250px;" /></td>
		<td>Contact No.<input type="text" name="contactNo" id="contactNoNotification"	value="" /></td>
		</tr>
		</table>
        
        <table table class="display" id="attendanceDetails" style="display: none;" border="">
        <tr><td id="image" align="center" rowspan="3"></td><td><label>Member name</label></td><td><label>In Time</label></td>	<td><label>Out Time</label></td></tr>
		 <tr id="tr"><td><label id="memberName"></label></td>
						<td><input type="button" id="in" class="mybtn"  tabindex="1" value="In" class="smallBtn"/>
						<input type="text" name="inTime" id="inTime" readonly="true" value="00:00" style="width:80px; display:none;" /></td>
						<td><input type="button" id="out" class="mybtn"  tabindex="2" value="Out" class="smallBtn"/>
						<input type="text" name="outTime" id="outTime" readonly="true" value="00:00" style="width:80px; display:none;" /></td>
					</tr>	
		 </table>
		 </div>
		 </fieldset>
		 
		 <fieldset id="fieldset2" style="display:none;">
		 <div>
		 <table align="left">
			<tr>
			<td><label>Member Id</label></td><td style=" padding-left: 16px;"><label id="memberIdForDisplay"></label></td><td style=" padding-left: 16px;"></tr>
			<td><label>Joining Date</label></td><td style=" padding-left: 16px;"><label id="joiningDate"></label></td><td style=" padding-left: 16px;"><label>Total Fees</label></td><td><label id="totalFees"></label></td></tr>
			<tr><td><label>Due Date</label></td><td style=" padding-left: 16px;"><label id="dueDate"></label></td><td style=" padding-left: 16px;"><label>Paid Fees</label></td><td><label id="paidFees"></label></td></tr>
			<tr><td><label>End Date</label></td><td style=" padding-left: 16px;"><label id="endDate"></label></td><td style=" padding-left: 16px;"><label>Pending Fees</label></td><td><label id="pendingFees" ></label></td>
		<!-- 	<tr><td><input type="button" id="testFing" class="mybtn"  tabindex="4" value="Test Finger Prints" class="smallBtn"/>
					 	<label id="scanMessage"></label></td>
					 	<td> Current Scanned Id <input type="text" id="currentId"/>
					 	
			</tr> --><!--
		 </table>
		 <table id="ledgerPackageDetails">
		 
		 </table>	
	   </div>
		</fieldset>	

</div>
-->	

</body>
<script type="text/javascript">
	//Function to Fetch Members Details On Change of Member Id
	var onMemberIdChange1 = function(){
		
			
		var fDate =  convertToUserDate(today);
		//alert('fDate ' +fDate);
		$("#attendanceDate").text(fDate);
		
		//alert('inside onMemberIdChange1 ');
		$("#errorContainer").empty();
		$('<div class="errors" id="message" style="width: 530px;" style="display:none;"></div>').appendTo($("#errorContainer"));	
		NotificationClearForm();	
		var memberId=$("#displayNotificationMemberId").val();//.substring(1);
		//var checkMemberString=$("#displayNotificationMemberId").val().substring(0,1);		
		if($("#displayNotificationMemberId").val().substring(0,1)=='M'){
			memberId=$("#displayNotificationMemberId").val().substring(1);
			$("#displayNotificationMemberId").val(memberId);
		}
		
		
		if(memberId > 0 )//&& checkMemberString == 'M')
		{
			//alert('memberId > 0');
			$("#scanMessage").hide();
			$("#memberId").val(parseInt(memberId));		
			$.getJSON('fetchMemberAttendance',{memberId : memberId}).done(function(data){		//Json To Fetch Data	
				
				if(data.memberStatusList[0] != undefined){						
					//alert('inside memberStatusList');
					
						if(data.memberStatusList[0].status=="registered" && data.memberDetailsList[0] != undefined){
							
							assignNotificationData(data.memberDetailsList[0],data.attendanceDetailsList[0],data.pendingFeesDetailsList[0],data.fetchLedgerPackageDetails);
							//assignNotificationDataToTable(data.pendingFeesDetailsList[0]);						
							/* if(today > data.memberDetailsList[0].endDate) */
								
							 	if(( (  new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime())/(oneday)) < 0 )
							 	{
							 		//data.pendingFeesDetailsList[0]
							 		/* alert('inside red block.... ');
							 		alert('oneday '+oneday);
							 		alert('end date: '+data.memberDetailsList[0].endDate); */
							 		var t1 = new Date(data.memberDetailsList[0].endDate).getTime();
							 		var t2 = new Date(today).getTime();
							 		var t3 =  new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime();
							 		var t4 =  (  new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime())/(oneday);
							 		/* alert('t1 : '+t1);
							 		alert('t2 : '+t2);
							 		alert('t3 : '+t3);
							 		alert('t4 : '+t4); */
									$("#tr").css("background","linear-gradient(rgb(250, 200, 200), rgb(250, 100, 100))");  //red
								}
							
							 
								 else
								 {
								 	if(( (  new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime())/(oneday)) > 5 )
									/* if(today < data.memberDetailsList[0].endDate) */	{
										$("#tr").css("background", "linear-gradient(rgb(170, 250, 170), rgb(50, 250, 50))"); //green
								 	}
							 		else 
									{ 
										$("#tr").css("background","linear-gradient(rgb(250, 250, 200), rgb(250, 250, 50)");  //yellow
									 }
								
								 }			
								
							/* else if(( (new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime())/(oneday)) <= 5 && ( (new Date(list[0].endDate).getTime() - new Date(today).getTime())/(oneday)) >= 0)
										 $("#tr").css("background","linear-gradient(rgb(250, 250, 200), rgb(250, 250, 50)");  //yellow */
						}else{									
							
							   // assignNotificationData(data.memberDetailsList[0],data.attendanceDetailsList[0],data.pendingFeesDetailsList[0]);
								assignNotificationStatusData(data.memberStatusList[0]);
								$("#message").text("Member has not paid fees.").show();
								$("#displayNotificationMemberId").focus();
							 }	
						
				
				}else{
						$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
					 }
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else{
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. 1,2)").show();
		}
		
		
		//document.getElementById('displayNotificationMemberId').value='';
		var memberIdDisp = $("#displayNotificationMemberId").val();
		memberIdDisp ="M"+memberIdDisp;
		//alert(memberIdDisp);
		 $("#memberIdForDisplay").text(memberIdDisp);
		 
		$("#displayNotificationMemberId").val("");
		$("#displayNotificationMemberId").focus();
		
				
	};
	
	
	
	
</script>

<script type="text/javascript">

var assignNotificationStatusData = function(memberData){
	 var ctx ='<%=request.getContextPath()%>';	
	 $('<img src="'+ctx+'/MemberImages/'+memberData.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" alt="Image Not Added" />').appendTo($("#image"));
		
		$("#membersNameAutocompleteNotification").val(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName); 
		$("#memberName").text(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
		$("#contactNoNotification").val(memberData.contactNo);
};

		var assignNotificationData = function(memberData,attendanceData,pendingFeesDetailsData,fetchLedgerPackageDetails){
			 
			var ctx ='<%=request.getContextPath()%>';
			$("#ledgerPackageDetails").empty(); 
			$("#attendanceDetails").show();
			$("#fieldset2").show();	
			
			 $('<img src="'+ctx+'/MemberImages/'+memberData.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" alt="Image Not Added" />').appendTo($("#image"));
			
			$("#membersNameAutocompleteNotification").val(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName); 
			$("#memberName").text(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
			$("#contactNoNotification").val(memberData.contactNo);
			console.log(fetchLedgerPackageDetails);
			for(i=0;i<fetchLedgerPackageDetails.length;i++)
			{
				
				$('<tr><td><label>ledger Name</label></td><td style=" padding-left: 16px;"><label id="">'+fetchLedgerPackageDetails[i].ledgerName+'</label></td><td style=" padding-left: 16px;"><label>Ledger Fees</label></td><td><label id="">'+fetchLedgerPackageDetails[i].ledgerTotalFees+'</label></td></tr>').appendTo($("#ledgerPackageDetails"));
				$('<tr><td><label>Start Date</label></td><td style=" padding-left: 16px;"><label id="">'+fetchLedgerPackageDetails[i].startDate+' </label></td><td style=" padding-left: 16px;"><label>End Date</label></td><td><label id="" >'+fetchLedgerPackageDetails[i].endDate+'</label></td>').appendTo($("#ledgerPackageDetails"));
			}
				
				//$("#feesName").text(pendingFeesDetailsData.ledgerName);
			$("#joiningDate").text(convertToUserDate(memberData.joiningDate));
			$("#startDate").text(convertToUserDate(memberData.startDate));
			$("#endDate").text(convertToUserDate(pendingFeesDetailsData.endDate));
			$("#dueDate").text(convertToUserDate(pendingFeesDetailsData.dueDate));
			$("#totalFees").text(pendingFeesDetailsData.ledgerTotalFees);
			$("#paidFees").text(pendingFeesDetailsData.ledgerPaidFees);
			$("#pendingFees").text(pendingFeesDetailsData.ledgerPendingFees);
			
			//$("#startDate").text(convertToUserDate(pendingFeesDetailsData.startDate));
			//$("#endDate").text(convertToUserDate(pendingFeesDetailsData.endDate));
		
			

		    if(memberData.status=="registered"){  
			         $("#attendanceDetails").show();
			if(attendanceData != undefined)
			{
							
				if(attendanceData.inTime != null){
					$("#inTime").show();
					$("#in").hide();
					var time24HR = attendanceData.inTime;
					var time12HR = getTimeIn12Hour(time24HR);
					
					$("#inTime").val(time12HR);
				}
				if(attendanceData.outTime != null){
					$("#outTime").show(); 
					$("#out").hide();
					
					var time24HR = attendanceData.outTime;
					var time12HR = getTimeIn12Hour(time24HR);
					$("#outTime").val(time12HR);
				}
				$("#attendanceId").val(attendanceData.attendanceId);
			}				
		    }else{
		    	$("#message").text("Member Id is not currently Registered. He is removed. ").show();
		    }
		    
		    $("#displayNotificationMemberId").focus();
		};	


//Personal Trainer Ready Function
$(document).on('ready readyAgain1', function(){	
	
	$("#errorContainer").empty();
	$("#scanMessage").hide();
	
	//action="saveEsslSettingAction"
	$("#saveEsslSetting").click(function(){					
		$('<div class="errors" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));				
		var esslIP=$("#esslIP").val();
		$("#saveEsslSetting").prop("disabled",true);
		var serverName=$("#serverName").val();
		var portNo=$("#portNo").val();
		var databaseName=$("#databaseName").val();			
		   $.ajax({url: "saveEsslSettingAction",  data:{serverName : serverName , portNo : portNo,databaseName:databaseName,esslIP:esslIP},type: 'GET',/* async: false, */
			   success: function(result,status,xhr){			 
				   //alert("success="+status);
	            },beforeSend:function(xhr){
	            	//$("#wait").css("display", "block");
	            },complete:function(xhr,status){
	            	//$("#wait").css("display", "none");
	            	if(status=="success"){
	            		$("#errorContainer").empty();		            	
	            		$('<div class="welcome" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));
	            		$("#message").text("Detail Saved").show();
	            	}		            		
	            	else{
	            		$("#message").text("Error While Saving. Please Try Again...").show();
	            	}		            		
	            	$("#saveEsslSetting").prop("disabled",false);
	            }
		   
		   }).fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Saving. Please Try Again...").show();
			});
		   
		    
		
		/* $.getJSON('saveEsslSettingAction',{serverName : serverName , portNo : portNo,databaseName:databaseName,esslIP:esslIP}).done(function(data){
			alert("Details Saved..");
			//$(selector).getJSON(url,data,success(data,status,xhr))
			
		})
		.fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Saving. Please Try Again...").show();
		});			
		 	$(document).ajaxStart(function(){
		        $("#wait").css("display", "block");
		    });
		    $(document).ajaxComplete(function(){
		        $("#wait").css("display", "none");
		    }); 			    
		 */
		
	});
	//Autocompleter For Personal Trainer By Contact No
	autoCompletePTNumber("contactNoNotification","displayNotificationPersonalTrainerId",onPersonalTrainerIdChange); 	
	
	/* Edited By Raju Sable */
	//Auto Complete for Search By Member Name
//autoComplete("membersNameAutocomplete1","displayMemberId1",onMemberIdChange);
$("#membersNameAutocomplete1").keyup(function(){			
	homepageAutoComplete("membersNameAutocomplete1","displayMemberId1",onMemberIdChange);
});

// fetch member details
 $("#displayMemberId1").change(function(){
	onMemberIdChange();						//Fetch Members Details On Change of Member Id
}); 

//Auto Complete for Search By number
	$("#contactNo1").keyup(function(){			
		autoCompleteSearchMemberByContact("contactNo1","displayMemberId1",onMemberIdChange);
	});

//On Member Id Change Event get member details, Fees details
$("#displayMemberId1").blur(function(){
		onMemberIdChange();							//Fetch Members Details On Change of Member Id
	});

var onMemberIdChange = function(){
	

	$('<div class="errors" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));
	var fetchMemberId = $("#displayMemberId1").val().substring(1);
	var checkMemberString=$("#displayMemberId1").val().substring(0,1);
	clearForm();
	if(fetchMemberId > 0 && checkMemberString == 'M')
	{
		$("#memberId").val(parseInt(fetchMemberId));
		$.getJSON('fetchMemberDetails',{fetchMemberId : fetchMemberId}).done(function(data){
			
			if(data.memberList[0] == undefined)
				$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
			else
				assignData(data.memberList[0]);
		})
		.fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Fetching. Please Try Again...").show();
		});
	}
	else
		$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
};	

//Clear Form
var clearForm = function() {
	$("#imageMember").remove();
	//$("#message").show();
	$("#update").attr("disabled", true);
	$("#joiningDate").val("");
	$("#lastName").val("");
	$("#firstName").val("");
	$("#middleName").val("");
	$("#gender").val("");
	$("#dateOfBirth").val("");
	$("#address").val("");
	$("#contactNo").val("");
	$("#alternateContactNo").val("");
	$("#emailId").val("");
	$("#height").val("");
	$("#weight").val("");
	$("#chest").val("");
	$("#bicep").val("");
	$("#tricep").val("");
	$("#imageMember").remove();
	$("#memberId").val(0);
	$("#age");
	$("#maritalStatus").val("");
	$("#membersNameAutocomplete").val("");
	$("#anniversaryDate").val("");
};

//Assign Data
var assignData = function(data){
	
	$("#MemberDetailsForm").show();

	$("#message").hide();
	$("#update").attr("disabled",false);
	$("#joiningDate").val(convertToUserDate(data.joiningDate)); 
	$("#lastName").val(data.lastName);
	$("#firstName").val(data.firstName);
	$("#middleName").val(data.middleName);
	$("#gender").val(data.gender);
	$("#dateOfBirth").val(convertToUserDate(data.dateOfBirth));
	$("#address").val(data.address);
	$("#age").val(data.age);
	$("#contactNo").val(data.contactNo);
	$("#dispMemberId").val(data.memberId);
	$("#displayMemberId").val("M"+data.memberId);
	$("#displayMemberId1").val("M"+data.memberId);
	$("#contactNo1").val(data.contactNo);
	$("#memberId").val(data.memberId);
	$("#alternateContactNo").val(data.alternateContactNo);
	$("#emailId").val(data.emailId);
	$("#height").val(data.height);
	$("#weight").val(data.weight);
	$("#chest").val(data.chest);
	$("#bicep").val(data.bicep);	
	$("#maritalStatus").val(data.maritalStatus);
	$('#anniversaryDate').val("");			
	if(data.maritalStatus=="Married"){	
		 $('.annDate').show();
		$("#anniversaryDate").val(convertToUserDate(data.anniversaryDate));		
		$('#anniversaryDate').attr("disabled",false);
	} 	else{
		$("#maritalStatus").val("Unmarried");
		$('#anniversaryDate').attr("disabled",true);
		 $('.annDate').hide();
	}	
	$("#personalTrainerId").val(data.ptNameList);
	$("#tricep").val(data.tricep);
	$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
	$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image" alt="Image Not Added" />');
};


/* Edited by raju to here */
	//Autocompleter Foe Personal Trainer By Names
	$("#personalTrainerNameAutocompleteNotification").keyup(function(){			
		autoCompletePT("personalTrainerNameAutocompleteNotification","displayNotificationPersonalTrainerId",onPersonalTrainerIdChange);
	});
	
	$("#displayNotificationPersonalTrainerId").change(function(){
		
		onPersonalTrainerIdChange();
	});	
	
	//Save Personal Trainer In Time
	/* $("#in").click(function(){
		var now = new Date($.now());
		
		//var inTime = now.getHours()+":"+now.getMinutes();
		var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
		+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());			
		var time12HR = getTimeIn12Hour(time24HR);
		$("#inTime").val(time12HR);
		$("#inTime").show();
		$("#in").hide();
		var personalTrainerId = $("#personalTrainerId").val();
		$.getJSON('savePTInTime', {inTime : time24HR, personalTrainerId : personalTrainerId}).done(function(data){
			$("#attendanceId").val(data.attendanceId);
			$("#txtmessage").text("").hide();
		});
		
	}); */
	
	//Save Personal Trainer Out Time
	$("#out").click(function(){
		
	
		if($("#inTime").val() != "00:00"){
			
		
			$("#txtmessage").text("").hide();
			var now = new Date($.now());
			//var outTime = now.getHours()+":"+now.getMinutes();
			var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
			+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());				
			var time12HR = getTimeIn12Hour(time24HR);
			$("#outTime").val(time12HR);
			$("#outTime").show();
			$("#out").hide();
			var attendanceId = $("#attendanceId").val();
			$.getJSON('savePTOutTime',{outTime : time24HR , attendanceId : attendanceId}).done(function(data){});
		}
		else{
			$("#message").text("Please click on In Time First...").show();
		}
	});
	
	$("#displayNotificationPersonalTrainerId").focus();
	
});//End of Document Ready

setInterval(function(){ $("#displayNotificationMemberId").focus(); }, 3000);

$(document).on('ready readyAgain', function() {			
	
	//====================== For BirthDay ==================================    
		$("#scanMessage").hide();
	
	    $('#hiddenFromDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'				
	      ,onSelect: function(dateText, inst) {
	          $('#fromBD').text(dateText);$('#toBD').text(dateText);
	      },onClose : function(date){
				$("#hiddenToDate").datepicker( "option", "minDate", date );	
				 loadBDList(true);
			}});
	  	
	  	
	  	$('#hiddenToDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate:  0
	      ,onSelect: function(dateText, inst) {
	          $('#toBD').text(dateText);
	      },onClose : function(date){
				///;	
	    	  loadBDList(true);
			}});
	  	
	  	$("#hiddenToDate").prop( "option", $('#hiddenFromDate').val() );	
	  	$('#fromBD').click(function(){
	        $('#hiddenFromDate').datepicker('show');		        
	     });
	  	
	  	$('#toBD').click(function(){
	        $('#hiddenToDate').datepicker('show');		        
	      });	
	  //====================== For BirthDay ==================================    
	//====================== For Anniversary ==================================    
	    $('#hiddenFromAnDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'				
	      ,onSelect: function(dateText, inst) {
	          $('#fromAnD').text(dateText);$('#toAnD').text(dateText);
	      },onClose : function(date){
				$("#hiddenToAnDate").datepicker( "option", "minDate", date );	
				 loadAnList(true);
			}});
	  	
	  	
	  	$('#hiddenToAnDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate:  0
	      ,onSelect: function(dateText, inst) {
	          $('#toAnD').text(dateText);
	      },onClose : function(date){
				///;	
	    	  loadAnList(true);
			}});
	  	
	  	$("#hiddenToAnDate").prop( "option", $('#hiddenFromAnDate').val() );	
	  	$('#fromAnD').click(function(){
	        $('#hiddenFromAnDate').datepicker('show');		        
	     });
	  	
	  	$('#toAnD').click(function(){
	        $('#hiddenToAnDate').datepicker('show');		        
	      });	
	  //====================== For Anniversary ================================== 	  
		//====================== For Renew Package By date ==================================    
	    $('#hiddenFromReNewDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'				
	      ,onSelect: function(dateText, inst) {
	          $('#fromReNewD').text(dateText);$('#toReNewD').text(dateText);
	      },onClose : function(date){
				$("#hiddenToReNewDate").datepicker( "option", "minDate", date );	
				loadReNewPackageList(true);
			}});
	  	
	  	
	  	$('#hiddenToReNewDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate:  0
	      ,onSelect: function(dateText, inst) {
	          $('#toReNewD').text(dateText);
	      },onClose : function(date){
				///;	
	    	  loadReNewPackageList(true);
			}});
	  	
	  	$("#hiddenToReNewDate").prop( "option", $('#hiddenFromReNewDate').val() );	
	  	$('#fromReNewD').click(function(){
	        $('#hiddenFromReNewDate').datepicker('show');		        
	     });
	  	
	  	$('#toReNewD').click(function(){
	        $('#hiddenToReNewDate').datepicker('show');		        
	      });	
	  //======================  For Renew Package ==================================    
		  
		  
	//Auto Complete for Search By Member Name		
	//autoComplete("membersNameAutocompleteNotification","displayNotificationMemberId",onMemberIdChange1);		
	 //Auto Complete for Search By number
/* 		autoCompleteSearchMember("contactNoNotification","displayNotificationMemberId",onMemberIdChange1);	
*/		 
	$("#membersNameAutocompleteNotification").keyup(function(){			
		//alert('inside membersNameAutocompleteNotification......');
		homepageAutoComplete("membersNameAutocompleteNotification","displayNotificationMemberId",onMemberIdChange1);
	});
	
	// fetch member details
/* 	$("#displayNotificationMemberId").change(function(){
		alert('inside displayNotificationMemberId');
		onMemberIdChange1();						//Fetch Members Details On Change of Member Id
	}); */
	
	//Save In time
	/* $("#in").click(function(){
		var now = new Date($.now());
		
		var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
		+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());
		
		//if(now.getHours()>10) 
		var time12HR = getTimeIn12Hour(time24HR);
		
		$("#inTime").val(time12HR);
		$("#inTime").show();
		$("#in").hide();
		var memberId = $("#memberId").val();
		$.getJSON('saveInTime',{inTime : time24HR , memberId : memberId}).done(function(data){
			$("#attendanceId").val(data.attendanceId);
			$("#txtmessage").text("").hide();
		});
	}); */
	
	//Save Out Time
	$("#out").click(function(){
		
	
		if($("#inTime").val()!="00:00"){
			$("#txtmessage").text("").hide();
			var now = new Date($.now());
		
			//var outTime = now.getHours()+":"+now.getMinutes();
			var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
			+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());
			
			var time12HR = getTimeIn12Hour(time24HR);				
			$("#outTime").val(time12HR);
			$("#outTime").show();
			$("#out").hide();
			var attendanceId = $("#attendanceId").val();
			$.getJSON('saveOutTime',{outTime : time24HR , attendanceId : attendanceId}).done(function(data){});
		}
		else{
			$("#message").text("Please click on In Time First...").show();
		}
	});
	
	//fingerprint Detail/////
	//setInterval(function() {
	//	alert('hi');
  // method to be executed;

	$("#testFing").click(function(){
		$("#scanMessage").hide();
			var memberId = $("#memberId").val();
			//alert('memberId: '+memberId);
			var cId=null;				
		/* 	$.getJSON('matchFingerPrint',{memberId : memberId}).done(function(data){
				
				//alert('member verified...');
				$("#currentId").val(memberId);
				$("#scanMessage").text("Member Verified").show();
				//alert('currentId from folder:'+data[0].currentId);
			}); */
						
			//$("#scanMessage").text("Member Verified").show();
			
			/*	$.each(data.records, function(i, f) {
    		    var id =  f.currentId ;
    		    alert(id);
           		});*/ 
				
			//alert("2: " +memberId);
	});////// end of finger print Detail
	
	//}, 5000);
	
	$("#displayNotificationMemberId").focus();
	
}); //End Of Document ready   


</script type="text/javascript">

<script>
var bindCallbackMethods=function(){
	 $(document).bind("ajaxSend", function(){
		 $("#mainContainer").attr("onclick","return false;");
			$("#wait").css("display", "block");
		}).bind("ajaxComplete", function(){
			$("#wait").css("display", "none");$("#mainContainer").prop("onclick",null);
		}); 
};

var unbindCallbackMethods=function(){
	 $(document).unbind('ajaxComplete').unbind('ajaxSend');  //for chrome
};
bindCallbackMethods();
 	
 	/* $(document).bind("ajaxSend", function(){
	 $("#mainContainer").attr("onclick","return false;");
		$("#wait").css("display", "block");
	}).bind("ajaxComplete", function(){
		$("#wait").css("display", "none");$("#mainContainer").prop("onclick",null);
	}); */

/*  $(document).ajaxStart(function()   { 	
	 $("#mainContainer").attr("onclick","return false;");
	$("#wait").css("display", "block");
	//$("#mainContainer").attr("onclick","return false;");
	
	}); */ 
//$(document).ajaxComplete(function(){ $("#wait").css("display", "none");  });
</script>

<script type="text/javascript">

 $("#displayNotificationMemberId").keydown(function(event){
	if(event.which==13){
		//alert('inside keypress');
		event.preventDefault();
		
		$("#in").click();
		//abc();
		$("#displayNotificationMemberId").focus();
	}
	
}); 

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
today = yyyy+"-"+mm+"-"+dd;

var oneday=1000*60*60*24;
var left=false;
var notificationStatus="hide";
	$("#document").ready(function(){		
		 
		setNotificationLists(notificationStatus); 
		$("#toggle").click(function() {			  
			//notificationStatus=(notificationStatus=="hide")?"show":"hide"; 
			setNotificationLists(notificationStatus); 
		});
		<%--//speak('Hello World! I am very happy. Thank you.',{ pitch: 100,wordgap:15 }); //TTS Method
		//speak('hello Tinaa!', { pitch: 100,wordgap:15 }); //TTS Method --%>
	
    		var setStatusColor=function(status){
    			if(status.substring(0,6)=="online")
    				$("#essl1").css("color","rgb(0, 160, 0)");
    			else
    				$("#essl1").css("color","rgb(255, 0, 0)");
    		};
    		 /*  $.getJSON('fetchAllNotificationList',{})			//Json To Fetch Data
 			.done(function(data)
 			{
 			}); */
 			$("#membersNameAutocomplete").keyup(function(){			
 				autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
 			});
 			$.ajax({url:'fetchAllNotificationList',		//Json To Fetch Data
	    		success:function(data)
			{						
	    			var notificationLists=$("#notificationLists");
					notificationLists.empty();
					var timeAttendence='<%=application.getAttribute("timeAttendence")%>';	
					if(timeAttendence=="true"){
						var status='<%=application.getAttribute("esslDBStatus")%>';						
						$('<div class="notification_header" id="13" onclick="showNotification(this);">Essl status :<span class="required" id="essl1">'+status+'</span> </div>').appendTo(notificationLists);
						setStatusColor(status);
					}	
					$('<div class="notification_header" id="13"><a href="searchMemberDetailsByValues"> Search Member</a></div>').appendTo(notificationLists);
					$('<div class="notification_header" id="1" onclick="showNotification(this);"><span class="required" id="s1">'+data.pendingFeesList.length+'</span> Pending Fees</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="32" onclick="showNotification(this);"><span class="required" id="s32">'+data.pendingFeesRegularFollowUpList.length+'</span> Pending Follow Up</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="11" onclick="showNotification(this);"><span class="required" id="s11">'+data.cancelPendingFeesList.length+'</span> Pending Fees By <br/>Cancel Mem </div>').appendTo(notificationLists);
					$('<div class="notification_header" id="2" onclick="showNotification(this);"><span class="required" id="s2">'+data.reNewList.length+'</span> By Package EndDate</div>').appendTo(notificationLists); /* Re-Join */
					$('<div class="notification_header" id="3" onclick="showNotification(this);"><span class="required" id="s3">'+data.birthDayList.length+'</span> Today\'s BirthDay </div>').appendTo(notificationLists);
					$('<div class="notification_header" id="4" onclick="showNotification(this);"><span class="required" id="s4">'+data.anniversaryDayList.length+'</span> Today\'s Anniversary </div>').appendTo(notificationLists);
					$('<div class="notification_header" id="5" onclick="showNotification(this);"><span class="required" id="s5">'+data.attendanceList.length+'</span> Absent Mem List</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="6" onclick="showNotification(this);"><span class="required" id="s6">'+data.appointmentList.length+'</span> Today\'s Appointment</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="31" onclick="showNotification(this);"><span class="required" id="s31">'+data.regularFollowUpList.length+'</span> Regular Follow Up</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="7" onclick="showNotification(this);"><span class="required" id="s7">'+data.enquirytList.length+'</span> Enquiry Follow Up</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="8" onclick="showNotification(this);"><span class="required" id="s8">'+data.inactiveMemberList.length+'</span> Inactive Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="9" onclick="showNotification(this);"><span class="required" id="s9">'+data.activeMemberList.length+'</span> Active Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="20" onclick="showNotification(this);"><span class="required" id="s20">'+data.cancelMemberList.length+'</span> Canceled Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="30" onclick="showNotification(this);"><span class="required" id="s30">'+data.enquiredMemberList.length+'</span> Enquired Members</div>').appendTo(notificationLists);	
					$('<div class="notification_header" id="10" onclick="showNotification(this);">Member Daily <br /> Attendance</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="12" onclick="showNotification(this);">Personal Trainer <br/> Daily Attendance</div>').appendTo(notificationLists);

					
					//if(timeAttendence=="true")
					$('<div class="notification_header" id="14" onclick="showNotification(this);">Today Overview</div>').appendTo(notificationLists);
					var isTextSMSModuleGiven='<%=(Boolean)application.getAttribute("isTextSMSModuleGiven")%>';		
					if(isTextSMSModuleGiven=="true"){
						$('<div class="notification_header" id="15" onclick="return false;" style="display:none;">SMS Pack:<span class="required" style="color:rgb(0, 160, 0)"  id="smspack">Active</span> </div>').appendTo(notificationLists);

					}else{	
						$('<div class="notification_header" id="15" onclick="contactToActivate();return false;" style="display:none;">SMS Pack:<span class="required" id="smspack">De-Active</span> </div>').appendTo(notificationLists);

					}
					//=================================	
			
			},
			complete:function(xhr,status){
				//$(document).ajaxComplete(function(){ $("#wait").css("display", "none");$("#mainContainer").prop("onclick",null);});
				var timeAttendence='<%=application.getAttribute("timeAttendence")%>';	
				if(timeAttendence=="true"){
						var auto = setInterval(function ()
						     	{ 				
									/* $.getJSON('refreshEsslStatus',{})			//Json To Refresh Data
									.done(function(data)
									{	$("#essl1").text(data.esslStatus); 
										setStatusColor(data.esslStatus);
									});  */	
									
									$.ajax({url:'refreshEsslStatus',global:false,			//Json To Refresh Data
										success:function(data)
										{	$("#essl1").text(data.esslStatus); 
											setStatusColor(data.esslStatus);
										}}); 
									todayOverView();
									
						     	}, 1000 * 2 ); // refresh every 2 sec
				} else{				
					var auto = setInterval(function (){ todayOverView();}, 1500 ); // refresh every 1.5 sec
				}
				var auto = setInterval(function ()
			    {    	
					    	$.ajax({url:'refreshAllNotificationList',global:false,			//Json To Refresh Data
					    		success:function(data)
							{						
								$("#s1").text(data.pendingFeesList.length);
								$("#s11").text(data.cancelPendingFeesList.length);
								$("#s2").text(data.reNewList.length);
								$("#s3").text(data.birthDayList.length);
								$("#s4").text(data.anniversaryDayList.length);
								$("#s5").text(data.attendanceList.length);
								$("#s6").text(data.appointmentList.length);
								$("#s7").text(data.enquirytList.length);
								$("#s8").text(data.inactiveMemberList.length);
								$("#s9").text(data.activeMemberList.length);
								$("#s20").text(data.cancelMemberList.length);

							}}); 		
			     }, 1000 * 60 * 2); // refresh every 2 minute
				
			}}); 
		
			
		
		//Change Pendinding Fees End Date to user format
		$("[id^='dueDate']").show(function(){
			$(this).text("Due Date: "+convertToUserDate($(this).text()));
		});
		//Change Fees End Date to user format
		$("[id^='endDate']").show(function(){
			$(this).text("End Date: "+convertToUserDate($(this).text()));
		});
		//Change Attendance Date to user format 
		/* $("[id^='attendanceDate']").show(function(){
			$(this).text("Last Attended: "+convertToUserDate($(this).text()));
		}); */
		
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
	});
	function contactToActivate(){
			alertMsg("Please! contact to activate SMSPack. Thank You.");
	}
	function setNotificationLists(notificationStatus){			
		  if(notificationStatus=="hide"){				  
		  		$("#toggle").css("background-image","url('<%=request.getContextPath() %>/images/rightToggle.jpg')");		  		
		  }	
		  else{				  
			  $("#toggle").css("background-image","url('<%=request.getContextPath() %>/images/leftToggle.jpg')");
		  }  
		  $("#notificationLists" ).animate({width: notificationStatus},500);
		}
		var fromNotificationClick=false;
		function showNotification(id){
			var divClass = $(id).attr('class');			
			if(divClass == "notification_header"){
				/* var areaId = "#notification_area_"+$(".click_notification_header").attr('id'); */		
				var areaId = "#notification_area_"+$(".notification_header").attr('id');
				$(areaId).hide();
				//$(".click_notification_header").attr('class',"notification_header");
				$(".notification_area").hide();
				//$("#allNotification").hide();				
				$("#notification_area_"+$(id).attr('id')).show('slow');
				//$(this).attr('class','click_notification_header');
				$(".notification_header").css('color','');
				$(id).css('color','blue');
				$("#bodyContainer").hide();
				$(".labelClass").empty();
				$(".areaClass").empty();				
				var id =$(id).attr('id');		
				
				switch(parseInt(id)){
				 case 1:										
					 loadPendingFeesList();
				     break;
				 case 2:
					 loadReNewList();
				        break;
				 case 3:
					 loadBirthDayList();
				        break;
				        
				 case 4:
					 loadAnniversaryDayList();				        
					 break;	 
					 
				 case 5:
					 loadAttendanceList();
				        break;
				 case 6:
					 loadAppointmentList();
				        break;
				 case 7:
					 loadEnquirytList();
				        break;
				 case 8:
					 loadInactiveMemberList();
					 break;
				 case 9:
					 activeMemberList();
					 break;
				 case 10:
					 $("#displayNotificationMemberId").val("");					
					 loadDailyAttendance();
					 NotificationClearForm();
					 //alert("case 10");
					 //onMemberIdChange1();
					 break;
				 case 11:										
					 loadCancelPendingFeesList();
				     break;
				 case 12:
					 $("#displayNotificationPersonalTrainerId").val("");
					 loadDailyPTAttendance();
					 PTNotificationClearForm();
					 break; 
				 case 13:								
					 esslSettingForm();					 
					 break;
				 case 14:								
					// todayOverView();
					fromNotificationClick=true;
					 break;
				 case 20:
					 loadCancelMembersList();
					 break;
				 case 30:
					 showEnquiredMembers();
					 break;
				 case 31:
					 showRegularFollowUps();
					 break;
				 case 32:
					 showRegularPendingFollowUps();
					 break;
				default:
				}
				
			}
			 $(".pending").css("color","linear-gradient(rgb(250, 200, 200), rgb(250, 100, 100))");
			 $(".totalFees").css("color","#990099");
		}
		 function closeAction(id){
			$(".notification_header").css('color','');
			$(".notification_area").hide();
			$("#bodyContainer").show();		
		}

</script>