<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 03/09/2014
	 Purpose: Update Personal Trainer Details
-->

<!-- Java Script -->

<script type="text/javascript">
var prevAnniversaryDate;
	$("#document").ready(function(){
		//Datepicker AnniversaryDate
		$('#anniversaryDate').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'			
		});
		
		//Validation for form
		 $("#personalTrainerUpdate").validate({
			debug : true,
			rules : {
				"personalTrainerId":{required:true},
				"joiningDatePT":{required:true},
				"firstNamePT":{required:true,textOnly:true,nameText:true },
				"lastNamePT":{required:true, textOnly:true,nameText:true},
				"middleNamePT":{textOnly:true,nameText:true},
				"genderPT":{ required:true },
				"dateOfBirthPT":{/* required:true, */checkDate:true},
				"anniversaryDate":{/* required:true , */checkDate:true},
				"addressPT":{/* required:true */},
				"contactNoPT":{required:true, checkMobilNo:true},
				"emailIdPT":{checkMail:true},
			},
			messages : {
				"personalTrainerId":{required:" "},
				"joiningDatePT":{required:" "},
				"firstNamePT":{required:" "},
				"lastNamePT":{required:" "},
				"middleNamePT":{required:" "},
				"genderPT":{required:" "},
				"dateOfBirthPT":{required:" "},
				"anniversaryDate":{required:"Enter Anniversary Date"},
				"addressPT":{required:" "},
				"contactNoPT":{required:" "},
				"emailIdPT":{required:" "},
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
		
		
		//Datepicker
		$("#joiningDatePT").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
		    yearRange : '1950:2050',
		  /*   onClose: function( selectedDate ) { 
				$( "#dateOfBirthPT" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
			} */
		});
		//Datepicker
		$("#dateOfBirthPT").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			yearRange : '1950:2050',
			maxDate: "-5Y"
		});
		
		//Auto Complete for Search By Personal Name
		//autoCompletePT("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);
		$("#addressPT").keyup(function(){autoCompleteAddress("addressPT","addressPT","");});
		
		$("#ptNameAutocomplete").keyup(function(){			
			autoCompletePT("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);
		});
		//Auto Complete for Search By Personal Number
		autoCompletePTNumber("contactNoPT","displayPersonalTrainerId",onPTIdChange);
		
		////Auto Complete for Search By date of birth
		autoCompletePTDOB("dateOfBirthPT","displayPersonalTrainerId",onPTIdChange);
		
		//Fetch Trainers Details
		$("#displayPersonalTrainerId").blur(function(){
			onPTIdChange();
		});
		
		$('#maritalStatusPT').change(function(){
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
		
	});
	
	//Function to Fetch Members Details On Change of Member Id
	var onPTIdChange = function(){
		
		clearForm();
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
		var personalTrainerId = $("#displayPersonalTrainerId").val().substring(2);
		var checkPTString=$("#displayPersonalTrainerId").val().substring(0,2);
		
		if(personalTrainerId > 0 && checkPTString == 'PT'){			
			$("#personalTrainerId").val(parseInt(personalTrainerId));
			$.getJSON('fetchPersonalTrainersDetails',{ personalTrainerId : personalTrainerId}).done(function(data){
				if(data.ptDetailsList[0] == undefined || data.ptDetailsList == null)
					$("#message").text("Personal Trainer Not Registered. Please Enter Valid Id...").show();
				else					 
					assignData(data.ptDetailsList[0]);
				
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else{			
			$("#message").text("Personal Trainer Id is not valid. Please Enter Valid Id... (ex. PT1, PT2)").show();
		}
	};
	
	//Assign Data Function
	var assignData = function(data){
		$("#update").show();
		$("#joiningDatePT").val(convertToUserDate(data.joiningDatePT));
		$("#lastNamePT").val(data.lastNamePT);
		$("#firstNamePT").val(data.firstNamePT);
		$("#middleNamePT").val(data.middleNamePT);
		$("#ptNameAutocomplete").val(data.firstNamePT+" "+data.middleNamePT+" "+data.lastNamePT);
		$("#genderPT").val(data.genderPT);
		$("#maritalStatusPT").val(data.maritalStatusPT);
		$('#anniversaryDate').val("");	
	
		if(data.maritalStatusPT=="Married"){	
			 $('.annDate').show();
			$("#anniversaryDate").val(convertToUserDate(data.anniversaryDate));		
			$('#anniversaryDate').attr("disabled",false);
		} 	else{
			$('#anniversaryDate').attr("disabled",true);
			 $('.annDate').hide();
		}
		$("#dateOfBirthPT").val(convertToUserDate(data.dateOfBirthPT));
		$("#addressPT").val(data.addressPT);
		$("#contactNoPT").val(data.contactNoPT);
		$("#alternateContactNoPT").val(data.alternateContactNoPT);
		$("#emailIdPT").val(data.emailIdPT);
	};
	
	//Clear Form function
	var clearForm = function(){
		$("#update").hide();		
		$("#joiningDatePT").val("");
		$("#lastNamePT").val("");
		$("#firstNamePT").val("");
		$("#middleNamePT").val("");
		$("#maritalStatusPT").val("");
		$("#genderPT").val("");
		$("#dateOfBirthPT").val("");
		$("#addressPT").val("");
		$("#contactNoPT").val("");
		$("#alternateContactNoPT").val("");
		$("#emailIdPT").val("");
		$("#personalTrainerId").val("0");
		$("#ptNameAutocomplete").val("");
		$("#anniversaryDate").val("");
	};
	

</script>

<!-- Body starts here -->

	<s:form id="personalTrainerUpdate" theme="css_xhtml">
		<!-- <div style="width: 90%;"> -->
	<div style="width: 80%;margin-left: 10%;">
			<fieldset>
				<legend>Update Personal Trainer Details</legend>
				<table>
					<tr>
                        <td><label>Personal Trainer Name</label></td>
						<td style="width: 160px;"></td>
						<td><label>Personal Trainer Id<span class="required">*</span></label></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td><label>Date of Birth<span class="required">*</span></label></td>
						
					</tr>
					<tr>
					<td colspan="2"><s:textfield id="ptNameAutocomplete" name="ptNameAutocomplete"
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><s:hidden name="personalTrainerId" id="personalTrainerId" value="0" />
							<s:textfield id="displayPersonalTrainerId" name="displayPersonalTrainerId" value="" onkeyup="upperCase(this);" placeholder="PT1"/></td>
							<td><s:textfield name="contactNoPT" id="contactNoPT" value="" /></td>
							<td><s:textfield name="dateOfBirthPT" id="dateOfBirthPT" value="" /></td>
					
					</tr>
				</table>
				<hr />
				<table style="margin-top: 10px;">
					<tr>
						<td><label>Name of Trainer<span class="required">*</span></label></td>
						<td><s:textfield name="firstNamePT" id="firstNamePT"
								placeholder="First Name" onkeyup="upperCase(this);" value="" /></td>
						<td><s:textfield name="middleNamePT" id="middleNamePT"
								placeholder="Middle Name" onkeyup="upperCase(this);" value="" /></td>
							<td><s:textfield name="lastNamePT" id="lastNamePT"
								placeholder="Last Name" onkeyup="upperCase(this);" value="" /></td>
					</tr>
					<tr><td><label>Joining Date<span class="required">*</span></label></td>
						<td><label>Gender<span class="required">*</span></label></td>
						 <td><label>Marital Status<span class="required">*</span></label></td>
						 <td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
					</tr>
					<tr>
						<td><s:textfield name="joiningDatePT" id="joiningDatePT" value=""  /></td>
						<td><s:select name="genderPT" id="genderPT" cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" headerKey=""
							headerValue="Select Gender Type"/></td>
						<td><s:select name="maritalStatusPT" id="maritalStatusPT" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" headerKey="1" headerValue="Select Marital Status"/> </td>						
						<td class="annDate" style="display:none;"><s:textfield name="anniversaryDate" id="anniversaryDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
						</td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>Contact Details</legend>
				<table>
					<tr>
						<td><label>Residential Address<%-- <span class="required">*</span> --%></label></td>
						
						<td><label>Alternate Contact No.</label></td>
						<td><label>E-Mail Id</label></td>
					</tr>
					<tr>
						<td><s:textarea name="addressPT" id="addressPT" onkeyup="firstCharWordUpper(this);" value="" /></td>
						
						<td><s:textfield name="alternateContactNoPT" id="alternateContactNoPT" value="" /></td>
						<td colspan="2"><s:textfield name="emailIdPT" id="emailIdPT" value="" cssStyle="width:180px;" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="update" style="display: none;">
				<s:submit align="center" action="updatePersonalTrainerDetails" value="Update" cssClass="smallBtn"/>
			</fieldset>
			<s:token />
		</div>
	</s:form>