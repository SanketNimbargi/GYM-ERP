<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- Developed by: Pranjali Deshmukh
	 Date: 12/09/2014
	 Purpose: Attendance List Details Between Date using Id 
-->

<!--***********Start java Script ********************************-->

<script type="text/javascript">
	$("#document").ready(function(){
		//Datepicker
		$("#fromDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#toDate" ).datepicker( "option", "minDate", selectedDate );
				 }
		});
		//Datepicker
		$("#toDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			onClose: function( selectedDate ) {
				 $( "#fromDate" ).datepicker( "option", "maxDate", selectedDate );
				 }
		});
		
				
		//Validation for form
		$("#attendancelistDetailsbetweendatebyId").validate({
			debug : true,
			rules : {
				"memberId":{required:true ,checkMemberId:true},
				"fromDate":{required:true ,checkDate:true},
				"toDate":{required:true ,checkDate:true},
			},
			messages : {
				"memberId":{required:"Enter Member ID"},
				"fromDate":{required:"Enter Date From"},
				"toDate":{required:"Enter Date of To"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		}); 
		
		//Auto Complete for Search By Member Name
		//autoComplete("membersNameAutocomplete","memberId",onMemberIdChange);
		$("#membersNameAutocomplete").keyup(function(){			
			autoComplete("membersNameAutocomplete","memberId",onMemberIdChange);
		});
		 //Auto Complete for Search By number
		autoCompleteSearchMember("contactNo","memberId",onMemberIdChange);
		 
		// fetch member details
		$("#memberId").change(function(){
			onMemberIdChange();						//Fetch Members Details On Change of Member Id
		});
		
	});
	var onMemberIdChange = function(){
		
		var memberId=$("#memberId").val().substring(1);
		var checkMemberString=$("#memberId").val().substring(0,1);
		if(memberId > 0 && checkMemberString == 'M')
		{
			$.getJSON('fetchMemberAttendance',{memberId : memberId}).done(function(data){		//Json To Fetch Data
				if(data.memberDetailsList[0] != undefined)
					assignData(data.memberDetailsList[0],data.attendanceDetailsList[0]);
				else
					$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
				
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
	};
	//Assign Data
	var assignData = function(memberData,attendanceData){
		$("#membersNameAutocomplete").val(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
		$("#contactNo").val(memberData.contactNo);
		
	};
	//Clear all Data
	var clearForm = function(){
		$("#message").hide();
		$("#membersNameAutocomplete").val("");
		$("#contactNo").val("");
	};
	</script>
	
	<s:form id="attendancelistDetailsbetweendatebyId" theme="css_xhtml" >
		<div>
			<fieldset>
				<legend>Attendance Details Between Date By Id</legend>
				<table>
					<tr>
						<td><label>Member Name</label></td>
						<td><label>Member Id<span class="required">*</span></label></td>
						<td><label>Contact No.</label></td>
						<td><label>From Date<span class="required">*</span></label></td>
						<td><label>To Date<span class="required">*</span></label></td>
					</tr>
					<tr>
					<td><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><s:textfield id="memberId" name="memberId" onkeyup="upperCase(this);"/></td>
						 <td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
						<td><s:textfield id="fromDate" name="fromDate"/></td>
						<td><s:textfield id="toDate" name="toDate"/></td>
					</tr>
				</table>
	
				<s:submit id="print" value="GetDetails" align="center" action="printattendanceListBetweenDateById"/>
			</fieldset>
		</div>
	</s:form>