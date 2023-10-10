<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 03/09/2014
	 Purpose: Member update
-->

<html ng-app="plunker">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Form</title>
</head>
<script type="text/javascript">

	$("#document").ready(function() {

		//Datepicker AnniversaryDate
		$('#anniversaryDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'			
		});
		
		//Auto Complete for Search By Member Name
		//autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		
		$("#membersNameAutocomplete").keyup(function(){			
			autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		});
		//Auto Complete for Search By number
		autoCompleteSearchMember("contactNo","displayMemberId",onMemberIdChange);
	////Auto Complete for Search By date of birth
		autoCompleteMemberByDOB("dateOfBirth","displayMemberId",onMemberIdChange);
		
		// fetch member details
		$("#displayMemberId").blur(function(){
			onMemberIdChange();							//Fetch Members Details On Change of Member Id
		});
	
		/* $("#cancel").confirm({
			title:"Cancel confirmation",
			text:" Are you really sure to cancel this Members Registration?",
			confirm: function(button) {
				$("#cancelMember").attr('action','cancelMemberDetails').submit();
			},
			
		}); */
		 $('#maritalStatus').change(function(){
				var status=$(this).val();
				if(status=="Married"){	
					today = new Date();				
					//$('#anniversaryDate').val(today.toString('dd/MM/yyyy'));	
					$('#anniversaryDate').val(prevAnniversaryDate);
					$('#anniversaryDate').attr("disabled",false);
					 //$('.annDate').show();
				}else{
					prevAnniversaryDate=$('#anniversaryDate').val();
					$('#anniversaryDate').val("");
					$('#anniversaryDate').attr("disabled",true);
					//$('.annDate').hide();
				}
			 });

	});
	
	//Function to Fetch Members Details On Change of Member Id
	var onMemberIdChange = function(){
		var fetchMemberId=$("#displayMemberId").val().substring(1);
		var checkMemberString=$("#displayMemberId").val().substring(0,1);
	
		clearForm();
		if(fetchMemberId > 0 && checkMemberString == 'M')
		{
			$("#memberIds").val(parseInt(fetchMemberId));
			$.getJSON('fetchMemberDetails.action',{fetchMemberId: fetchMemberId})
			.done(function(data){
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
	
	//Assign Data
	var assignData = function(data){
		//$("#button").show();
		$("#cancel").attr('readonly',false);
		$("#joiningDate").val(convertToUserDate(data.joiningDate)); 
		$("#lastName").val(data.lastName);
		$("#firstName").val(data.firstName);
		$("#middleName").val(data.middleName);
		$("#gender").val(data.gender);
		$("#dateOfBirth").val(convertToUserDate(data.dateOfBirth));
		$("#address").val(data.address);
		$("#age").val(data.age);
		$("#maritalStatus").val(data.maritalStatus);
		if(data.maritalStatus=="Married"){	
			 //$('.annDate').show();
			$("#anniversaryDate").val(convertToUserDate(data.anniversaryDate));		
			$('#anniversaryDate').attr("disabled",false);
		} 	else{
			$('#anniversaryDate').attr("disabled",true);
			 $('.annDate').hide();
		}
		$("#contactNo").val(data.contactNo);
		$("#alternateContactNo").val(data.alternateContactNo);
		$("#emailId").val(data.emailId);
		$("#height").val(data.height);
		$("#weight").val(data.weight);
		$("#chest").val(data.chest);
		$("#bicep").val(data.bicep);
		$("#tricep").val(data.tricep);
		$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
		$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" height="90px" id="imageMember" alt="Image Not Added"/>');
	};
	
	//Clear Form
	var clearForm = function(){
		//$("#button").hide();
		$("#membersNameAutocomplete").val("");
		$("#joiningDate").val(""); 
		$("#lastName").val("");
		$("#firstName").val("");
		$("#middleName").val("");
		$("#gender").val("");
		$("#dateOfBirth").val("");
		$("#age").val("");
		$("#maritalStatus").val("");
		$("#address").val("");
		$("#contactNo").val("");
		$("#alternateContactNo").val("");
		$("#emailId").val("");
		$("#height").val("");
		$("#weight").val("");
		$("#chest").val("");
		$("#bicep").val("");
		$("#tricep").val("");
		$("#memberIds").val(0);
		$('#anniversaryDate').val("");	
		$("#imageMember").remove();
	};
</script>

<s:head />
</head>
<body>
	<s:form id="cancelMember" theme="css_xhtml" >
		<div>
			<fieldset>
				<legend>Cancel Member Information</legend>
				<table>
					<tr>
					<td style="margin-left: 20px;"><label>Member Id<span class="required">*</span></label></td>	
					<td style="width: 320px;" colspan="2" >Member Name</td>
					<td><label>Contact No.<span class="required">*</span></label></td>
					<td><label>Date of Birth</label></td>							
					</tr>
					<tr>
					<td><s:hidden name="memberId" id="memberIds" value="" placeholder="" /> 
						<s:textfield name="displayMemberId" id="displayMemberId" value="" onkeyup="upperCase(this);"  placeholder="M1" /></td>
						<td colspan="2"><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;"/></td>					
						<td valign="top"><s:textfield name="contactNo" id="contactNo"
								value=""  /></td>
						<td><s:textfield name="dateOfBirth" id="dateOfBirth"/>						
					</tr>
				
				</table>
				<hr />
				<table>
					<tr>
						<td><label>Name of Member<span class="required">*</span></label></td>
						<td><s:textfield name="firstName" id="firstName"
								placeholder="First Name" readonly="true" value="" /></td>
						<td><s:textfield name="middleName" id="middleName"
								placeholder="Middle Name" readonly="true"  value="" /></td>
								<td><s:textfield name="lastName" id="lastName"
								placeholder="Last Name" readonly="true" value="" /></td>
						<td align="center" rowspan="4" height="120">
							<div id="image" class="gallery-item" style="width:100px;"></div>
						</td>
						
					</tr>
					<tr>
						<td><label>Gender<span class="required">*</span></label></td>
						 
						<td><label>Age<span class="required">*</span></label></td>
						<td><label>Joining Date<span class="required">*</span></label></td>
						 <td><label>Marital Status</label></td>
						 <td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
					</tr>
					<tr>
						<td><s:select name="gender" id="gender" cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" readonly="true" headerKey="" headerValue="Select Gender"/></td>
						
						<td><s:textfield name="age" id="age" value="" readonly="true"/>
						<td><s:textfield name="joiningDate" id="joiningDate" readonly="true"/>
							 </td>
							 <td><s:select name="maritalStatus" id="maritalStatus" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" readonly="true" headerKey="" headerValue="Select Marital Stauts"/>  </td>
								<td class="annDate" style="display:none;"><s:textfield name="anniversaryDate" id="anniversaryDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
					   </td>
					</tr>
					<tr height="40px;"></tr>
				</table>
			</fieldset>
			<fieldset>
		 
				<legend>Contact Details</legend>
				<table>
					<tr>
						<td><label>Residential Address<span class="required">*</span></label></td>
						
						<td><label>Alternate Contact No.</label></td>
						<td><label>E-Mail Id</label></td>
					</tr>
					<tr>
						<td><s:textarea name="address" id="address"
								onkeyup="sentenceCase(this);" value="" readonly="true"/></td>
						
						<td valign="top"><s:textfield name="alternateContactNo"
								id="alternateContactNo" value="" readonly="true"/></td>
						<td colspan="2"><s:textfield name="emailId" id="emailId"
								value="" cssStyle="width:180px;" readonly="true"></s:textfield></td>
					</tr>
				</table>
				 
			</fieldset>
			<fieldset style="display: none">
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
								cssStyle="width:90px;" value="" readonly="true"/></td>
						<td><s:textfield name="weight" id="weight"
								cssStyle="width:90px;" value="" readonly="true"/></td>
						<td><s:textfield name="chest" id="chest"
								cssStyle="width:90px;" value="" readonly="true"/></td>
						<td><s:textfield name="bicep" id="bicep"
								cssStyle="width:90px;" value="" /></td>
						<td><s:textfield name="tricep" id="tricep"
								cssStyle="width:90px;" value="" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="button">
				<table>
					<tr>
						<td><s:submit align="center" action="cancelMemberDetails"
								id="cancel" value="Cancel Member" readonly="true"/></td>
					</tr>
				</table>
			</fieldset>
			<s:token />
		</div>
	</s:form>
</body>
</html>