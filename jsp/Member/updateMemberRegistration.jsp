<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 03/09/2014
	 Purpose: Member update
-->

<script type="text/javascript">
var prevAnniversaryDate;
	$("#document").ready(function() {
		//Datepicker
		$('#joiningDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
			/* onClose: function( selectedDate ) { 
				$( "#dateOfBirth" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
			} */
		});
		//Datepicker AnniversaryDate
		$('#anniversaryDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'			
		});
		//Datepicker
		$('#dateOfBirth').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
			maxDate: "-5Y",
				onSelect: function(value, ui) {
					var formate = value.split("/");
			        var today = new Date();
					value=formate[1]+"/"+formate[0]+"/"+formate[2];
			          var  dob = new Date(value);
			            var age = new Date(today - dob).getFullYear() - 1970;
			        $("#age").val(age);
			    },
			  
				
			});
			//Age Calculate
			$("#dateOfBirth").change(function(){
				var formate = this.value.split("/");
		        var today = new Date();
				value=formate[1]+"/"+formate[0]+"/"+formate[2];
		          var  dob = new Date(value);
		            var age = new Date(today - dob).getFullYear() - 1970;
		        $("#age").val(age);
			});
		$('#startDatePT').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'
		});
		//Datepicker
		$('#endDatePT').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'
		});
		//Validation for form
		 $("#updateMemberRegistration").validate({
			debug:true,
			rules:{
				"joiningDate":{required:true ,checkDate:true},
				"memberId":{required:true},
				"lastName":{required:true ,textOnly:true,nameText:true},
				"firstName":{required:true ,textOnly:true,nameText:true},
				"middleName":{textOnly:true,nameText:true},
				"gender":{required:true},
				"dateOfBirth":{/* required:true , */checkDate:true},
				"anniversaryDate":{required:true ,checkDate:true},
				/* "address":{required:true}, */
				"contactNo":{required:true,checkMobilNo:true},
				"emailId":{checkMail:true},
				"maritalStatus":{required:true},
				 
			},
			messages:{
				"joiningDate":{required:"Enter Joining Date"},
				"memberId":{required:" Select Member ID"},
				"lastName":{required:"Enter Last Name"},
				"firstName":{required:"Enter First Name"},
				/* "dateOfBirth":{required:"Enter Date of Birth"}, */
				"anniversaryDate":{required:"Enter Anniversary Date"},
				/* "address":{required:"Enter Residential Address"}, */
				"contactNo":{required:"Enter Contact No."},
				"gender":{required:"Enter Gender"},
				"maritalStatus":{required:"Enter Marital Status"},
				 
			},
			submitHandler:function(form){
				form.submit();
			}
		}); 
		
		//Auto Complete for Search By Member Name
		// autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		$("#membersNameAutocomplete").keyup(function(){			
			autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		});
		$("#address").keyup(function(){autoCompleteAddress("address","address","");});
		////Auto Complete for Search By date of birth
			autoCompleteMemberByDOB("dateOfBirth","displayMemberId",onMemberIdChange);
		
		//Auto Complete for Search By number
		autoCompleteSearchMember("contactNo","displayMemberId",onMemberIdChange);  
		//autoCompleteSearchByNameNumber("membersNameAutocomplete","contactNo","displayMemberId",onMemberIdChange); 
		// fetch member details
		$("#displayMemberId").blur(function(){
			onMemberIdChange();							//Fetch Members Details On Change of Member Id
		});
		
		// onclick function on image
		$("#image").click(function (){
			$("#imageMember").hide();
			$("#updateImage").show();
			$("#imgg").show();
			$("#videoID").hide();
			$("#captureID").hide();
		});
		
		$('#maritalStatus').change(function(){
			var status=$(this).val();
			if(status=="Married"){	
				today = new Date();				
				//$('#anniversaryDate').val(today.toString('dd/MM/yyyy'));	
				$('#anniversaryDate').val(prevAnniversaryDate);
				$('#anniversaryDate').attr("disabled",false);
				 $('.annDate').show();
			}else{
				prevAnniversaryDate=$('#anniversaryDate').val();
				$('#anniversaryDate').val("");
				$('#anniversaryDate').attr("disabled",true);
				$('.annDate').hide();
			}
		 });
		 $('#contactNo').keyup(function(){
			  /* alert($('#contactNo').val().length); */
			  if($('#contactNo').val().length < 10)
				  return;
			  else if($('#contactNo').val().length == 10){
				  $.getJSON("checkContactOfMemberExist",{contactNO:$('#contactNo').val()},function(data){ 
					  if(data.memberNoMap.length >= 1){
						  alert("Member Exist Already! Please Enter Valid Mobile Number");
					  }
					  //console.log(data)
				  });
			  }else if($('#contactNo').val().length > 10){
				  alert("Invalid Contact Number");
			  }
			  
				  
		 });
		 
	}); //End of document.ready
	//Function to Fetch Members Details On Change of Member Id
	var onMemberIdChange = function(){
		$('<div class="errors" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));
		var fetchMemberId = $("#displayMemberId").val().substring(1);
		var checkMemberString=$("#displayMemberId").val().substring(0,1);		
		clearForm();
		if(fetchMemberId > 0 && checkMemberString == 'M')
		{
			$("#memberId").val(parseInt(fetchMemberId));
			$.getJSON('fetchMemberDetails',{fetchMemberId : fetchMemberId}).done(function(data){
				
				if(data.memberList[0] == undefined)
					$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
				else
					assignData(data.memberList[0]);$("#memberIdd").val(fetchMemberId);
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
	};
	
	//Assign Data
	var assignData = function(data){
		//	console.log(data);
		$("#memberIdd").val(data.memberId);
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
	
	function display(){
		$("#image").hide();
		$("#videoID").show();
		$("#captureID").show();
		$("#imgg").hide();
		$("#updateImage").hide();
	}
	
	function hide(){
		$("#imgg").hide();
		$("#videoID").hide();
		$("#captureId").hide();
	}
</script>

<s:head />
</head>
<body>

	<s:form id="updateMemberRegistration" theme="css_xhtml"  method="post" enctype="multipart/form-data">
		<!-- 	<div style="width: 90%;"> -->
	<div style="width: 90%;margin-left: 5%;">
			<fieldset>
				<legend>Update Member Information</legend>

				<table>
					<tr>
					<td style="width: 320px;" colspan="1" >Member Name</td>
						<td style="margin-left: 20px;"><label>Member Id<span
								class="required">*</span></label></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td><label>Date of Birth</label></td>
						
					</tr>
					<tr>
					<td colspan="1"><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><s:hidden name="memberId" id="memberIdd" value="" /> 
						<s:textfield
								name="displayMemberId" id="displayMemberId" value=""
								onkeyup="upperCase(this);"  placeholder="M1" /></td>
							<td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
								<td><s:textfield name="dateOfBirth" id="dateOfBirth" value="" />
						
					</tr>
					<tr> 
					<td><label>Joining Date<span class="required">*</span></label></td>
					<td><label>Membership Transformation?<span class="required"> </span></label></td>
					 </tr>
					<tr><td><s:textfield name="joiningDate" id="joiningDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield></td>
						<td><input type="checkbox" name="transformMember" id="transformMember"> </td>
					</tr>
					 
					 
				</table>
				<hr />
				<table>
					<tr>
						<td><label>Name of Member<span class="required">*</span></label></td>
						
						<td><s:textfield name="firstName" id="firstName"
								placeholder="First Name" onkeyup="upperCase(this);" value="" /></td>
						<td><s:textfield name="middleName" id="middleName"
								placeholder="Middle Name" onkeyup="upperCase(this);" value="" /></td>
						<td><s:textfield name="lastName" id="lastName"
								placeholder="Last Name" onkeyup="upperCase(this);" value="" /></td>

						<td align="center" rowspan="4" height="120px;">
							<div ng-controller="UploadController" id="updateImage" style="width: 100px; display: ;">
								<!-- <i ng-hide="imageSrc">No image Selected</i> -->
								<div id="imgg" onclick="display()"><i>Take A Picture</i></div>
								<img ng-src="{{imageSrc}}" width="80" height="90" />
								<s:file ng-file-select="onFileSelect($files)" id="userImage"
									name="userImage" cssStyle="width: 70px; margin:0 auto;" onclick="hide()"/> 
							</div>
							
							<div id="image" class="gallery-item" style="width: 100px;" onclick="display();"></div>
														
							
						</td>
						<td align="center" rowspan="4" height="120px;">
						<video id="videoID" autoplay style="width: 90px; height: 90px; display: ;"></video>
							<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<input type="button" name="takePhoto" value="Take photo" id="captureID" onclick="capture()" style="width: 70px; height: 30px; display: none;" />
							
						</td>
						<td align="center" rowspan="4" height="120px;">
							
							<canvas id="canvasID" width="90" height="90" style="display: ;"></canvas>
							
							<br>&nbsp&nbsp&nbsp&nbsp<input id="save" name="save" type="button" value="Save" style="width: 70px; height: 30px;" onclick="send()" />
						</td>
					</tr>
					<tr>
						<td><label>Gender<span class="required">*</span></label></td>
						 
							<td><label>Age<%-- <span class="required">*</span> --%></label></td>
							 <td><label>Marital Status<span class="required">*</span></label></td>
					<td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
					
					</tr>
					<tr>
						<td><s:select name="gender" id="gender"
								cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}"  headerKey="" headerValue="Select Gender"/></td>
						
						<td><s:textfield name="age" id="age" value="" /></td>
						<td><s:select name="maritalStatus" id="maritalStatus" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" headerKey="" headerValue="Select Marital Status"/>  </td>
								
						<td class="annDate" style="display:none;"><s:textfield name="anniversaryDate" id="anniversaryDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
					</td>
					<td></td>
						<td></td>
					<td></td>
					</tr>
					<tr height="40px;"></tr>
				</table>
				<hr />
				<table>
					<tr>
						<td><label>Personal Trainer</label></td>
						<td><s:select id="personalTrainerId" name="ptNameList" headerKey="0" 
							headerValue="Select PT" cssStyle="width:140px;" list="ptNameMap" value="" /></td>
					</tr>

				</table>
			</fieldset>
			<fieldset>
				<legend>Contact Details</legend>
				<table>
					<tr>
						<td><label>Residential Address</label></td>
						
						<td><label>Alternate Contact No.</label></td>
						<td><label>E-Mail Id</label></td>
					</tr>
					<tr>
						<td><s:textarea name="address" id="address"
								onkeyup="firstCharWordUpper(this);" value="" /></td>
						
						<td valign="top"><s:textfield name="alternateContactNo"
								id="alternateContactNo" value="" /></td>
						<td colspan="2"><s:textfield name="emailId" id="emailId"
								value="" cssStyle="width:180px;"></s:textfield></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>Physical Details</legend>
				<table style="margin: 0 auto;">
					<tr>
						<td><label>Height </label></td>
						<td><label>Weight</label></td>
						<td><label>Chest</label></td>
						<td><label>Bicep</label></td>
						<td><label>Tricep</label></td>
					</tr>
					<tr>
						<td><s:textfield name="height" id="height"
								cssStyle="width:90px;" value="" /></td>
						<td><s:textfield name="weight" id="weight"
								cssStyle="width:90px;" value="" /></td>
						<td><s:textfield name="chest" id="chest"
								cssStyle="width:90px;" value="" /></td>
						<td><s:textfield name="bicep" id="bicep"
								cssStyle="width:90px;" value="" /></td>
						<td><s:textfield name="tricep" id="tricep"
								cssStyle="width:90px;" value="" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<s:submit align="center" action="updateMemberDetails" id="update" value="Update" cssClass="smallBtn" />
			</fieldset>
			<s:token />
		</div>
	</s:form>
</body>
<script type="text/javascript">
var video = document.getElementById('videoID');
var canvas = document.getElementById('canvasID');
var context = canvas.getContext('2d');

//window.URL = window.URL || window.webkitURL; 
//navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia ||
			//			 navigator.mozGetUserMedia || navigator.msGetUserMedia;
						 
//navigator.getUserMedia({
	//video : true
	//}, 	function(stream) {
		//video.src = window.URL.createObjectURL(stream);
		//}, function(e) { console.log('An error happened:', e); });
		
		
		
const constraints={
				audio:false,
				video:{
					width:canvas.width,height:canvas.height
				}
			};		
		
async function init()
{
	try{
	
		const stream = await navigator.mediaDevices.getUserMedia(constraints);
		handleSuccess(stream);
	
	}catch(e)
	{
		errorMsgElement.innerHtml=`navigator.getUserMedia.error:${e.toString()}`;
	}
}	

function handleSuccess(stream)
{
	window.stream=stream;
	video.srcObject=stream;
	
}
init();
function capture()
{ 
	$("#canvasID").show();
	$("#save").show();
	
	context.drawImage(video, 0, 0, canvas.width, canvas.height);
	
};

	function send()
	{ 
		$("#videoID").hide();
		$("#captureID").hide();
		var imageData = canvas.toDataURL();
		
		var memberId = $("#displayMemberId").val();
		console.log("displayMemberId",memberId);
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("saveImage", "<%=request.getContextPath()%>/ImageServlet", true);
		var data = "imageData"+imageData+","+memberId;
		xmlhttp.send(data);
		
	};



</script>
</html>