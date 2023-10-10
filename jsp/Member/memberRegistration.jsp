<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 3/09/2014
	 Purpose: Member Registration
-->
<script type="text/javascript">
function LaunchApp() {
alert('inside launchApp');
Runtime.getRuntime().exec("C:\\GymFingerRegistrationSetup\\Gymfingerregistration.exe", null, new File("C:\\GymFingerRegistrationSetup\\"));
//Runtime.getRuntime().exec("\"C:/GymFingerRegistrationSetup/Gymfingerregistration.exe\"");
//var ws = new ActiveXObject("WScript.Shell");
//ws.Exec("C:\\GymFingerRegistrationSetup\\Gymfingerregistration.exe");
//Process.start("C:\GymFingerRegistrationSetup\Gymfingerregistration.exe");
}
</script>
<script type="text/javascript">
 	$("#document").ready(function() {
		$("#gender").val("Male");
		$("#maritalStatus").val("Unmarried");
		$('#anniversaryDate').val("");
		$('#anniversaryDate').attr("disabled",true);
		
		$(".alreadyEnqDiv").hide();
		$('#enquiryRadioBtn').click(function() {
			   if($('#enquiryRadioBtn').is(':checked')) { 
				   
				   $(".alreadyEnqDiv").show();
				   $("#memberNameAutocomplete").focus();
				}
			   else
				  {
					$(".alreadyEnqDiv").hide();
				  }
			});
		
		//Datepicker 
		$('#joiningDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
			/*  onClose: function( selectedDate ) {				
				$( "#dateOfBirth" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
			}  */
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
			yearRange : '1950:2050',
			dateFormat : 'dd/mm/yy',
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
		//Validation for form
		 $("#memberRegistration").validate({
			debug:true,
			rules:{
				"joiningDate":{required:true ,checkDate:true},
				"lastName":{required:true ,textOnly:true,nameText:true},
				"firstName":{required:true ,textOnly:true,nameText:true},
				"middleName":{textOnly:true,nameText:true},
				"gender":{required:true},
				"dateOfBirth":{/* required:true, */checkDate:true},
				"anniversaryDate":{required:true ,checkDate:true},
				"maritalStatus":{required:true},
				/* "address":{required:true}, */
				"contactNo":{required:true,checkMobilNo:true},
				/* "age":{required:true}, */
				"emailId":{checkMail:true},
			},
			messages:{
				"joiningDate":{required:"Enter Joining Date"},
				"lastName":{required:"Enter Last Name"},
				"firstName":{required:"Enter First Name"},
				"gender":{required:"Select Gender"},
				/* "dateOfBirth":{required:"Enter Date of Birth"}, */
				"anniversaryDate":{required:"Enter Anniversary Date"},
				"maritalStatus":{required:"Enter Marital Status"},
				/* "address":{required:"Enter Residential Address"}, */
				"contactNo":{required:"Enter Contact No."},
			/* 	"age":{required:"Enter Age"}, */
				
			},
			submitHandler:function(form){				
				form.submit();
			}
		});  
		
		 $('.history').click(function(){
			 if($("input:radio[name=history]:checked" ).val()=="yes"){
					$("#displayHistory").show();
				}else{
					$("#displayHistory").hide();
				}
			 
		 });
		
		 $('.qno').click(function(){
				
				if($("input:radio[id=qno1]:checked" ).val()=="yes"){
					$("#ans1").show();
				}else{
					$("#ans1").hide();
				}
				if($("input:radio[id=qno2]:checked" ).val()=="yes"){
					$("#ans2").show();
				}else{
					$("#ans2").hide();
				}
				if($("input:radio[id=qno3]:checked" ).val()=="yes"){
					$("#ans3").show();
				}else{
					$("#ans3").hide();
				}
				if($("input:radio[id=qno4]:checked" ).val()=="yes"){
					$("#ans4").show();
				}else{
					$("#ans4").hide();
				}
				if($("input:radio[id=qno5]:checked" ).val()=="yes"){
					$("#ans5").show();
				}else{
					$("#ans5").hide();
				}
				if($("input:radio[id=qno6]:checked" ).val()=="yes"){
					$("#ans6").show();
				}else{
					$("#ans6").hide();
				}
				if($("input:radio[id=qno7]:checked" ).val()=="yes"){
					$("#ans7").show();
				}else{
					$("#ans7").hide();
				}
				if($("input:radio[id=qno8]:checked" ).val()=="yes"){
					$("#ans8").show();
				}else{
					$("#ans8").hide();
				}
				if($("input:radio[id=qno9]:checked" ).val()=="yes"){
					$("#ans9").show();
				}else{
					$("#ans9").hide();
				}
				if($("input:radio[id=qno10]:checked" ).val()=="yes"){
					$("#ans10").show();
				}else{
					$("#ans10").hide();
				}
				if($("input:radio[id=qno11]:checked" ).val()=="yes"){
					$("#ans11").show();
				}else{
					$("#ans11").hide();
				}
				if($("input:radio[id=qno12]:checked" ).val()=="yes"){
					$("#ans12").show();
				}else{
					$("#ans12").hide();
				}
				if($("input:radio[id=qno13]:checked" ).val()=="yes"){
					$("#ans13").show();
				}else{
					$("#ans13").hide();
				}
				if($("input:radio[id=qno14]:checked" ).val()=="yes"){
					$("#ans14").show();
				}else{
					$("#ans14").hide();
				}
				if($("input:radio[id=qno15]:checked" ).val()=="yes"){
					$("#ans15").show();
				}else{
					$("#ans15").hide();
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
		 
		 
		 $('#maritalStatus').change(function(){
			var status=$(this).val();
			if(status=="Married"){	
				today = new Date();				
				//$('#anniversaryDate').val(today.toString('dd/MM/yyyy'));					
				$('#anniversaryDate').val("");
				$('#anniversaryDate').attr("disabled",false);
				 $('.annDate').show();
			}else{				
				$('#anniversaryDate').val("");
				$('#anniversaryDate').attr("disabled",true);
				$('.annDate').hide();
				
			}
		 });
		 
		 $("#memberNameAutocomplete").keyup(function(){	autoCompleteEnquiry("memberNameAutocomplete","enquiryId",onKeyUp);});
		 
		 $("#address").keyup(function(){autoCompleteAddress("address","address","");});
	});
	function display(){
		$("#imgg").hide();
		$("#userImage").hide();
		$("#videoID").show();
		$("#captureId").show();
	}
	
	function hide(){
		$("#imgg").hide();
		$("#videoID").hide();
		$("#captureId").hide();
	}
	/* var hideRadioRegular = function(){
	
		 $("#regularHour").prop('checked', false);
		
	}
	var hideRadioHappy = function(){
		$("#happyHour").prop('checked', false);
	}	 */	
	
	
	//Autocomple by Member Name
	
	
	var onKeyUp = function(){
		
		var displayEnquiryId = $("#enquiryId").val();
		//alert(displayEnquiryId);
		//alert("displayEnquiryId===="+displayEnquiryId);
		  $.getJSON("fetchrecord",{displayEnquiryId:displayEnquiryId},function(data){
				
			    //$("#enquiryId").val(data.enquiryList[0].displayEnquiryId);
				//$("#enquiryDate").val(convertToUserDate(data.enquiryList[0].enquiryDate));
				$("#memberNameAutocomplete").val(data.enquiryList[0].firstNameEnquiry+" "+data.enquiryList[0].middleNameEnquiry+" "+data.enquiryList[0].lastNameEnquiry);
				//$("#fitnessid").val(data.enquiryList[0].fitnessGoalList);
				$("#firstName").val(data.enquiryList[0].firstNameEnquiry);
				$("#middleName").val(data.enquiryList[0].middleNameEnquiry);
				$("#lastName").val(data.enquiryList[0].lastNameEnquiry);
				$("#gender").val(data.enquiryList[0].genderEnquiry);
				$("#dateOfBirth").val(convertToUserDate(data.enquiryList[0].dateOfBirthEnquiry));
				//$("#feedbackEnquiry").val(data.enquiryList[0].feedbackEnquiry);
				$("#address").val(data.enquiryList[0].addressEnquiry);
				$("#contactNo").val(data.enquiryList[0].contactNoEnquiry);
				$("#alternateContactNo").val(data.enquiryList[0].alternateContactNoEnquiry);
				$("#emailId").val(data.enquiryList[0].emailIdEnquiry);
				//$("#enquirytype").val(data.enquiryList[0].enquirytype);
				//$("#enquiryHandledBy").val(data.enquiryList[0].enquiryHandledBy);
		  }); 
	};
	
	
	</script>
	
	
	<s:form id="memberRegistration" name="memberRegistration" theme="css_xhtml" method="post" enctype="multipart/form-data">
		<div style="width: 90%;">
			<fieldset>
				<legend>Member Information</legend>
				<table>
				<s:hidden id="enquiryId" name="enquiryId" value="%{enquiryId}" />
				
					<tr>
						<td style="margin-left: 20px;"><label>Member Id<span class="required">*</span></label></td>
<!-- 						<td style="width: 250px;"></td>
 -->						  
						<td><label>Joining Date<span class="required">*</span></label></td>
						<td style="width: 160px;"><input type="checkbox" id="enquiryRadioBtn">  Already Enquired? </td>
						<%-- <td><label>Hour Type<span class="required">*</span></label></td> --%>
					</tr>
					<tr>
						<td><s:hidden name="memberId" id="memberId" />
							<s:textfield name="displayMemberId" id="displayMemberId"
								value="%{displayMemberId}" readonly="true" /></td>
					 	<td><s:textfield name="joiningDate" id="joiningDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
						</td>
					 	<td style="width: 160px;" class="alreadyEnqDiv">
							<s:textfield name="memberNameAutoComplete" id="memberNameAutocomplete" 
										 placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" />
						</td> 
						<!-- <td style="width: 160px;"></td> -->
						
						 <!-- <td colspan="2" style="padding-left:20px;">	 -->
						<!--  <td>
						  <input type="radio" name="hourType" id="regularHour" value="Regular Hour" checked="checked" onclick="hideRadioHappy()">Regular Hour		 
						 <input type="radio" name="hourType" id="happyHour" value="Happy Hour" onclick="hideRadioRegular()">Happy Hour
						 </td> --> 
								<!-- <td></td> -->
					</tr>
				</table>
				<hr />
				<table>
					<tr>
						<td><label>Name of Member<span class="required">*</span></label></td>
	
						
						<td><s:textfield name="firstName" id="firstName"
								placeholder="First Name" onkeyup="upperCase(this);" value="%{firstNameEnquiry}"  /></td>
						<td><s:textfield name="middleName" id="middleName"
								placeholder="Middle Name" onkeyup="upperCase(this);" value="%{middleNameEnquiry}" /></td>
						<td><s:textfield name="lastName" id="lastName"
								placeholder="Last Name" onkeyup="upperCase(this);" value="%{lastNameEnquiry}" /></td>
	
						<td align="center" rowspan="4" height="120px;">
							<div ng-controller="UploadController" id="updateImage" style="width: 80px;">
								<!-- <i ng-hide="imageSrc">No image Selected</i> --> 
								<div id="imgg" onclick="display()"><i>Take A Picture</i></div>
								<video id="videoID" autoplay style="width: 90px; height: 90px; display:none;" ></video>
								<input type="button" value="Take Photo" id="captureId" onclick="capture()" style="width: 75px; height: 30px; display: none;" cssClass="smallBtn"/>
								<img ng-src="{{imageSrc}}" width="80" height="90" />
								<s:file ng-file-select="onFileSelect($files)" id="userImage"
									name="userImage" cssStyle="width: 70px; margin:0 auto;" onclick="hide()" />
							</div>
						</td>
						<td align="center" rowspan="4" height="120px;">
							
							<canvas id="canvasID" width="90" height="90" ></canvas>
							<br>&nbsp&nbsp&nbsp&nbsp<input type="button" value="Save" id="save" style="width: 75px; height: 30px; display: none;" onclick="send(); this.disabled=true;return true;" cssClass="smallBtn"/>
						</td>
					</tr>
					<tr>
						<td><label> Gender<span class="required">*</span></label></td>
						<td></td>
						<td><label> Date of Birth<%-- <span class="required">*</span> --%></label></td>
						<td><label> Age <%-- <span class="required">*</span> --%></label></td>
						</tr>
					
					<tr>
						<td><s:select name="gender" id="gender" cssStyle="width:140px;"  headerKey="-1" headerValue="Select Gender" 
							list="#{'Male':'Male','Female':'Female'}" value="%{genderEnquiry}" /></td>
								<td></td>
						<td><s:textfield name="dateOfBirth" id="dateOfBirth" value="" />
						<td><s:textfield name="age" id="age" value="" /></td>
					</tr>
					<tr>
						<td><label>Marital Status<span class="required">*</span></label></td>
						 <td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
						
					</tr>
												
					
					<tr>
					 <td><s:select name="maritalStatus" id="maritalStatus" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" headerKey="" headerValue="Select Marital Status"/>  </td>
					<td class="annDate" style="display:none;">
					<s:textfield name="anniversaryDate" id="anniversaryDate"/>
							
					<%-- <s:textfield name="anniversaryDate" id="anniversaryDate">
					<s:param name="value"> <s:date name="new java.util.Date()" format="dd/MM/yyyy" /></s:param>
					</s:textfield> --%>
					</td>
					 
					</tr>
					
					<tr>
						<td>
						<!--  <a href="file:///C:/GymFingerRegistrationSetup/Gymfingerregistration.exe">Scan Your Finger Print</a></td> -->
						 <a href="javascript:LaunchApp()">Scan your Fingerprint</a>
						<!-- <input type="button" value="Launch Installer" onclick="window.open('file:///C:/GymFingerRegistrationSetup/Gymfingerregistration.exe')" /> -->

						
					</tr>
					
					
					
					
					<tr height="40px;"></tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>Contact Details</legend>
				<table>
					<tr>
						<td><label>Res Address/Pan/Adh Details</label></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td><label>Adhar/Pan No.</label></td>
						<td><label>E-Mail Id</label></td>
					</tr>
					<tr>
						<td><s:textarea name="address" id="address"
								onkeyup="firstCharWordUpper(this);" value="" /></td>
						<td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="%{contactNoEnquiry}" /></td>
						<td valign="top"><s:textfield name="alternateContactNo"
								id="alternateContactNo" value="" /></td>
						<td colspan="2"><s:textfield name="emailId" id="emailId"
								value="%{emailIdEnquiry}" cssStyle="width:180px;"></s:textfield></td>
					</tr>
				</table>
			</fieldset>
				<fieldset>
				<legend>Assign Personal Trainer</legend>
				<table>
					
					<tr>
					<td>Personal Trainer</td>
							<td><s:select id="personalTrainerId" name="ptNameList" headerKey="0" headerValue="Select PT"  cssStyle="width:140px;"
							list="ptNameMap"  value="" /></td>
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
								cssStyle="width:80px;" value="" /></td>
						<td><s:textfield name="weight" id="weight"
								cssStyle="width:80px;" value="" /></td>
						<td><s:textfield name="chest" id="chest"
								cssStyle="width:80px;" value="" /></td>
						<td><s:textfield name="bicep" id="bicep"
								cssStyle="width:80px;" value="" /></td>
						<td><s:textfield name="tricep" id="tricep"
								cssStyle="width:80px;" value="" />
								<s:hidden name="registrationHandledNy" type="hidden"
								cssStyle="width:80px;" value="%{session.userName}"/>
								
								</td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
			<table>
					<tr>
						<td><label>Add Medical History <span
								class="required"></span></label>&nbsp;</td>
						<td><input type="radio"  class="history" name="history" id="hst1" value="yes">Yes</td>&nbsp;
						<td><input type="radio"  class="history" name="history"  id="hst2" value="no" checked="checked">No</td> 				
					</tr>
				</table>
			</fieldset>
			<fieldset style="display:none;" id="displayHistory">
				<legend></legend>
				<table class="display" style="margin-left: 0;">

					<p>Do you now have or have you ever had any of the
						following(check those that apply)</p>
					<br>
					<tr>
						<td><label>Recent illness or hospitalization<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno1" id="qno1" value="yes" >Yes</td>
						<td><input type="radio"  class="qno" name="memberMedicalHistoryModel[0].qno1"  id="qno1" value="no" checked="true">No</td> 
						 
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans1" id="ans1"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>ANY type of heart problem<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno2" id="qno2" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno2" id="qno2" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans2" id="ans2"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Abnormal blood counts<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno3" id="qno3" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno3" id="qno3" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans3" id="ans3"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Family history of heart disease<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno4" id="qno4" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno4" id="qno4" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans4" id="ans4"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Diabetes<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno5" id="qno5" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno5" id="qno5" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans5" id="ans5"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>High blood pressure<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno6" id="qno6" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno6" id="qno6" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans6" id="ans6"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Stroke<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno7" id="qno7" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno7" id="qno7" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans7" class="qno" id="ans7"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Light headedness or fainting<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno8" id="qno8" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno8" id="qno8" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans8" id="ans8"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Chest pain<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno9" id="qno9" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno9" id="qno9" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans9" id="ans9"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Shortness of breath<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno10" id="qno10" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno10" id="qno10" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans10" id="ans10"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Drug allergies<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno11" id="qno11" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno11" id="qno11" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans11" id="ans11"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Physical inactivity for longer than 6
								month<span class="required">*</span>
						</label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno12" id="qno12" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno12" id="qno12" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans12" id="ans12"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Current smoker<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno13" id="qno13" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno13" id="qNo13" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans13" id="ans13"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Back pain<span class="required">*</span></label></td>
						<td><input type="radio"  class="qno" name="memberMedicalHistoryModel[0].qno14" id="qno14" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno14" id="qno14" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans14" id="ans14"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Medical insurance<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno15" id="qno15" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="memberMedicalHistoryModel[0].qno15" id="qno15" value="no" checked="true">No</td>
					<tr>
						<td><s:textarea name="memberMedicalHistoryModel[0].ans15" id="ans15"
								value=" " style="display:none" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<s:submit align="center" action="saveMemberDetails" id="save" value="Save" cssClass="smallBtn" />
			</fieldset>
			<s:token />
		</div>
	</s:form>
	
	<script type="text/javascript"  >
var video = document.getElementById('videoID');
var canvas = document.getElementById('canvasID');
var context = canvas.getContext('2d');

//window.URL = window.URL || window.webkitURL; 
//navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia ||
						 //navigator.mozGetUserMedia || navigator.msGetUserMedia;
						 
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
	$("#imgg").hide();
	$("#save").show();
	context.drawImage(video, 0, 0, canvas.width, canvas.height);
	
};

	function send()
	{ 
		$("#updateImage").hide();
		$("#videoID").hide();
		$("#captureId").hide();
		var imageData = canvas.toDataURL();
		
		var memberId = $("#displayMemberId").val();
		console.log("displayMemberId",memberId);
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.open("saveImage", "<%=request.getContextPath()%>/ImageServlet", true);
		var data = "imageData"+imageData+","+memberId;
		xmlhttp.send(data);
		
	};



</script>