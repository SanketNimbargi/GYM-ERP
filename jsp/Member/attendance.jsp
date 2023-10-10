<%@taglib uri="/struts-tags" prefix="s"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>


<!-- Java Script -->

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

<!-- Body starts here -->

</head>
<body>
<!-- 	<div style="width: 90%;"> -->
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
</body>
</html>