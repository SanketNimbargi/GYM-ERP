<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Gavate Yogesh
	 Date: 01/10/2014
	 Purpose: Member measurement card
-->
<!--*************Script Start Here**********************************  -->
<script type="text/javascript">
$("#document").ready(function() {
	
	 $("#year").val($("#joiningDate").val().substring(6)); 
	
	//validation
	 $("#memberMeasurementCard").validate({
			debug:true,
			rules:{
				"joiningDate":{required:true ,checkDate:true},
				"neck":{number:true},
				"shle":{number:true},
				"arms":{number:true},
				"wrist":{number:true},
				"chest":{number:true},
				"chestIn":{number:true},
				"waist":{number:true},
				"lowAbs":{number:true},
				"hips":{number:true},
				"thighs":{number:true},
				"calf":{number:true},
				"ankle":{number:true},
				"totalInchLoss":{number:true},
				"wtLoss":{number:true},
				"month":{required:true ,textOnly:true,nameText:true},
			},
			messages:{
				"joiningDate":{required:"Select date"},
				"neck":"Enter the number",
				"shle":"Enter the number",
				"arms":"Enter the number",
				"wrist":"Enter the number",
				"chest":"Enter the number",
				"chestIn":"Enter the number",
				"waist":"Enter the number",
				"lowAbs":"Enter the number",
				"hips":"Enter the number",
				"thighs":"Enter the number",
				"calf":"Enter the number",
				"ankle":"Enter the number",
				"totalInchLoss":"Enter the number",
				"wtLoss":"Enter the number",
				"month":{required:true ,textOnly:true,nameText:true},
			},
			submitHandler:function(form){
				form.submit();
			}
		});  
	//Datepicker
	$('#joiningDate').datepicker({
		changeMonth : true,
		changeYear : true,
		dateFormat : 'dd/mm/yy',
		yearRange : '1950:2050',
		maxDate: "0",
		onClose: function(date){
			$("#year").val(date.substring(6));
		}
	});

	//Auto Complete for Search By Member Name
	autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
	
	// fetch member details
	$("#displayMemberId").blur(function(){
		onMemberIdChange();							//Fetch Members Details On Change of Member Id
	});
	
	// onclick function on image
	$("#image").click(function (){
		$("#imageMember").hide();
		$("#updateImage").show();
	});
}); //End of document.ready

//Function to Fetch Members Details On Change of Member Id
var onMemberIdChange = function(){
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
	/* $("#joiningDate").val(convertToUserDate(data.joiningDate));  */
	$("#lastName").val(data.lastName);
	$("#firstName").val(data.firstName);
	$("#middleName").val(data.middleName);
	$("#gender").val(data.gender);
	$("#age").val(data.age);
	$("#height").val(data.height);
	$("#weight").val(data.weight);
	$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
	$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image" alt="Image Not Added" />');
};

//Clear Form
var clearForm = function() {
	$("#imageMember").remove();
	$("#joiningDate").val("");
	$("#lastName").val("");
	$("#firstName").val("");
	$("#middleName").val("");
	$("#gender").val("");
	$("#height").val("");
	$("#weight").val("");
	$("#imageMember").remove();
	$("#memberId").val(0);
	$("#age");
	$("#membersNameAutocomplete").val("");
};

</script>
<!-- **********************body Start here************************* -->
<s:form id="memberMeasurementCard" name="memberMeasurementCard" theme="css_xhtml"  method="post" enctype="multipart/form-data">
		<div style="width: 90%;">
			<fieldset>
				<legend>Member Measurement card</legend>

				<table>
					<tr>
						<td style="margin-left: 20px;"><label>Member Id<span
								class="required">*</span></label></td>
						<td style="width: 320px;" colspan="2" >Member Name</td>
						<td><label>Date<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:hidden name="memberRegistrationModel.memberId" id="memberId" value="" /> 
						<s:textfield
								name="displayMemberId" id="displayMemberId" value=""
								onkeyup="upperCase(this);"  placeholder="M1" /></td>
						<td colspan="2"><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><s:textfield name="joiningDate" id="joiningDate">
								<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
							</s:textfield></td>
					</tr>
				</table>
				<hr />
				<table>
					<tr>
						<td><label>Name of Member<span class="required">*</span></label></td>
						
						<td><s:textfield name="firstName" id="firstName"
								placeholder="First Name" onkeyup="upperCase(this);" value="" readonly="true" /></td>
						<td><s:textfield name="middleName" id="middleName"
								placeholder="Middle Name" onkeyup="upperCase(this);" value="" readonly="true"/></td>
							<td><s:textfield name="lastName" id="lastName"
								placeholder="Last Name" onkeyup="upperCase(this);" value="" readonly="true" /></td>

						<td align="center" rowspan="4" height="120">
							<div ng-controller="UploadController" id="updateImage" style="width: 100px; display: none;">
								<i ng-hide="imageSrc">No image Selected</i>
								<img ng-src="{{imageSrc}}" width="80" height="90" />
								<s:file ng-file-select="onFileSelect($files)" id="userImage"
									name="userImage" cssStyle="width: 70px; margin:0 auto;" />
							</div>
							<div id="image" class="gallery-item" style="width: 100px;"></div>
						</td>
					</tr>
					<tr>
						<td><label>Gender<span class="required">*</span></label></td>
							<td><label>Age<span class="required">*</span></label></td>
							<td><label>Height </label></td>
						<td><label>Weight</label></td>
					</tr>
					<tr>
						<td><s:textfield name="gender" id="gender" readonly="true" /></td>
						<td><s:textfield name="age" id="age" value="" readonly="true"/>
						<td><s:textfield name="height" id="height"
								cssStyle="width:90px;" value="" readonly="true"/></td>
						<td><s:textfield name="weight" id="weight"
								cssStyle="width:90px;" value="" readonly="true"/></td>
					</tr>
					<tr height="40px;"></tr>
				</table>
				<hr />
			</fieldset>
			</div>
			<div style="width: 90%;">
			<fieldset>
			<table>
			<tr>
			<%--  <td><label>Measurement Date<span class="required">*</span></label></td> --%>
			  <td><label>Month<span class="required">*</span></label></td>
			  <td><s:select name="month" id="month"
								cssStyle="width:140px;"
								list="#{'jan':'January','Feb':'February','Mar':'March','April':'April','May':'May',
								'June':'June','July':'July','Aug':'August','Sep':'September'
								,'Oct':'October','Nov':'November','Dec':'December'}" /></td>
				<td><label>Year<span class="required">*</span></label></td>
				 <td><s:textfield name="year" id="year" cssStyle="width:90px;" value="" readonly="true" /></td>
			</tr>
			<tr>
			<td><label>Neck</label></td>
			<td><label>Shl</label></td>
			<td><label>Arms</label></td>
			<td><label>Form Arm</label></td>
			 </tr>
		   <tr>
		     <td><s:textfield name="neck" id="neck" cssStyle="width:80px;" value="" placeholder="CM" /></td>
		       <td><s:textfield name="shle" id="shle" cssStyle="width:80px;" value="" placeholder="CM"/></td>
		       <td><s:textfield name="arms" id="arms" cssStyle="width:80px;" value="" placeholder="CM" /></td>
		        <td><s:textfield name="formArm" id="formArm" cssStyle="width:80px;" value="" placeholder="CM" /></td>
		         </tr>
		   <tr>
			<td><label>Wrist</label></td>
			<td><label>Chest</label></td>
			<td><label>Chest in</label></td>
			<td><label>UP Abs</label></td>
		   </tr>
		   <tr>
		     <td><s:textfield name="wrist" id="wrist" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		      <td><s:textfield name="chest" id="chest" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		       <td><s:textfield name="chestIn" id="chestIn" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		        <td><s:textfield name="upAbs" id="upAbs" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		         </tr>
		          <tr>
			<td><label>Waist</label></td>
			<td><label>Low Abs</label></td>
			<td><label>Hips</label></td>
			<td><label>Thighs</label></td>
		   </tr>
		   <tr>
		     <td><s:textfield name="waist" id="waist" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		      <td><s:textfield name="lowAbs" id="lowAbs" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		       <td><s:textfield name="hips" id="hips" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		        <td><s:textfield name="thighs" id="thighs" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		         </tr>
		           <tr>
			<td><label>calf</label></td>
			<td><label>ankle</label></td>
			<td><label>totalInchLoss</label></td>
			<td><label>Wt.Loss</label></td>
		   </tr>
		   <tr>
		     <td><s:textfield name="calf" id="calf" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		      <td><s:textfield name="ankle" id="ankle" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		       <td><s:textfield name="totalInchLoss" id="totalInchLoss" cssStyle="width:90px;" value="" placeholder="CM" /></td>
		       <td><s:textfield name="wtLoss" id="wtLoss" cssStyle="width:90px;" value="" placeholder="Kg" /></td>
		         </tr>
				</table>
			</fieldset>
			</div>
			<%-- <div style="width: 90%;">
			<fieldset>
			<table>
			 <tr>
			 <td><label>Facility Taken </label></td>
			 <td><s:textfield id="facilityTaken" name="facilityTaken"></s:textfield></td>
			  <td><label>Special Instruction</label></td>
			  <td><s:textarea name="instruction" id="instruction"></s:textarea></td>
			 </tr>
			</table>
			</fieldset>
			</div>
 --%>			
             <s:submit align="center" action="saveMemberMeasurementCard" id="save" name="save" value="Save" cssClass="smallBtn"></s:submit>
            
</s:form>
