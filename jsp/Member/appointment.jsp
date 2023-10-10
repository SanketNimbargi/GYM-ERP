<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 16/09/2014
	 Purpose:Enquiry Details
-->

<!-- Java Script -->

<script type="text/javascript">
	$("#document").ready(function(){
		
	 
		//Datepicker
		$("#appointmentDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate: 0
		});
		
		
		//Validation for form
		$("#appointment").validate({
			debug : true,
			rules : {
				"appointmentDate":{required:true ,checkDate:true},
				"firstNameAppointment":{required:true, textOnly:true,nameText:true},
				"lastNameAppointment":{textOnly:true,nameText:true},
				"contactNoAppointment":{required:true, checkMobilNo:true},
				"genderAppointment":{required:true},
			},
			messages : {
				"appointmentDate":{required:"Enter Appointment Date"},
				"firstNameAppointment":{required:"Enter First Name"},
				"contactNoAppointment":{required:"Enter contact No"},
				"genderAppointment":{required:"Enter Gender"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
		
	});
</script>

<!-- Body starts here -->

	<s:form id="appointment" theme="css_xhtml">
		<!-- <div style="width: 98%;"> -->		
	<div style="width: 80%;margin-left: 10%;">
			<fieldset>
				<legend>Appointment Details</legend>
				<table>
					<tr>

						<td><label>Appointment Id<span class="required">*</span></label></td>
						
						<td><label>Appointment Date<span class="required">*</span></label></td>
						<td><label>Appointment Time</label></td> 
						<!-- <td style="width: 160px;"></td> -->
					</tr>
					<tr>
						<td><s:textfield id="displayAppointmentId" value="%{displayAppointmentId}" readonly="true" /></td>
						
						<td><s:textfield name="appointmentDate" id="appointmentDate">
								<%-- <s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param> --%>
							</s:textfield>
						</td>
						<td><s:textfield name="appointmentTime" id="appointmentTime" value="" /></td>
						<!-- <td style="width: 160px;"></td> -->
					</tr>
				</table>
				<hr />
				<table style="margin-top: 10px;">
					<tr>
						<td><label>Name of Person<span class="required">*</span></label></td>
						<td><s:textfield name="firstNameAppointment" id="firstNameAppointment"
								placeholder="First Name" onkeyup="upperCase(this);" value="" /></td>
						<%-- <td><s:textfield name="middleNameAppointment" id="middleNameAppointment"
								placeholder="Middle Name" onkeyup="upperCase(this);" value="" /></td> --%>
						<td><s:textfield name="lastNameAppointment" id="lastNameAppointment"
								placeholder="Last Name" onkeyup="upperCase(this);" value="" /></td>
					</tr>
					<tr>
						<td><label>Gender</label></td>
						<td><label>Residential Address</label></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:select name="genderAppointment" id="genderAppointment" cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" headerKey=""
							headerValue="Select Gender Type" /></td>
						<td><s:textarea name="addressAppointment" id="addressAppointment" onkeyup="firstCharWordUpper(this);" value="" /></td>
						<td><s:textfield name="contactNoAppointment" id="contactNoAppointment" value="" /></td>
					</tr>
				</table>
			</fieldset>
			
			<fieldset>
				<s:submit align="center" action="saveAppointmentDetails" id="save" value="Save" cssClass="smallBtn"/>
			</fieldset>
			<s:token />
		</div>
	</s:form>