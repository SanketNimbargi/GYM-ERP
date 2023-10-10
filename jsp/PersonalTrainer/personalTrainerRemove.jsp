<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 03/09/2014
	 Purpose: Remove Personal Trainer Registration
-->

<!-- Java Script -->

<script type="text/javascript">
	$("#document").ready(function(){
	 
		//Auto Complete for Search By Member Name
		//autoCompletePT("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);
		$("#ptNameAutocomplete").keyup(function(){			
			autoCompletePT("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);
		});
		///Auto Complete for Search By Personal Number
		autoCompletePTNumber("contactNoPT","displayPersonalTrainerId",onPTIdChange);
	////Auto Complete for Search By date of birth
		autoCompletePTDOB("dateOfBirthPT","displayPersonalTrainerId",onPTIdChange);
	
		
		//Fetch Trainers Details
		$("#displayPersonalTrainerId").blur(function(){
			onPTIdChange();
		});
	});
	
	//Function to Fetch Members Details On Change of Member Id
	var onPTIdChange = function(){
		var personalTrainerId = $("#displayPersonalTrainerId").val().substring(2);
		var checkPTString=$("#displayPersonalTrainerId").val().substring(0,2);
		if(personalTrainerId > 0 && checkPTString == 'PT'){
			$("#personalTrainerId").val(parseInt(personalTrainerId));
			$.getJSON('fetchPersonalTrainersDetails',{ personalTrainerId : personalTrainerId}).done(function(data){
				
				if(data.ptDetailsList[0] == undefined || data.ptDetailsList == null)
					$("#message").text("Personal Trainer Not Registered. Please Enter Valid Id...").show();
				else
					assignData(data.ptDetailsList[0] );
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else
			$("#message").text("Personal Trainer Id is not valid. Please Enter Valid Id... (ex. PT1, PT2)");
	};
	
	//Assign Data Function
	var assignData = function(data){
		$("#remove").show();
		$("#joiningDatePT").val(convertToUserDate(data.joiningDatePT));
		$("#lastNamePT").val(data.lastNamePT);
		$("#firstNamePT").val(data.firstNamePT);
		$("#middleNamePT").val(data.middleNamePT);
		$("#ptNameAutocomplete").val(data.firstNamePT+" "+data.middleNamePT+" "+data.lastNamePT);
		$("#genderPT").val(data.genderPT);
		$("#maritalStatusPT").val(data.maritalStatusPT);
		$("#dateOfBirthPT").val(convertToUserDate(data.dateOfBirthPT));
		$("#addressPT").val(data.addressPT);
		$("#contactNoPT").val(data.contactNoPT);
		$("#alternateContactNoPT").val(data.alternateContactNoPT);
		$("#emailIdPT").val(data.emailIdPT);
	};
	
	//Clear Form function
	var clearForm = function(){
		$("#remove").hide();
		$("#joiningDatePT").val("");
		$("#lastNamePT").val("");
		$("#firstNamePT").val("");
		$("#middleNamePT").val("");
		$("#genderPT").val("");
		$("#maritalStatusPT").val("");
		$("#dateOfBirthPT").val("");
		$("#addressPT").val("");
		$("#contactNoPT").val("");
		$("#alternateContactNoPT").val("");
		$("#emailIdPT").val("");
		$("#ptNameAutocomplete").val("");
	};
</script>

<!-- Body starts here -->

<s:form id="personalTrainerRemove" theme="css_xhtml">
	<!-- <div style="width: 90%;"> -->
	<div style="width: 80%;margin-left: 10%;">
		<fieldset>
			<legend>Remove Personal Trainer Registration</legend>
			<table>
				<tr>
                    <td><label>Personal Trainer Name</label></td>
					<td style="width: 160px;"></td>
					<td><label>Personal Trainer Id<span class="required">*</span></label></td>
					<td><label>Contact No.<span class="required">*</span></label></td>
					<td><label>Date of Birth</label></td>
				</tr>
				<tr>
				<td colspan="2"><s:textfield id="ptNameAutocomplete" name="ptNameAutocomplete"
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
					<td><s:hidden name="personalTrainerId" id="personalTrainerId"
							value="0" /> <s:textfield id="displayPersonalTrainerId" value=""
							onkeyup="upperCase(this);" placeholder="PT1" /></td>
							<td><s:textfield name="contactNoPT" id="contactNoPT" value="" /></td>
							<td><s:textfield name="dateOfBirthPT" id="dateOfBirthPT"
							value="" /></td>
				</tr>
			</table>
			<hr />
			<table style="margin-top: 10px;">
				<tr>
					<td><label>Name of Trainer<span class="required">*</span></label></td>
					<td><s:textfield name="firstNamePT" id="firstNamePT"
							placeholder="First Name" value="" readonly="true" /></td>
					<td><s:textfield name="middleNamePT" id="middleNamePT"
							placeholder="Middle Name" value="" readonly="true" /></td>
					<td><s:textfield name="lastNamePT" id="lastNamePT"
							placeholder="Last Name" value="" readonly="true" /></td>
				</tr>
				<tr>
				<tr><td><label>Joining Date<span class="required">*</span></label></td>
					<td><label>Gender</label></td>
					 <td><label>Marital Status</label></td>
				</tr>
				<tr>
				<td><s:textfield name="joiningDatePT" id="joiningDatePT"
							value="" readonly="true" /></td> 
					<td><s:select name="genderPT" id="genderPT"
							cssStyle="width:140px;" list="#{'Male':'Male','Female':'Female'}"
							readonly="true" headerKey=""
							headerValue="Select Gender Type"/></td>
							<td><s:select name="maritalStatusPT" id="maritalStatusPT" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" headerKey=""
							headerValue="Select Marital Status"/> </td>
					
				</tr>
			</table>
		</fieldset>
		<s:hidden name="addressPT" id="addressPT" value="" />
		<s:hidden name="contactNoPT" id="contactNoPT" value="" />
		<s:hidden name="alternateContactNoPT" id="alternateContactNoPT"
			value="" />
		<s:hidden name="emailIdPT" id="emailIdPT" value="" />
		<fieldset id="remove" style="display: none;">
			<s:submit align="center" action="removePersonalTrainerDetails"
				value="Remove" cssClass="smallBtn" />
		</fieldset>
		<s:token />
	</div>
</s:form>