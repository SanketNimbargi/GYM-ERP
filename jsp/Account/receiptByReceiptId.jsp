<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>


<!-- Developed by: Raju Sable
	 Date: 26/11/2016
	 Purpose: Search member details by all
-->
<!--***********Start java Script ********************************-->
<script type="text/javascript">
	$("#document").ready(function() {

		// fetch member details
		$("#displayMemberId").blur(function(){
			onMemberIdChange();							//Fetch Members Details On Change of Member Id
		});
		
		//Auto Complete for Search By Member Name
		//autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		$("#membersNameAutocomplete").keyup(function(){			
			autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
		});
		//Auto Complete for Search By number
		autoCompleteSearchMember("contactNo","displayMemberId",onMemberIdChange);
	});
	var onMemberIdChange = function(){
		$('<div class="errors" id="message" style="width: 530px;" style="display:none;"></div>').appendTo($("#errorContainer"));	

		var fetchMemberId = $("#displayMemberId").val().substring(1);
		var checkMemberString=$("#displayMemberId").val().substring(0,1);
		clearForm();
		if(fetchMemberId > 0 && checkMemberString == 'M')
		{
			$("#memberId").val(parseInt(fetchMemberId) );
			$.getJSON('fetchMemberDetailsWithreceipt',{memberId : fetchMemberId}).done(function(data){
				
				if(data.memberList[0] == undefined)
					$("#message").text("Member Id is not available. Please Enter Valid Member Id...").show();
				else{						
					if(data.memberList[0].status!='registered'){
						//alert("not reg.");
						$("#message").text("Member Id is not currently Registered. He is removed. ").show();						
					}
					recieptTable($("#recieptTable tbody"),data.recieptList);
					assignData(data.memberList[0]);
				}
			
				   
				
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
	};
	var assignData = function(data){
		//$("#message").hide();
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
		$("#personalTrainerId").val(data.personalTrainerId);
		$("#tricep").val(data.tricep);
		$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
		$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image" alt="Image Not Added" />');
	};
	
	var recieptTable = function(tableName,List){
		tableName.empty();
	
		if(List[0] == undefined){
			$("#message").text("No receipt Found").show();
			
		}else{
			
			for (var i = 0; i < List.length;) {
			
				var row = $('<tr></tr>').appendTo( tableName);
				for (var j = 0;j<10 && i < List.length; j++, i++) {
					var receiptType=List[i][0];
					var receiptNo=List[i][1]; //replace(/\s/g, '');	
					var finalReceiptNo=List[i][2];
					/*  if(receiptType=="final"){
						$('<td><input type="radio" style="width:30px;"  id="List'+i+'" name="receiptNo" value="'+receiptNo+'" onclick="showButton(\''+receiptType+'\');" on />'+receiptType+' '+finalReceiptNo+'</td>').appendTo(row);
					}else{
						$('<td><input type="radio" style="width:30px;"  id="List'+i+'" name="receiptNo" value="'+receiptNo+'" onclick="showButton(\''+receiptType+'\');" on />'+receiptType+' '+receiptNo+'</td>').appendTo(row);
					}  */	
					 if(receiptType=="final"){
						$('<td><input type="radio" style="width:30px;"  id="List'+i+'" name="receiptNo" value="'+receiptNo+'" onclick="showButton(\''+receiptType+'\');" on />'+receiptType+' '+receiptNo+'</td>').appendTo(row);
					}else{
						$('<td><input type="radio" style="width:30px;"  id="List'+i+'" name="receiptNo" value="'+receiptNo+'" onclick="showButton(\''+receiptType+'\');" on />'+receiptType+' '+receiptNo+'</td>').appendTo(row);
					} 
				/* $('<td>'+receiptType+' '+receiptNo+'</td>').appendTo(row); */
				}
			}	
			}
	};
	//show button
	var showButton =function(receiptType){
		var receipt=$('input:radio[name=receiptNo]:checked').val(); 	
		//alert(receipt+ "/"+receiptType);
		 if(receiptType=="final"){	//final			
			 $("#printReceipt").prop("name","action:printPreviousFinalReceipt");
			// $("#printReceipt").prop("value","Print FinalReceipt");
			 $("#printPreviousReceipt").show();
		 }else{//advance			 
			 $("#printReceipt").prop("name","action:printPreviousAdvanceReceipt");
			// $("#printReceipt").prop("value","Print AdvanceReceipt");
			 $("#printPreviousReceipt").show();
		 }			
		
		//$("#printReceipt").show();
	};
	//Clear Form
	var clearForm = function() {
		$("#imageMember").remove();
		$("#message").hide();
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
		$("#membersNameAutocomplete").val("");
	};
</script>


</head>
<body>
	<s:form id="receiptByReceiptId" theme="css_xhtml">
		<div>
			<fieldset>
				<legend>Receipt by Member ID</legend>
				<table>
					<tr>
					
						<td><label>MemberId No.</label></td>
						<td style="width: 320px;" colspan="2" >Member Name</td>
					</tr>
					<tr>
						<td><s:hidden name="memberId" id="memberId" value="" /> 
						<s:textfield
								name="displayMemberId" id="displayMemberId" value=""
								onkeyup="upperCase(this);"  placeholder="M1" /></td>
								<td colspan="2"><s:textfield id="membersNameAutocomplete" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
							<td><label>Contact No.<span class="required">*</span></label></td>
						<td valign="top"><s:textfield name="contactNo" id="contactNo"
								value="" /></td>
					</tr>
				</table>
				<table>
					<tr>
						<td width="140px"></td>
						<td width="140px"></td>
						<td width="140px"></td>

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
						<td><label>Date of Birth<span class="required">*</span></label></td>
							<td><label>Age<span class="required">*</span></label></td>
					</tr>
					<tr>
						<td><s:select name="gender" id="gender"
								cssStyle="width:140px;"
								list="#{'Male':'Male','Female':'Female'}" headerKey="" headerValue="Select Gender"/></td>
						<td><s:textfield name="dateOfBirth" id="dateOfBirth" value="" />
						<td><s:textfield name="age" id="age" value="" />
					</tr>
					<tr height="40px;"></tr>
				</table>
				<hr />
				
			</fieldset>
		</div>
		<fieldset>
		<table id="recieptTable">
		<tbody></tbody>
		</table>
		<%-- <table>
					<tr>
						<td><s:submit id="printReceipt" value="Print Receipt" action="printSavedFinalReceipt" style="display:none"/>
						<td>
					<tr>
				</table> --%>
		</fieldset>
		<fieldset id="printPreviousReceipt" style="display:none">
				<s:submit id="printReceipt" value="Print Receipt" align="center"/>
			</fieldset>
	</s:form>

</body>
</html>