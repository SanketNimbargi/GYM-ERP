<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>PT Attendance Between Date</title>
</head>
<script type="text/javascript">
	$("#document").ready(function(){
		
		//Date Picker To From Date
		$("#fromDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#toDate" ).datepicker( "option", "minDate", selectedDate );
				 }
		});
		
		//Date Picker To To Date
		$("#toDate").datepicker({
			
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			onClose : function(selectedDate){
				$("#fromDate").datepicker("option","maxDate",selectedDate);
			}
		});
		
		
		//Validation To Form
		$("#personalTrainerAttendanceBetweenDateById").validate({
			debug : true,
			rules: {
				"personalTrainerId" : {required : true },
				"fromDate" : {required:true ,checkDate:true},
				"toDate" : {required:true ,checkDate:true},
			},
			messages :
			{
				"personalTrainerId" : {required:"Enter Personal Trainer Id"},
				"fromDate" : {required:"Select From Date"},
				"toDate" : {required:"Select To Date"}
			},
			submitHandler : function(form) {
				form.submit();
			}
			
		});
		
		//Auto Compete By Personal Trainer Name
		$("#personalTrainerAutocomplete").keyup(function(){
			
			autoCompletePT("personalTrainerAutocomplete", "personalTrainerId", onPersonalTrainerIdChange);	
		});
		
		//Auto Complete By Contact Number
		autoCompletePTNumber("contactNoPT","personalTrainerId",onPersonalTrainerIdChange);
		
		//Fetch Personal Trainer Details
		$("#personalTrainerId").change(function(){
			
			onPersonalTrainerIdChange();
		});
		
	});
	var onPersonalTrainerIdChange = function(){
		
		var personalTrainerId = $("#personalTrainerId").val().substring(2);
		var checkPersonalTrainerString = $("#personalTrainerId").val().substring(0,2);
		
		if(personalTrainerId > 0 && checkPersonalTrainerString == "PT"){
			
			$.getJSON('fetchPersonalTrainerAttendance',{personalTrainerId : personalTrainerId}).done(function(data){
				
				if(data.personalTrainerDetailsList[0] != undefined){
					
					assignData(data.personalTrainerDetailsList[0]);
					
				}
					else
						$("#message").text("Personal Trainer Id is not Registered. Please Enter Valid Personal Trainer Id...").show();
					})
					.fail(function(jqxhr, textStatus, error) {
						$("#message").text("Error While Fetching. Please Try Again...").show();
					});
				}
				else
					$("#message").text("Personal Trainer Id is not valid. Please Enter Valid Personal Id...(ex. M1,M2)").show();
			};
			//Assign Data
			var assignData = function(personalTrainerData){
				
				$("#personalTrainerAutocomplete").val(personalTrainerData.firstNamePT+" "+personalTrainerData.middleNamePT+" "+personalTrainerData.lastNamePT);
				$("#contactNoPT").val(personalTrainerData.contactNoPT);
			};
			//Clear All Data
			var clearForm = function(){
				$("#message").hide();
				$("#personalTrainerAutocomplete").val("");
				$("#contactNoPT").val("");
			};
</script>
<body>
<s:form id="personalTrainerAttendanceBetweenDateById" theme="css_xhtml">
	<fieldset>
		<legend>Personal Trainer Attendance Between Date By Id</legend>
		<table>
			<tr>
				<td><label>Personal Trainer Name</label></td>
				<td><label>Personal Trainer Id<span class="required">*</span></label></td>
				<td><label>Contact No.</label></td>
				<td><label>From Date<span class="required">*</span></label></td>
				<td><label>To Date<span class="required">*</span></label></td>
			</tr>
			<tr>
				<td><s:textfield name="personalTrainerAutocomplete" id="personalTrainerAutocomplete" 
								 placeholder="First Name Middle Name Last Name" cssStyle="width: 250px;"/></td>
				<td><s:textfield name="personalTrainerId" id="personalTrainerId" onkeyup="upperCase(this);" /></td>
				<td valign="top"><s:textfield name="contactNoPT" id="contactNoPT" value="" /></td>
				<td><s:textfield id="fromDate" name="fromDate" value=""/></td>
				<td><s:textfield id="toDate" name="toDate" value=""/></td>
		</table>
		
				<s:submit id="print" value="Print Details" align="center" action="printPTAttendanceBetweenDateById"></s:submit>
		
	</fieldset>
</s:form>
</body>
</html>