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
		 
		// fetch member details
		$("#displayMemberId").blur(function(){
			onMemberIdChange();							//Fetch Members Details On Change of Member Id
		});
		
		$("#membersNameAutocomplete").keyup(function(){
			//Auto Complete for Search By Member Name
			autoCompleteMemberNameRejoin("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		});
		//Auto Complete for Search By number
		autoCompleteMemberNumberRejoin("contactNo","displayMemberId",onMemberIdChange);
	////Auto Complete for Search By date of birth
		autoCompleteRenewMemberByDOB("dateOfBirth","displayMemberId",onMemberIdChange);
	
	
		//Datepicker
		$('#joiningDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
			onClose: function( selectedDate ) { 
				$( "#dateOfBirth" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
			}
		});
		$('#dateOfBirth').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050',
			maxDate: "-5Y"
		});
		//Datepicker AnniversaryDate
		$('#anniversaryDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'			
		});

	
		//Validation for form
		 $("#reJoinMember").validate({
			debug:true,
			rules:{
				"joiningDate":{required:true ,checkDate:true},
				"memberId":{required:true },
				"lastName":{required:true ,textOnly:true,nameText:true},
				"firstName":{required:true ,textOnly:true,nameText:true},
				"middleName":{textOnly:true,nameText:true},
				"gender":{required:true},
				//"dateOfBirth":{required:true ,checkDate:true},
				"anniversaryDate":{required:true ,checkDate:true},
				//"address":{required:true},
				"contactNo":{required:true,checkMobilNo:true},
				"emailId":{checkMail:true},
				"maritalStatus":{required:true},
				 
			},
			messages:{
				"joiningDate":{required:"Enter Joining Date"},
				"memberId":{required:" Select Member ID"},
				"lastName":{required:"Enter Last Name"},
				"firstName":{required:"Enter First Name"},
				//"dateOfBirth":{required:"Enter Date of Birth"},
				"anniversaryDate":{required:"Enter Anniversary Date"},
				//"address":{required:"Enter Address"},
				"contactNo":{required:"Enter Contact No."},
				"gender":{required:"Select Gender"},
				"maritalStatus":{required:"Select Marital Status"},
				 
			},
			submitHandler:function(form){
				form.submit();
			}
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
		 $("#address").keyup(function(){autoCompleteAddress("address","address","");});
	});
	
	//Assign Data
	var assignData = function(data){
		$("#button").show();
		$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
		$("#joiningDate").val(convertToUserDate(data.joiningDate)); 
		$("#lastName").val(data.lastName);
		$("#firstName").val(data.firstName);
		$("#middleName").val(data.middleName);
		$("#gender").val(data.gender);
		$("#dateOfBirth").val(convertToUserDate(data.dateOfBirth));
		$("#maritalStatus").val(data.maritalStatus);					
		if(data.maritalStatus=="Married"){	
			 $('.annDate').show();
			$("#anniversaryDate").val(convertToUserDate(data.anniversaryDate));		
			$('#anniversaryDate').attr("disabled",false);
		} 	else{
			$('#anniversaryDate').attr("disabled",true);
			 $('.annDate').hide();
		}
		$("#age").val(data.age);		
		$("#address").val(data.address);
		$("#contactNo").val(data.contactNo);
		$("#alternateContactNo").val(data.alternateContactNo);
		$("#emailId").val(data.emailId);
		$("#height").val(data.height);
		$("#weight").val(data.weight);
		$("#chest").val(data.chest);
		$("#bicep").val(data.bicep);
		$("#tricep").val(data.tricep);
		$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image" alt="Image Not Added" />');

	/* 	$("#image").append('<img src="/GymMgmt/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image"/>'); */
	};
	
	//Clear Form
	var clearForm = function(){
		$("#button").hide();
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
		$("#imageMember").remove();
		$("#memberIds").val(0);
		$("#membersNameAutocomplete").val("");
		$('#anniversaryDate').val("");	
		$("#message").hide();
	};
	//Function to Fetch Members Details On Change of Member Id
	var onMemberIdChange = function(){
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));

		var fetchMemberId = $("#displayMemberId").val().substring(1);
		var checkMemberString=$("#displayMemberId").val().substring(0,1);
		clearForm();
		if(fetchMemberId > 0 && checkMemberString == 'M')
		{
			$("#memberIds").val(parseInt(fetchMemberId));
			$.getJSON('fetchCancelMemberDetails',{fetchMemberId : fetchMemberId}).done(function(data){
				
				if(data.cancelMemberList[0] == undefined)
					$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
				else
					assignData(data.cancelMemberList[0]);
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
	};
</script>

<s:head />
</head>
<body>

	<s:form id="reJoinMember" theme="css_xhtml" >
		
		<!-- 	<div style="width: 90%;"> -->
	<div style="width: 90%;margin-left: 5%;">
			<fieldset>
				<legend>Re-New Member Information</legend>
				<table>
					<tr>
					<td></td>
					<td></td>
					<td></td>
						<td style="margin-left: 20px;"><label>Member Id<span class="required">*</span></label></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td><label>Date of Birth</label></td>
						
					</tr>
					
					<tr>
					<td colspan="2"><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td style="width: 160px;"></td>
						<td><s:hidden name="memberId" id="memberIds" value="%{memberId}" /> 
							<s:if test="memberId != 0">
								<s:textfield name="displayMemberId" id="displayMemberId" value="M%{memberId}" placeholder="M1" onkeyup="upperCase(this);"/>
							</s:if>
							<s:else>
								<s:textfield name="displayMemberId" id="displayMemberId" value="" placeholder="M1" onkeyup="upperCase(this);"/>
							</s:else>
							<%-- <s:textfield name="displayMemberId" id="displayMemberId" value="%{memberId}" onkeyup="upperCase(this);"  /></td> --%>
						<td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
								<td><s:textfield name="dateOfBirth" id="dateOfBirth" value="" />
						
					</tr>
					<tr><td><label>Joining Date<span class="required">*</span></label></td></tr>
					<tr><td><s:textfield name="joiningDate" id="joiningDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield></td></tr>
					</table>
					<hr/>
					<table>
					<tr>
						<td><label>Name of Member<span class="required">*</span></label></td>
						
						<td><s:textfield name="firstName" id="firstName"
								placeholder="First Name" onkeyup="upperCase(this);" value="" /></td>
						<td><s:textfield name="middleName" id="middleName"
								placeholder="Middle Name" onkeyup="upperCase(this);" value="" /></td>
							<td><s:textfield name="lastName" id="lastName"
								placeholder="Last Name" onkeyup="upperCase(this);" value="" /></td>

						<td align="center" rowspan="4" height="120">
							<div ng-controller="UploadController" id="updateImage" style="width: 100px; display: none;">
								<i ng-hide="imageSrc">No image Selected</i>
								<img ng-src="{{imageSrc}}" width="80" height="90" />
								<s:file ng-file-select="onFileSelect($files)" id="userImage"
									name="userImage" cssStyle="width: 70px; margin:0 auto;" />
							</div>
							<div id="image" class="gallery-item" style="width: 100px;"></div>
						</td>
					</tr>
					<tr>
						<td><label>Gender<span class="required">*</span></label></td>
						 
						<td><label>Age</label></td>
						 <td><label>Marital Status</label></td>
						 <td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
					</tr>
					<tr>
						<td><s:select name="gender" id="gender" cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" headerKey="" headerValue="Select Gender"/></td>
						
						<td><s:textfield name="age" id="age" value="" />
						<td><s:select name="maritalStatus" id="maritalStatus" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" headerKey="" headerValue="Select Marital Status"/>  </td>
						<td class="annDate" style="display:none;"><s:textfield name="anniversaryDate" id="anniversaryDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
					   </td>
					</tr>
				
					<tr height="40px;"></tr>
				</table>
				<table>
					
					
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
								onkeyup="sentenceCase(this);" value="" /></td>
						
						<td valign="top"><s:textfield name="alternateContactNo"
								id="alternateContactNo" value="" /></td>
						<td colspan="2"><s:textfield name="emailId" id="emailId"
								value="" cssStyle="width:180px;"></s:textfield></td>
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
			<fieldset id="button" style="display:none">
				<table>
					<tr>
						<td><s:submit align="center" action="rejoinMemberDetails"
								id="rejoin" value="Re-Join" cssClass="smallBtn" /></td>
					</tr>
				</table>
			</fieldset>
			<s:token />
		</div>
	</s:form>
</body>
</html>