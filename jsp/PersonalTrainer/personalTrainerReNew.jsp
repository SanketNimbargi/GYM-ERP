<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 03/09/2014
	 Purpose:Renew Personal Trainer Registration
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
		
		//validations...
		$("#personalTrainerReNew").validate({
	 
		debug : true,
		rules : {
			"personalTrainerId":{required:true},
			"joiningDatePT":{required:true ,checkDate:true},
			"firstNamePT":{required:true,textOnly:true,nameText:true},
			"lastNamePT":{required:true, textOnly:true,nameText:true},
			"middleNamePT":{textOnly:true,nameText:true},
			"emailIdPT":{checkMail:true},
			"genderPT":{required:true},
		},
		messages : {
			"personalTrainerId":{required:"Enter Personal Trainer Id"},
			"joiningDatePT":{required:"Enter Joining Date"},
			"firstNamePT":{required:"Enter First Name"},
			"lastNamePT":{required:"Enter Last Name"},
			"genderPT":{required:"Enter Gender"},
			
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
			onClose: function( selectedDate ) { 
				$( "#dateOfBirthPT" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
			}
			
		});
		//Datepicker
		$("#dateOfBirthPT").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			yearRange : '1950:2050',
			maxDate: "-5Y"
		});
		
		//Auto Complete for Search By Member Name
		/* autoCompletePT("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);
		 */
		//Auto Complete for Search By Member Name
		 //autoCompletePTRenew("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);  
		 $("#ptNameAutocomplete").keyup(function(){			
			 autoCompletePTRenew("ptNameAutocomplete","displayPersonalTrainerId",onPTIdChange);
			});
		 $("#addressPT").keyup(function(){autoCompleteAddress("addressPT","addressPT","");});
		 
		//Auto Completer for search number list for Renew PT Trainer
		autoCompleterPTNumberRenew("contactNoPT","displayPersonalTrainerId",onPTIdChange);
		
	////Auto Complete for Search By date of birth
		autoCompletePTRenewDOB("dateOfBirthPT","displayPersonalTrainerId",onPTIdChange);
	
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
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));

		var personalTrainerId = $("#displayPersonalTrainerId").val().substring(2);
		var checkPTString=$("#displayPersonalTrainerId").val().substring(0,2);			
		if(personalTrainerId > 0 && checkPTString == 'PT'){
			$("#personalTrainerId").val(parseInt(personalTrainerId));
			$.getJSON('fetchCancelPersonalTrainersDetails',{ personalTrainerId : personalTrainerId}).done(function(data){
				
				if(data.ptDetailsList[0] == undefined || data.ptDetailsList == null){					
					$("#message").text("Personal Trainer Not Registered Or Not Canceled. Please Enter Valid Id...").show();
				}
				else{
					assignData(data.ptDetailsList[0] );
				}
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
		$("#re-new").show();
		$("#joiningDatePT").val(convertToUserDate(data.joiningDatePT));
		$("#lastNamePT").val(data.lastNamePT);
		$("#firstNamePT").val(data.firstNamePT);
		$("#middleNamePT").val(data.middleNamePT);
		$("#ptNameAutocomplete").val(data.firstNamePT+" "+data.middleNamePT+" "+data.lastNamePT);
		$("#genderPT").val(data.genderPT);
		$("#maritalStatusPT").val(data.maritalStatusPT);
		$("#dateOfBirthPT").val(convertToUserDate(data.dateOfBirthPT));
		$('#anniversaryDate').val("");	
		
		if(data.maritalStatusPT=="Married"){	
			 $('.annDate').show();
			$("#anniversaryDate").val(convertToUserDate(data.anniversaryDate));		
			$('#anniversaryDate').attr("disabled",false);
		} 	else{
			$('#anniversaryDate').attr("disabled",true);
			 $('.annDate').hide();
		}
		$("#addressPT").val(data.addressPT);
		$("#contactNoPT").val(data.contactNoPT);
		$("#alternateContactNoPT").val(data.alternateContactNoPT);
		$("#emailIdPT").val(data.emailIdPT);
		$("#anniversaryDate").val("");
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

<s:form id="personalTrainerReNew" theme="css_xhtml">
	<!-- <div style="width: 90%;"> -->
	<div style="width: 80%;margin-left: 10%;">
		<fieldset>
			<legend>Re-New Personal Trainer Registration</legend>
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
				<tr><td><label>Joining Date<span class="required">*</span></label></td>
					<td><label>Gender</label></td>
					 <td><label>Marital Status</label></td>
					  <td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
					
				</tr>
				<tr><td><s:textfield name="joiningDatePT" id="joiningDatePT"
							value="" readonly="true" /></td>
					<td><s:select name="genderPT" id="genderPT"
							cssStyle="width:140px;" list="#{'Male':'Male','Female':'Female'}"
							readonly="true" headerKey=""
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
		<s:hidden name="addressPT" id="addressPT" value="" />
		<s:hidden name="contactNoPT" id="contactNoPT" value="" />
		<s:hidden name="alternateContactNoPT" id="alternateContactNoPT"
			value="" />
		<s:hidden name="emailIdPT" id="emailIdPT" value="" />
		<fieldset id="re-new" style="display: none;">
			<s:submit align="center" action="reNewPersonalTrainerDetails"
				value="Re-New" cssClass="smallBtn" />
		</fieldset>
		<s:token />
	</div>
</s:form>