<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Gavate Yogesh 
	 Date: 4/09/2014
	 Purpose: Member body Details 
-->

<!--***********Start java Script ********************************-->

<script type="text/javascript">
	$("#document").ready(function(){
		//Datepicker
		$("#fromDate").datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd',
			onClose: function( selectedDate ) {
				 $( "#toDate" ).datepicker( "option", "minDate", selectedDate );
				 }
		});
		
		 $("#memberRegistrationDetails").validate({
			debug : true,
			rules : {
				"fromDate":{required:true},
				"toDate":{required:true},
				"status":{required:true},
				"bmiFees":{required:true}
			},
			messages : {
				"fromDate":{required:"Enter Date From"},
				"toDate":{required:"Enter Date of To"},
				"status":{required:"Select Member Status"},
				"bmiFees":{required:"Enter Minimum Amt"}
			},
			submitHandler : function(form) {
				form.submit();
			}
		});  
	});
</script>
<<script type="text/javascript">
$("#document").ready(function() {
	         

	$("#membersNameAutocomplete").val("");
	$("#segmentalSubFat").val("");
	$("#bodyMassIndex").val("");
	$("#fromDate").val("");
	$("#legs").val("");
	$("#arms").val("");
	$("#segmentalSkMuscle").val("");
	$("#sktrunk").val("");
	$("#sklegs").val("");
	$("#skarms").val("");
	$("#height").val("");
	$("#weight").val("");
	$("#restingMetabolism").val("");
	$("#visceralFatLevel").val("");
	$("#bodyAge").val("");
	$("#trunk").val("");
	$("#bodyFat").val("");
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
	/* //Datepicker
	$('#dateOfBirth').datepicker({
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd/mm/yy',
		yearRange : '1950:2050',
		maxDate: "-5Y",
			onSelect: function(value, ui) {
				var formate = value.split("/");
		        var today = new Date();
				value=formate[1]+"/"+formate[0]+"/"+formate[2];
		          var  dob = new Date(value);
		            var age = new Date(today - dob).getFullYear() - 1970;
		        $("#age").val(age);
		    },
		  
			
		});
		//Age Calculate
		$("#dateOfBirth").change(function(){
			var formate = this.value.split("/");
	        var today = new Date();
			value=formate[1]+"/"+formate[0]+"/"+formate[2];
	          var  dob = new Date(value);
	            var age = new Date(today - dob).getFullYear() - 1970;
	        $("#age").val(age);
		});
	$('#startDatePT').datepicker({
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd/mm/yy',
		yearRange : '1950:2050'
	});
	//Datepicker
	$('#endDatePT').datepicker({
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd/mm/yy',
		yearRange : '1950:2050'
	}); 
	//Validation for form
	 $("#updateMemberRegistration").validate({
		debug:true,
		rules:{
			"joiningDate":{required:true ,checkDate:true},
			"memberId":{required:true},
			"lastName":{required:true ,textOnly:true,nameText:true},
			"firstName":{required:true ,textOnly:true,nameText:true},
			"middleName":{textOnly:true,nameText:true},
			"gender":{required:true},
			"dateOfBirth":{required:true ,checkDate:true},
			"address":{required:true},
			"contactNo":{required:true,checkMobilNo:true},
			"emailId":{checkMail:true},
		},
		messages:{
			"joiningDate":{required:"Enter Joining Date"},
			"memberId":{required:" Select Member ID"},
			"lastName":{required:"Enter Last Name"},
			"firstName":{required:"Enter First Name"},
			"dateOfBirth":{required:"Enter Date of Birth"},
			"address":{required:"Enter Residential Address"},
			"contactNo":{required:"Enter Contact No."},
			"gender":{required:true},
		},
		submitHandler:function(form){
			form.submit();
		}
	}); */
	$("#membersNameAutocomplete").keyup(function(){			
		autoCompleteBothMembers("membersNameAutocomplete","displayMemberId",onMemberIdChange);
	});
	//Auto Complete for Search By Contact Number
	autoCompleteSearchMember("memberContactNoAutocomplete","displayMemberId",onMemberIdChange);
	
	// fetch member details
	$("#displayMemberId").blur(function(){
		onMemberIdChange();							//Fetch Members Details On Change of Member Id
	});
	
	// onclick function on image
	/* $("#image").click(function (){
		$("#imageMember").hide();
		$("#updateImage").show();
	}); */
}); //End of document.ready

//Function to Fetch Members Details On Change of Member Id
var onMemberIdChange = function(){
	//alert("hi...");
	var fetchMemberId = $("#displayMemberId").val().substring(1);
	var checkMemberString=$("#displayMemberId").val().substring(0,1);
	$("#member").val(fetchMemberId);
	clearForm();
	if(fetchMemberId > 0 && checkMemberString == 'M')
	{
		$("#memberId").val(parseInt(fetchMemberId));
		$.getJSON('fetchMemberDetails',{fetchMemberId : fetchMemberId}).done(function(data){
			
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
	$("#message").hide();
	$("#update").attr("disabled",false);
	$("#joiningDate").val(convertToUserDate(data.joiningDate)); 
	
	var firstname=data.firstName;
	 var lastName=data.lastName;
	 
	$("#membersNameAutocomplete").val(firstname+" "+lastName);
	$("#firstName").val(data.firstName);
	$("#middleName").val(data.middleName);
	$("#gender").val(data.gender);
	$("#dateOfBirth").val(convertToUserDate(data.dateOfBirth));
	$("#address").val(data.address);
	$("#age").val(data.age);
	$("#contactNo").val(data.contactNo);
	$("#alternateContactNo").val(data.alternateContactNo);
	$("#emailId").val(data.emailId);
	$("#height").val(data.height);
	$("#weight").val(data.weight);
	$("#chest").val(data.chest);
	$("#bicep").val(data.bicep);
	$("#personalTrainerId").val(data.ptNameList);
	$("#tricep").val(data.tricep);
	$("#memberContactNoAutocomplete").val(data.contactNo);
	$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image" alt="Image Not Added" />');
};

//Clear Form
var clearForm = function() {
	


};

/* function fetchMemberDetails() {
	autoCompleteSearchMember("memberContactNoAutocomplete");
} */
</script>

<!--************************************************************* -->
<!--************Start Body here********************************** -->
	
	<s:form id="memberRegistrationDetails" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Member Body Details </legend>
				<table>
					<tr>
					<td><label> Member Id<span class="required">*</span></label></td>
					<td><s:hidden name="member" id="memberId" /> 
						
						<s:hidden name="idMember" id="member"/>
						
						<s:textfield
								name="displayMemberId" id="displayMemberId"
								onkeyup="upperCase(this);"  placeholder="M1" /></td>
					                <td><label>Name of Member</label></td>
 
 <td colspan="2"><s:textfield id="membersNameAutocomplete" name="memberName" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>	
						<%-- <td><s:textfield name="memberName" id="memberName"
								placeholder="member Name"  /></td> --%>
								<td><label> Date<span class="required">*</span></label></td>
								<td><s:textfield id="fromDate" name="fromDate"/></td>
												<td align="center" rowspan="4" height="120px;">
							
							
					</tr>
						<tr>
						
						<td><label> Height<span class="required">*</span></label></td>
						<td><s:textfield name="height" id="height"
								 /></td>
	                        <td><label>Weight<span class="required">*</span></label></td>
						<td><s:textfield name="weight" id="weight"
								  /></td>
								<td><label> Body Mass Index<span class="required">*</span></label></td>
								<td><s:textfield id="bodyMassIndex" name="bodyMassIndex"/></td>
								<td><label> Body Fat %<span class="required">*</span></label></td>
								<td><s:textfield id="bodyFat" name="bodyFat"/></td>
												<td align="center" rowspan="4" height="120px;"></td>
							
						
					</tr>
					<tr>
						
						<td><label> Segmental Subcutaneous Fat %  Whole Body</label></td>
						<td><s:textfield name="segmentalSubFat" id="segmentalSubFat"
								 /></td>
	                        <td><label>Trunk</label></td>
						<td><s:textfield name="trunk" id="trunk"
								  /></td>
								<td><label> Legs</label></td>
								<td><s:textfield id="legs" name="legs"  /></td>
								<td><label>Arms</label></td>
								<td><s:textfield id="arms" name="arms" /></td>
												<td align="center" rowspan="4" height="120px;"></td>
							
						
					</tr>
					<tr>
						
						<td><label> Segmental Skeletal Muscle %  Whole Body</label></td>
						<td><s:textfield name="segmentalSkMuscle" id="segmentalSkMuscle"
								 /></td>
	                        <td><label>Trunk</label></td>
						<td><s:textfield name="sktrunk" id="sktrunk"
								  /></td>
								<td><label> Legs</label></td>
								<td><s:textfield id="sklegs" name="sklegs"  /></td>
								<td><label>Arms</label></td>
								<td><s:textfield id="skarms" name="skarms" /></td>
												<td align="center" rowspan="4" height="120px;"></td>
							
						
					</tr>
					<tr>
						
						<td><label> Resting Metabolism/</label></td>
						<td><s:textfield name="restingMetabolism" id="restingMetabolism"
								 /></td>
	                        <td><label>Visceral Fat Level</label></td>
					<td><s:textfield name="visceralFatLevel" id="visceralFatLevel" /></td>
					<td><label> Body Age </label></td>
								<td><s:textfield id="bodyAge" name="bodyAge"  /></td>
					
					<td><label> BMI Fees<span class="required">*</span> </label>
					</td><td align="center" rowspan="4" height="120px;"></td>
					<td><s:textfield id="bmiFees" name="bmiFees"  value=""/></td>			
												 
							
						
					</tr>
				</table>
	
				<s:submit id="print" value="SaveDetails" action="saveMemberDetail" align="center"/>
			</fieldset>
		</div>
	</s:form>