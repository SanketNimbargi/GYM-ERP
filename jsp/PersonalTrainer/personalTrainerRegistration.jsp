<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 03/09/2014
	 Purpose: Personal Trainer Registration
-->

<!-- Java Script -->

<script type="text/javascript">
	$("#document").ready(function(){
		$("#genderPT").val("Male");
		$("#maritalStatusPT").val("Unmarried");
		//Datepicker
		$("#joiningDatePT").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			yearRange : '1950:2050',
			/* onClose: function( selectedDate ) { 
				$( "#dateOfBirthPT" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
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
		$("#dateOfBirthPT").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			yearRange : '1950:2050',
			maxDate: "-5Y"
		});
		
		//Validation for form
		$("#personalTrainerRegistration").validate({
			debug : true,
			rules : {
				"joiningDatePT":{required:true ,checkDate:true},
				"lastNamePT":{required:true,textOnly:true, nameText:true},
				"firstNamePT":{required:true, textOnly:true, nameText:true},
				"middleNamePT":{textOnly:true, nameText:true},
				"genderPT":{ required:true },
				"dateOfBirthPT":{/* required:true, */checkDate:true},
				"anniversaryDate":{/* required:true , */checkDate:true},
				"addressPT":{/* required:true */},
				"maritalStatusPT":{required:true},
				"contactNoPT":{required:true,checkMobilNo:true},
				"emailIdPT":{checkMail:true},
			},
			messages : {
				"joiningDatePT":{required:"Enter Joining Date"},
				"lastNamePT":{required:"Enter last Name"},
				"firstNamePT":{required:"Enter First Name"},
				"genderPT":{required:"Select Gender"},
				"dateOfBirthPT":{required:"Enter Date of Birth"},
				"anniversaryDate":{required:"Enter Anniversary Date"},
				"addressPT":{required:"Enter address"},
				"contactNoPT":{required:"Enter contact No"},
				"maritalStatusPT":{required:"Select Marital Status"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
		
		$('#maritalStatusPT').change(function(){
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
		$("#addressPT").keyup(function(){autoCompleteAddress("addressPT","addressPT","");});
	});
</script>

<!-- Body starts here -->

	<s:form id="personalTrainerRegistration" theme="css_xhtml">
		<!-- <div style="width: 90%;"> -->
	<div style="width: 80%;margin-left: 10%;">
			<fieldset>
				<legend>Personal Trainer Registration</legend>
				<table>
					<tr>

						<td><label>Personal Trainer Id<span class="required">*</span></label></td>
						<td style="width: 160px;"></td>
						<td style="width: 160px;"></td>
						<td><label>Joining Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:textfield id="displayPersonalTrainerId" value="%{displayPersonalTrainerId}" readonly="true" /></td>
						<td style="width: 160px;"></td>
						<td style="width: 160px;"></td>
						<td><s:textfield name="joiningDatePT" id="joiningDatePT">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield>
						</td>
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
					<tr>
						<td><label>Gender <span class="required">*</span></label> </td>
						<td><label>Date of Birth<%-- <span class="required">*</span> --%></label></td>
						<td><label>Marital Status<span class="required">*</span></label></td>
						<td class="annDate" style="display:none;"><label>Anniversary Date</label></td>
					</tr>
					<tr>
						<td><s:select name="genderPT" id="genderPT" cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" headerKey="" headerValue="Select Gender"/></td>
						<td><s:textfield name="dateOfBirthPT" id="dateOfBirthPT" value="" /></td>
						<td><s:select name="maritalStatusPT" id="maritalStatusPT" cssStyle="width:140px;"
								list="#{'Unmarried':'Single','Married':'Married'}" headerKey="" headerValue="Select Marital Status"/> </td>
						
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
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td><label>Alternate Contact No.</label></td>
						<td><label>E-Mail Id</label></td>
					</tr>
					<tr>
						<td><s:textarea name="addressPT" id="addressPT" onkeyup="firstCharWordUpper(this);" value="" /></td>
						<td><s:textfield name="contactNoPT" id="contactNoPT" value="" /></td>
						<td><s:textfield name="alternateContactNoPT" id="alternateContactNoPT" value="" /></td>
						<td colspan="2"><s:textfield name="emailIdPT" id="emailIdPT" value="" cssStyle="width:180px;" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<s:submit align="center" action="savePersonalTrainerDetails" id="save" value="Save" cssClass="smallBtn"/>
			</fieldset>
			<s:token />
		</div>
	</s:form>