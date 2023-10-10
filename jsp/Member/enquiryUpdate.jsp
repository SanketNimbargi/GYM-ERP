<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Pranjali Deshmukh
	 Date: 16/09/2014
	 Purpose:Enquiry Details
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
	$("#document").ready(function(){
		 
		$.validator.addMethod('numericOnly', function (value) {
		       return /^[0-9]+$/.test(value);
		}, 'Please only enter numeric values (0-9)');

		$.validator.addMethod("dateOfBirthEnquiry", function(value, element){
				var enquiryDate = $('#enquiryDate').val();
				return Date.parse(enquiryDate) > Date.parse(value);
		},'Date of birth should be less than  enquiry Date');
		
		$.validator.addMethod("replyDate", function(value, element){
				var enquiryDate = $('#enquiryDate').val();				
				return Date.parse(value);
		},'Reply Date should be greater than  enquiry Date');
			 
			 
		$("#firstreplyDate").val("");
		
		 $("#displayEnquiryId").val('${enqId}');
		 if( $("#displayEnquiryId").val().length > 0){
			 onKeyUp();
		 }
		  
		
		 $("#displayEnquiryId").keyup(function(){
			 onKeyUp();
		  });
		 
		//Datepicker
		$("#dateOfBirthEnquiry").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			yearRange : '1950:2050',
			maxDate: "-5Y"
		});
		//Datepicker
		$("#firstreplyDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate: 0
		});
		//Datepicker
		$("#enquiryDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				$( "#firstreplyDate" ).datepicker( "option", "minDate", selectedDate );
				$( "#dateOfBirthEnquiry" ).datepicker( "option", "maxDate", addMonths(selectedDate,-60) );
			}
		});
		
		//Validation for form
		$("#enquiry").validate({
			debug : true,
			rules : {
				"displayEnquiryId":{required:true,numericOnly:true},
				"enquiryDate":{required:true,checkDate:true},
				"firstNameEnquiry":{required:true,textOnly:true,nameText:true},
				"middleNameEnquiry":{textOnly:true,nameText:true},
				"lastNameEnquiry":{required:true,textOnly:true,nameText:true},
				"genderEnquiry":{required:true},
				"addressEnquiry":{/* required:true */},
				"contactNoEnquiry":{required:true,checkMobilNo:true},
				"feedbackEnquiry":{required:true},
				"emailIdEnquiry":{checkMail:true},
				"dateOfBirthEnquiry":{checkDate:true},
				"firstreplyDate":{required:true,checkDate:true,replyDate:true}
				
				
			},
			messages : {
				"displayEnquiryId":{required:"Enter Enquiry Id"},
				"enquiryDate":{required:"Enter Enquiry Date"},
                "firstNameEnquiry":{required:"Enter First Name"},
				"lastNameEnquiry":{required:"Enter Last Name"},
				"genderEnquiry":{required:"Enter Gender"},
				"addressEnquiry":{required:"Enter address"},
				"contactNoEnquiry":{required:"Enter contact No"},
			    "feedbackEnquiry":{required:"Enter feedback"},
			    "firstreplyDate":{required:"Enter Reply Date"}
			    
				
			},
			submitHandler : function(form) {
				form.submit();
			}
		});
		
		//Auto Complete for Search By Member Name
		//autoCompleteEnquiry("enquiryNameAutocomplete","displayEnquiryId",onKeyUp);
		$("#enquiryNameAutocomplete").keyup(function(){			
			autoCompleteEnquiry("enquiryNameAutocomplete","displayEnquiryId",onKeyUp);
		});
		$("#addressEnquiry").keyup(function(){autoCompleteAddress("addressEnquiry","addressEnquiry","");});
		//Auto Complete for Search By Contact No
		autoCompleteEnquirybyNo("contactNoEnquiry","displayEnquiryId",onKeyUp);
		
	});
	
	
	var onKeyUp = function(){
	    
	   	 var displayEnquiryId=$("#displayEnquiryId").val();
	   		 
	   	
	   	 $("#enquiryId").val(parseInt(displayEnquiryId));
		  $.getJSON("fetchrecord",{displayEnquiryId:displayEnquiryId},function(data){
			
			  $("#displayEnquiryId").val(data.enquiryList[0].displayEnquiryId);
				$("#enquiryDate").val(convertToUserDate(data.enquiryList[0].enquiryDate));
				$("#enquiryNameAutocomplete").val(data.enquiryList[0].firstNameEnquiry+" "+data.enquiryList[0].middleNameEnquiry+" "+data.enquiryList[0].lastNameEnquiry);
				if(data.enquiryList[0].thirdreplyDate){
					$("#firstreplyDate").val(convertToUserDate(data.enquiryList[0].thirdreplyDate));
					$("#save").hide(); 
					$("#update").hide();
					$("#reEnquiry").hide();
					$("#operation").hide();
				 }
				else if(data.enquiryList[0].secondreplyDate){
					$("#firstreplyDate").val(convertToUserDate(data.enquiryList[0].secondreplyDate));
				}
				 else{
					$("#firstreplyDate").val(convertToUserDate(data.enquiryList[0].firstreplyDate));
				} 
				
						
				$("#fitnessid").val(data.enquiryList[0].fitnessGoalList);
				$("#firstNameEnquiry").val(data.enquiryList[0].firstNameEnquiry);
				$("#middleNameEnquiry").val(data.enquiryList[0].middleNameEnquiry);
				$("#lastNameEnquiry").val(data.enquiryList[0].lastNameEnquiry);
				$("#genderEnquiry").val(data.enquiryList[0].genderEnquiry);
				$("#dateOfBirthEnquiry").val(convertToUserDate(data.enquiryList[0].dateOfBirthEnquiry));
				//$("#feedbackEnquiry").val(data.enquiryList[0].feedbackEnquiry);
				$("#addressEnquiry").val(data.enquiryList[0].addressEnquiry);
				$("#contactNoEnquiry").val(data.enquiryList[0].contactNoEnquiry);
				$("#alternateContactNoEnquiry").val(data.enquiryList[0].alternateContactNoEnquiry);
				$("#emailIdEnquiry").val(data.enquiryList[0].emailIdEnquiry);
				$("#enquirytype").val(data.enquiryList[0].enquirytype);
				$("#enquiryHandledBy").val(data.enquiryList[0].enquiryHandledBy);
				
				
				$("#operation").show("fast");
				$("#cancel").show("fast");
				$("#reEnquiry").show("fast");
				
			}); 
	}
</script>
</head>
<body>
<s:form id="enquiry" theme="css_xhtml" name="enquiry">
	<!-- <div style="width: 90%;"> -->
	<div style="width: 80%;margin-left: 10%;">
		<fieldset>
			<legend>Re-Enquiry Details</legend>
			<table>
				<tr>

					<td><label>Enquiry Id<span class="required">*</span></label></td>
					<td width="120 px"></td>
					<td width="120 px"></td>
					<td><label>Contact No.<span class="required">*</span></label></td>
					<td><label>Enquiry Date<span class="required">*</span></label></td>
					
				</tr>
				<tr>
					<td><s:hidden id="enquiryId" name="enquiryId" />
						<s:textfield id="displayEnquiryId"
						 name="displayEnquiryId" value="%{enquiryId}"/></td>
					<td colspan="2"><s:textfield id="enquiryNameAutocomplete" name="enquiryNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
							
					
					<td colspan="1"><s:textfield name="contactNoEnquiry" id="contactNoEnquiry"
							value="" placeholder="Contact No" /></td>		
							
					<td><s:textfield name="enquiryDate" id="enquiryDate"  readonly="true">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
						</s:textfield></td>
				</tr>
				<tr>
				<td><label>Reply Date</label></td>
					<td><label>Fitness Goal<span class="required">*</span></label></td>
					<td><label>Enquiry Type<span class="required">*</span></label></td>
					
				</tr>
				<tr>
				<td><s:textfield name="firstreplyDate" id="firstreplyDate">
						</s:textfield></td>
						<td><s:select id="fitnessid" name="fitnessGoalList" headerKey="0" headerValue="Select FG"  cssStyle="width:140px;"
							list="fitnessGoalmap"  value="" /></td>
							<td><s:select name="enquirytype" id="enquirytype" headerKey="0" headerValue="Select Enquiry Type"  cssStyle="width:140px;"
							 list="#{'Flyers':'Flyers', 'Referral':'Referral',
	                    'News Paper':'News Paper','Hoarding':'Hoarding','Word of mouth':'Word of mouth','Other':'Other'}">
							</s:select></td>
							<td><s:textfield name="otherenquirytype" id="otherenquirytype"
							  value="" style="display:none"/></td>
				</tr>
			</table>
			<hr />
			<table style="margin-top: 10px;">
				<tr>
					<td><label>Name of Person<span class="required">*</span></label></td>

					<td><s:textfield name="firstNameEnquiry" id="firstNameEnquiry"
							placeholder="First Name" onkeyup="upperCase(this);" value="" /></td>
					<td><s:textfield name="middleNameEnquiry"
							id="middleNameEnquiry" placeholder="Middle Name"
							onkeyup="upperCase(this);" value="" /></td>
					<td><s:textfield name="lastNameEnquiry" id="lastNameEnquiry"
							placeholder="Last Name" onkeyup="upperCase(this);" value="" /></td>
				</tr>
				<tr>
					<td><label>Gender<span class="required">*</span></label></td>
					<td><label>Date of Birth</label></td>
					<td><label>Feedback<span class="required">*</span></label></td>
				</tr>
				<tr>
					<td><s:select name="genderEnquiry" id="genderEnquiry"
							cssStyle="width:140px;" list="#{'Male':'Male','Female':'Female'}" headerKey=""
							headerValue="Select Gender Type" /></td>
					<td><s:textfield name="dateOfBirthEnquiry"
							id="dateOfBirthEnquiry" value="" /></td>
							<td><s:textarea name="feedbackEnquiry" id="feedbackEnquiry"
							 value="" /></td>
				</tr>
			</table>
		</fieldset>
		<fieldset>
			<legend>Contact Details</legend>
			<table>
				<tr>
					<td><label>Residential Address<%-- <span class="required">*</span> --%></label></td>
				<%-- <td><label>Contact No.<span class="required">*</span></label></td>  --%>
					<td><label>Alternate Contact No.</label></td>
					<td><label>E-Mail Id</label></td>
				</tr>
				<tr>
					<td><s:textarea name="addressEnquiry" id="addressEnquiry"
							onkeyup="firstCharWordUpper(this);" value="" /></td>
					<%-- <td><s:textfield name="contactNoEnquiry" id="contactNoEnquiry"
							value="" /></td> --%>
					 <td><s:textfield name="alternateContactNoEnquiry"
							id="alternateContactNoEnquiry" value="" /></td> 
					<td colspan="2"><s:textfield name="emailIdEnquiry"
							id="emailIdEnquiry" value="" cssStyle="width:180px;" /></td>
				</tr>
			</table>
		</fieldset>	
		<fieldset>
		<table align="left">
			<tr>
			<td><label>Re-enquiry Handled By&nbsp;&nbsp;</label></td>
			<td><s:textfield name="enquiryHandledBy" id="enquiryHandledBy"
							value="" readonly="true"/></td>						
			</tr>
		</table>		
		<fieldset style="width:98%; display:none" id="operation">		
		<table>
			<tr>
				<td><s:submit action="deleteEnquiryDetails" id="cancel"
						value="Cancel" style="display:none" cssClass="smallBtn"/></td>
				<td><s:submit action="reEnquiryDetails" id="reEnquiry"
						value="ReEnquiry" style="display:none" cssClass="smallBtn"/></td>
						
			</tr>
			</table>
		</fieldset>
		</fieldset>
		<s:token />
	</div>
</s:form>
</body>
</html>