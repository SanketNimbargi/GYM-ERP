<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Pranjali Deshmukh
	 Date: 04/12/2014
	 Purpose: Member search
-->

<script type="text/javascript">

	$("#document").ready(function() {
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
		$("#lastName").val(data.lastName);
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
		$("#imageMember").remove();
		$("#message").show();
		$("#update").attr("disabled", true);
		$("#joiningDate").val("");
		$("#lastName").val("");
		$("#firstName").val("");
		$("#middleName").val("");
		$("#gender").val("");
		$("#dateOfBirth").val("");
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
		$("#memberId").val(0);
		$("#age");
		$("#memberContactNoAutocomplete").val("");
	};
	
	/* function fetchMemberDetails() {
		autoCompleteSearchMember("memberContactNoAutocomplete");
	} */
</script>

<s:head />
</head>
<body>

	<s:form id="searchMember" theme="css_xhtml"  method="post" enctype="multipart/form-data">
		<!-- 	<div style="width: 90%;"> -->
	<div style="width: 90%;margin-left: 5%;">
			<fieldset>
				<legend>Search Member Information</legend>

				<table>
					<tr>
						<td style="margin-left: 20px;"><label>Member Id<span
								class="required">*</span></label></td>
						<td colspan="2" >Contact Number</td>
						<td><label>Joining Date<span class="required">*</span></label></td>
						<td><label>Date of Birth<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:hidden name="memberId" id="memberId" value="" /> 
						<s:textfield
								name="displayMemberId" id="displayMemberId" value="M%{memberId}"
								onkeyup="upperCase(this);"  placeholder="M1" /></td>
						<td colspan="2"><s:textfield id="memberContactNoAutocomplete" name="memberContactNoAutocomplete" 
							placeholder="Contact Number" onkeyup="fetchMemberDetails();"/></td>
						<td><s:textfield name="joiningDate" id="joiningDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield></td>
							<td><s:textfield name="dateOfBirth" id="dateOfBirth" value="" />
					</tr>
				</table>
				<hr />
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
							<%-- <div ng-controller="UploadController" id="updateImage" style="width: 100px; display: none;">
								<i ng-hide="imageSrc">No image Selected</i>
								<img ng-src="{{imageSrc}}" width="80" height="90" />
								<s:file ng-file-select="onFileSelect($files)" id="userImage"
									name="userImage" cssStyle="width: 70px; margin:0 auto;" />
							</div> --%>
							<div id="image" class="gallery-item" style="width: 100px;"></div>
						</td>
					</tr>
					<tr>
						<td><label>Gender<span class="required">*</span></label></td>
						
							<td><label>Age<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:select name="gender" id="gender"
								cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" headerKey="" headerValue="Select Gender"/></td>
						
						<td><s:textfield name="age" id="age" value="" />
					</tr>
					<tr height="40px;"></tr>
				</table>
				<hr />
				<table>
					<tr>
						<td><label>Personal Trainer</label></td>
						<td> <%--  <s:textfield name="ptNameList" id="personalTrainerId" value="" />  --%>
						   <s:select id="personalTrainerId" name="ptNameList" headerKey="0" 
							headerValue="Select PT" cssStyle="width:140px;" list="ptNameMap" value="" />   </td>
					</tr>

				</table>
			</fieldset>
			<fieldset>
				<legend>Contact Details</legend>
				<table>
					<tr>
						<td><label>Residential Address<span class="required">*</span></label></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td><label>Alternate Contact No.</label></td>
						<td><label>E-Mail Id</label></td>
					</tr>
					<tr>
						<td><s:textarea name="address" id="address"
								onkeyup="sentenceCase(this);" value="" /></td>
						<td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
						<td valign="top"><s:textfield name="alternateContactNo"
								id="alternateContactNo" value="" /></td>
						<td colspan="2"><s:textfield name="emailId" id="emailId"
								value="" cssStyle="width:180px;"></s:textfield></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
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
			<%-- <fieldset>
				<s:submit align="center" action="searchMemberDetails" id="update" value="Update" />
			</fieldset>
			<s:token /> --%>
		</div>
	</s:form>
	<script>
	onMemberIdChange();
	</script>
</body>
</html>