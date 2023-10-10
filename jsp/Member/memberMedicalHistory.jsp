<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Pranjali Deshmukh
	 Date: 29/09/2014
	 Purpose:Enquiry Details
-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>member medical history</title>
<script type="text/javascript">
$("#document").ready(function() {
	$("#medicalHistory").validate({
		debug:true,
		rules:{
			"displayMemberId":{required:true, checkMemberId:true},
			"qno1":{required:true},
			"qno2":{required:true},
			"qno3":{required:true},
			"qno4":{required:true},
			"qno5":{required:true},
			"qno6":{required:true},
			"qno7":{required:true},
			"qno8":{required:true},
			"qno9":{required:true},
			"qno10":{required:true},
			"qno11":{required:true},
			"qno12":{required:true},
			"qno13":{required:true},
			"qno14":{required:true},
			"qno15":{required:true},
		},
		
	messages:{
		"displayMemberId":{required:"Enter member id"},
		"qno1":{required:"Select atleast one"},
		"qno2":{required:"Select atleast one"},
		"qno3":{required:"Select atleast one"},
		"qno4":{required:"Select atleast one"},
		"qno5":{required:"Select atleast one"},
		"qno6":{required:"Select atleast one"},
		"qno7":{required:"Select atleast one"},
		"qno8":{required:"Select atleast one"},
		"qno9":{required:"Select atleast one"},
		"qno10":{required:"Select atleast one"},
		"qno11":{required:"Select atleast one"},
		"qno12":{required:"Select atleast one"},
		"qno13":{required:"Select atleast one"},
		"qno14":{required:"Select atleast one"},
		"qno15":{required:"Select atleast one"},
		
	},
	submitHandler : function(form) {
		form.submit();
	}
	
	});
	//$('#qno1,#qno2,#qno3,#qno4,#qno5,#qno6,#qno7,#qno8,#qno9,#qno10,#qno11,#qno12,#qno13,#qno14,#qno15').click(function(){
	$('.qno').click(function(){
		
		if($("input:radio[name=qno1]:checked" ).val()=="yes"){
			$("#ans1").show();
		}else{
			$("#ans1").hide();
		}
		if($("input:radio[name=qno2]:checked" ).val()=="yes"){
			$("#ans2").show();
		}else{
			$("#ans2").hide();
		}
		if($("input:radio[name=qno3]:checked" ).val()=="yes"){
			$("#ans3").show();
		}else{
			$("#ans3").hide();
		}
		if($("input:radio[name=qno4]:checked" ).val()=="yes"){
			$("#ans4").show();
		}else{
			$("#ans4").hide();
		}
		if($("input:radio[name=qno5]:checked" ).val()=="yes"){
			$("#ans5").show();
		}else{
			$("#ans5").hide();
		}
		if($("input:radio[name=qno6]:checked" ).val()=="yes"){
			$("#ans6").show();
		}else{
			$("#ans6").hide();
		}
		if($("input:radio[name=qno7]:checked" ).val()=="yes"){
			$("#ans7").show();
		}else{
			$("#ans7").hide();
		}
		if($("input:radio[name=qno8]:checked" ).val()=="yes"){
			$("#ans8").show();
		}else{
			$("#ans8").hide();
		}
		if($("input:radio[name=qno9]:checked" ).val()=="yes"){
			$("#ans9").show();
		}else{
			$("#ans9").hide();
		}
		if($("input:radio[name=qno10]:checked" ).val()=="yes"){
			$("#ans10").show();
		}else{
			$("#ans10").hide();
		}
		if($("input:radio[name=qno11]:checked" ).val()=="yes"){
			$("#ans11").show();
		}else{
			$("#ans11").hide();
		}
		if($("input:radio[name=qno12]:checked" ).val()=="yes"){
			$("#ans12").show();
		}else{
			$("#ans12").hide();
		}
		if($("input:radio[name=qno13]:checked" ).val()=="yes"){
			$("#ans13").show();
		}else{
			$("#ans13").hide();
		}
		if($("input:radio[name=qno14]:checked" ).val()=="yes"){
			$("#ans14").show();
		}else{
			$("#ans14").hide();
		}
		if($("input:radio[name=qno15]:checked" ).val()=="yes"){
			$("#ans15").show();
		}else{
			$("#ans15").hide();
		}		
		
	});
	 $("#displayMemberId").blur(function(){ 
		 var fetchMemberId = $("#displayMemberId").val().substring(1);
			
		 var checkMemberString=$("#displayMemberId").val().substring(0,1);
		//	clearForm(); 
			//alert(fetchMemberId+"hi"+checkMemberString);
		
	   	 if(fetchMemberId > 0 && checkMemberString == 'M')
		{
	   		$("#memberId").val(parseInt(fetchMemberId));
	   		$.getJSON('fetchMemberDetails',{fetchMemberId : fetchMemberId}).done(function(data){
	   			if(data.memberList[0] == undefined)
					$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
				else{
	   			$("#memberId").val(data.memberList[0].memberId);
				$("#firstName").val(data.memberList[0].firstName);
				$("#middleName").val(data.memberList[0].middleName);
				$("#lastName").val(data.memberList[0].lastName);
				$("#address").val(data.memberList[0].address);
				$("#dateOfBirth").val(data.memberList[0].dateOfBirth);
				$("#contactNo").val(data.memberList[0].contactNo);
				$("#height").val(data.memberList[0].height);
				$("#weight").val(data.memberList[0].weight);
				$("#chest").val(data.memberList[0].chest);				
				$("#bicep").val(data.memberList[0].bicep);
				$("#tricep").val(data.memberList[0].tricep);
				//=========================set question and ans====================
					
					
					
				//==================1	
					var id = 1;
					
					if(data.memberList[0].qno1=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans1);
						
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					
					//==================2	
					var id = 2;
					
					if(data.memberList[0].qno2=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans2);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					
					//==================3	
					id = 3;
					if(data.memberList[0].qno3=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans3);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================4	
					id = 4;
					if(data.memberList[0].qno4=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans4);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================5	
					id = 5;
					if(data.memberList[0].qno5=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans5);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================6	
					id = 6;
					if(data.memberList[0].qno6=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans6);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================7	
					id = 7;
					if(data.memberList[0].qno7=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans7);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================8	
					id = 8;
					if(data.memberList[0].qno8=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans2);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================9	
					id = 9;
					if(data.memberList[0].qno9=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans9);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================10	
					id = 10;
					if(data.memberList[0].qno10=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans10);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================11	
					id = 11;
					if(data.memberList[0].qno11=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans11);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================12	
					id = 12;
					if(data.memberList[0].qno12=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans12);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================13	
					id = 13;
					if(data.memberList[0].qno13=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans13);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================14	
					id = 14;
					if(data.memberList[0].qno14=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans14);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					//==================15	
					id = 15;
					if(data.memberList[0].qno15=="yes"){
						$("#qno"+id).attr("checked",true);
						$("#ans"+id).show();
						$("#ans"+id).val(data.memberList[0].ans15);
					}else{
						$("#qNo"+id).attr("checked",true);
						$("#ans"+id).hide();
					}
					
			}
			
					
				
	   	})
				.fail(function(jqxhr, textStatus, error) {
					$("#message").text("Error While Fetching. Please Try Again...").show();
				});
		 
		}
		  else{
			  $("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
		  }
			 
		  });
		 
});
</script>
</head>
<body>
	<s:form id="medicalHistory" theme="css_xhtml" name="enquiry">
		<!-- 	<div style="width: 90%;"> -->
	<div style="width: 90%;margin-left: 5%;">
			<fieldset>
				<legend>Member Medical History</legend>
				<table>
					<tr>
						<td><label>Member Id<span class="required">*</span></label></td>
						<td><label>Name<span class="required"></span></label></td>

					</tr>
					<tr>
						<td><s:hidden name="memberRegistrationModel.memberId" id="memberId" value="" /> 
						<s:textfield
								name="displayMemberId" id="displayMemberId" value=""
								onkeyup="upperCase(this);"  placeholder="M1" /></td>
						<td><s:textfield name="firstName" id="firstName"
								readonly="true"></s:textfield></td>
						<td><s:textfield name="middleName" id="middleName"
								readonly="true"></s:textfield></td>
						<td><s:textfield name="lastName" id="lastName"
								readonly="true"></s:textfield></td>
					</tr>
					<tr>
						<td><label>Address<span class="required"></span></label></td>
						<td><label>Date of Birth<span class="required"></span></label></td>
						<td><label>Contact No.<span class="required"></span></label></td>
					</tr>
					<tr>
						<td><s:textfield name="address" id="address" readonly="true"></s:textfield></td>
						<td><s:textfield name="dateOfBirth" id="dateOfBirth"
								readonly="true"></s:textfield></td>
						<td><s:textfield name="contactNo" id="contactNo"
								readonly="true"></s:textfield></td>
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
								cssStyle="width:90px;" value="" readonly="true" /></td>
						<td><s:textfield name="weight" id="weight"
								cssStyle="width:90px;" value="" readonly="true" /></td>
						<td><s:textfield name="chest" id="chest"
								cssStyle="width:90px;" value="" readonly="true" /></td>
						<td><s:textfield name="bicep" id="bicep"
								cssStyle="width:90px;" value="" readonly="true" /></td>
						<td><s:textfield name="tricep" id="tricep"
								cssStyle="width:90px;" value="" readonly="true" /></td>
					</tr>
				</table>
			</fieldset>

			<fieldset>

				<legend></legend>
				<table class="display" style="margin-left: 0;">

					<p>Do you now have or have you ever had any of the
						following(check those that apply)</p>
					<br>
					<tr>
						<td><label>Recent illness or hospitalization<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" class="qno" name="qno1" id="qno1" value="yes">Yes</td>
						<td><input type="radio" class="qno" class="qno" name="qno1"  id="qNo1" value="no">No</td> 
						 
					<tr>
						<td><s:textarea name="ans1" id="ans1"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>ANY type of heart problem<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno2" id="qno2" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno2" id="qNo2" value="no">No</td>
					<tr>
						<td><s:textarea name="ans2" id="ans2"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Abnormal blood counts<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno3" id="qno3" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno3" id="qNo3" value="no">No</td>
					<tr>
						<td><s:textarea name="ans3" id="ans3"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Family history of heart disease<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno4" id="qno4" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno4" id="qNo4" value="no">No</td>
					<tr>
						<td><s:textarea name="ans4" id="ans4"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Diabetes<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno5" id="qno5" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno5" id="qNo5" value="no">No</td>
					<tr>
						<td><s:textarea name="ans5" id="ans5"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>High blood pressure<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno6" id="qno6" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno6" id="qNo6" value="no">No</td>
					<tr>
						<td><s:textarea name="ans6" id="ans6"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Stroke<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno7" id="qno7" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno7" id="qNo7" value="no">No</td>
					<tr>
						<td><s:textarea name="ans7" class="qno" id="ans7"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Light headedness or fainting<span
								class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno8" id="qno8" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno8" id="qNo8" value="no">No</td>
					<tr>
						<td><s:textarea name="ans8" id="ans8"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Chest pain<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno9" id="qno9" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno9" id="qNo9" value="no">No</td>
					<tr>
						<td><s:textarea name="ans9" id="ans9"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Shortness of breath<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno10" id="qno10" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno10" id="qNo10" value="no">No</td>
					<tr>
						<td><s:textarea name="ans10" id="ans10"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Drug allergies<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno11" id="qno11" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno11" id="qNo11" value="no">No</td>
					<tr>
						<td><s:textarea name="ans11" id="ans11"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Physical inactivity for longer than 6
								month<span class="required">*</span>
						</label></td>
						<td><input type="radio" class="qno" name="qno12" id="qno12" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno12" id="qNo12" value="no">No</td>
					<tr>
						<td><s:textarea name="ans12" id="ans12"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Current smoker<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno13" id="qno13" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno13" id="qNo13" value="no">No</td>
					<tr>
						<td><s:textarea name="ans13" id="ans13"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Back pain<span class="required">*</span></label></td>
						<td><input type="radio"  class="qno" name="qno14" id="qno14" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno14" id="qNo14" value="no">No</td>
					<tr>
						<td><s:textarea name="ans14" id="ans14"
								value=" " style="display:none" /></td>
					</tr>
					<tr>
						<td><label>Medical insurance<span class="required">*</span></label></td>
						<td><input type="radio" class="qno" name="qno15" id="qno15" value="yes">Yes</td>
						<td><input type="radio" class="qno" name="qno15" id="qNo15" value="no">No</td>
					<tr>
						<td><s:textarea name="ans15" id="ans15"
								value=" " style="display:none" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<s:submit align="center" action="saveMemberMedicalHistory" id="save"
					value="Save" cssClass="smallBtn" />
			</fieldset>
			<s:token />

		</div>
	</s:form>

</body>
</html>