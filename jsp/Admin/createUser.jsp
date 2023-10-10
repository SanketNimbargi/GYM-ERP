<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Gavate Yogesh
	 Date: 14/09/2014
	 Purpose:Creating User	 
-->

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register New User</title>

<script type="text/javascript">
	$(document).ready(function() {		
		$("#moduleTable").DataTable({});
		$("#SysUserTable").DataTable({});	
		//Datepicker
		$('#date').datepicker({
			changeMonth : true,
			changeYear : true,
			dateFormat : 'dd/mm/yy',
			yearRange : '1950:2050'
		});
		//Set Focus on name textfield
		$("#name").focus();

		//Fields Validation
		$("#userForm").validate({
			debug : true,
			rules : {
				"name" : "required",
				"userName" : "required",
				"password" : {required : true, minlength : 6},
				"conformPassword" : {required : true, equalTo : "#password" },
				"mobileNo" : { required : true, number : true, maxlength : 10, minlength : 10},
				"dateOfBirth":{required:true ,checkDate:true},
				"address" : "required"
			},
			messages : {
				"name" : "Enter Name",
				"userName" : "Enter User Name",
				"password" : "Enter Password minmum six digit password",
				"conformPassword" : { required : "Enter Conform Password", equalTo : "Password does Not match" },
				"mobileNo" : { required : "Enter Phone number", number : "Enter Numbers only",
						maxlength : "Enter 10 Digit Valid Mobile No.", minlength : "Enter 10 Digit Valid Mobile No." },
				"date":{required:"Enter Date of Birth"},
				"address" : "Enter Address"
			},
			submitHandler : function(form) {				
				form.submit();
			}
		});
		
		
		$("#userType").change(function(){			
			if($(this).val()=='Admin'){						
				$('input:checkbox').prop('checked', true);	
				makeListOfUserRoles();
				$('input:checkbox').attr("onclick","return false").prop("disabled","true");				
				return;
			}else{			
				clearAllCheckBox();			
			}
			
		});
		//Ajax To Check User Name is already registered or not
		//checkAvailable("checkUser","userName","User is Already Registered.");	
		$("#editUser").click(function(){			
			$.getJSON('fetchSystemUserDetails',{}).done(function(data)
			{
				$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
				var userDetailsDiv = $("#userDetailsDiv");
				userDetailsDiv.empty();
				var fieldset = $('<fieldset><legend>User Details</legend></fieldset>').appendTo(userDetailsDiv);
				var table = $('<table class="display" id="SysUserTable">'
				+'<thead><tr height="30px" bgcolor="CACECF"><th>User Id</th><th>Name</th><th>User Name</th><th>User Type</th>'
				+'<th style="display:none;"></th><th style="display:none;"></th><th style="display:none;"></th><th style="display:none;">'
				+'</th><th style="display:none;"></th><th style="display:none;"></th><th style="display:none;"></th><th style="display:none;"></th></tr></thead></table>').appendTo(fieldset);
				
				if(data.systemUserList[0]!='undefined' || data.systemUserList.length!=0){
					for(var i=0;i<data.systemUserList.length;i++){  // 
						var tr= $('<tr onclick="editUserDetails(this);" id="'+(i+1)+'" class="rowColor"><td>'+(i+1)+'</td><td>'+data.systemUserList[i].name+'</td>'
						+'<td>'+data.systemUserList[i].userName+'</td><td>'+data.systemUserList[i].userType+'</td>'
						+'<td style="display:none;">'+data.systemUserList[i].password+'</td>'						
						+'<td style="display:none;">'+data.systemUserList[i].mobileNo+'</td>'
						+'<td style="display:none;">'+convertToUserDate(data.systemUserList[i].date)+'</td>'
						+'<td style="display:none;">'+data.systemUserList[i].address+'</td>'						
						+'<td style="display:none;">'+data.systemUserList[i].userName+'</td>'
						+'<td style="display:none;">'+data.systemUserList[i].userId+'</td>'
						+'<td style="display:none;">'+data.systemUserList[i].id+'</td>'
						+'<td style="display:none;">'+data.systemUserList[i].isDelete+'</td></tr>').appendTo(table);	
						//$('<a href="#TOP"></a>').appendTo(tr);
					}
					
					$("#SysUserTable").DataTable({});					
				}else{
					$("#message").text("No User Found.").show();
				}		
				
			}).fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching SystemUserDetails. Please Try Again...").show();				
			});					
			$("#editUser").hide();	
			$("#saveUser").hide();			
			$("#createUser").show();			
			$("#updateUser").show();
			$("#removeUser").show();
			clearAllCheckBox();
		});		
		$("#createUser").click(function(){			
			resetFunction();
		});
		
	
	});
	var editUserDetails = function($this){	
		clearAllCheckBox();
		$('.rowColor').css("background", "");
		$($this).css("background", "linear-gradient(rgb(170, 150, 170), rgb(100, 150, 100))");
		if($($this).find("td").eq(3).text()=='Admin'){						
			$('input:checkbox').prop('checked', true);	
			makeListOfUserRoles();
			$('input:checkbox').attr("onclick","return false").prop("disabled","true");
			$("#updateUser").hide();
			//return;
		}else{	
		$('input:checkbox').attr("onclick","return true").prop("disabled", false);		
		$("#updateUser").show();
		}
		var userId = parseInt($($this).find("td").eq(9).text().replace(/\s/g, ''));			
		//var userRolesList=$('#userRolesList');
	//	userRolesList.empty();
		$.getJSON('fetchSystemUserRoleDetails',{userId:userId}).done(function(data)
		{		
			if(data.userRoleList[0]!='undefined' || data.userRoleList.length!=0){								
					for(var i=0;i<data.userRoleList.length;i++){  
						//alert(data.userRoleList[i].objectType);
						 $('input:checkbox[id="'+data.userRoleList[i].objectType+'"]').prop( 'checked',true );									 
					//	 $('<input type="text" name="data.userRoleList["'+i+'"].roleId" id="roleId'+i+'" value="'+data.userRoleList[i].objectType+'" />').appendTo(userRolesList);
	
					}					
			}
			$("#name").val($($this).find("td").eq(1).text());
			$("#userName").val($($this).find("td").eq(2).text());
			$("#userType").val($($this).find("td").eq(3).text());
			$("#password").val($($this).find("td").eq(4).text());
			$("#conformPassword").val($($this).find("td").eq(4).text());
			$("#mobileNo").val($($this).find("td").eq(5).text());
			$("#dateOfBirth").val($($this).find("td").eq(6).text());
			$("#address").val($($this).find("td").eq(7).text());
			$("#id").val($($this).find("td").eq(10).text());
			$("#userId").val(userId);
			makeListOfUserRoles();
		});	
		
	 
};	
var clearAllCheckBox = function(){
	$('input:checkbox').prop('checked', false).removeAttr("checked");
	$('input:checkbox').attr("onclick","return true").prop("disabled", false);
	//$('input:checkbox').attr("onclick","return true").attr("disabled","false");
	$('#userRolesList').empty();
};
var resetFunction = function(){
	var userDetailsDiv = $("#userDetailsDiv");
	userDetailsDiv.empty();
	$("#editUser").show();	
	$("#saveUser").show();			
	$("#createUser").hide();			
	$("#updateUser").hide();
	$("#removeUser").hide();
	$("#userId").val("");
	clearAllCheckBox();	
};
 var makeListOfUserRoles=function(){
	 var userRolesList=$('#userRolesList');
	 userRolesList.empty();
	 var id = [];
		$(':checkbox:checked[name^=check]').each(function(i){
			id[i] = $(this).val();
	    	{    		
				$('<div><input type="text" name="userRole['+i+'].objectType" id="objectType'+i+'" value="'+id[i]+'" /></div>').appendTo(userRolesList);
	    		
	    	}
		});	
 };
</script>
<s:head />
</head>
<body>

	
<s:form id="userForm" name="userForm" theme="css_xhtml">	
<a href="#BOTTOM" style="font-size: 22px;"> Go To Bottom</a>
<a id="TOP"></a>
	<div style="width: 800px; margin: auto;">
		<!-- <fieldset style="float: left; margin-top: 20px"> -->
		<fieldset style="margin-top: 20px">
			<legend>
				<img src="<%=request.getContextPath()%>/images/newuser.jpg"
					height="32" width="30" /> Register New User
			</legend>				
					<table width="95%">
						<tr><td>
						<table>
						<s:textfield name="userId" id="userId" value="" style="display:none;"/>
							<s:textfield name="id" id="id" value="" style="display:none;"/>
							<tr>
							
								<td><label>Name<span  class="required">*</span> </label></td>
								<td><s:textfield name="name" id="name" value="" /></td>
								<td><label>User Name<span  class="required">*</span></label></td>
								<td id="checkAvailable"><s:textfield name="userName" id="userName" value="" /></td>
							</tr>
							<tr>
								<td><label>Password <span  class="required">*</span></label></td>
								<td><s:password name="password" id="password" value="" /></td>
								<td><label>Confirm Password<span  class="required">*</span></label></td>
								<td><s:password name="conformPassword" id="conformPassword" value="" /></td>
							</tr>
							<tr>
								<td><label>User Type </label></td>
								<td><s:select name="userType" id="userType" cssStyle="width:140px;" value=""
										headerKey="-1" headerValue="--- Select---" list="#{'User':'User','Admin':'Admin'}" /></td>
								<td><label>Mobile No.<span  class="required">*</span></label></td>
								<td><s:textfield name="mobileNo" id="mobileNo" value=""/></td>
							</tr>
							<tr>
								<td><label>Address <span  class="required">*</span></label></td>
								<td><s:textarea name="address" id="address" cols="20" onkeyup="firstCharWordUpper(this);" value="" /></td>
								<td><label>Date </label></td>
								<td><s:textfield name="date" id="date" >
									<s:param name="value">
									<s:date name="new java.util.Date()" format="dd/MM/yyyy" />
								</s:param>
								</s:textfield></td>
							</tr>
						</table>	
						</td>
						
						</tr>
						<tr>
						<td>
						<jsp:include page="/jsp/Admin/userAuthorization.jsp"/>
						</td>
						
						</tr></table>						
			
		</fieldset>
		<fieldset>
			<table>
				<tr>
					<td><s:submit action="saveUserDetails"  value="Save New User" id="saveUser" cssClass="mybtn" /></td>
					<td><s:submit action="updateUserDetails" value="Update User" cssClass="mybtn" id="updateUser" style="display:none;"/></td>
					<td style="padding-left: 10px;"><s:submit action="removeUserDetails" value="Remove User" cssClass="mybtn" id="removeUser" style="display:none;"/></td>
					
					<%-- <td><s:submit  action="updateUserDetails" value="Update" id="update" cssClass="myButton" /></td> --%>
								
					<td style="padding-left: 10px;"><input type="button" id="editUser" value="Edit Old User" class="mybtn" /></td>
					<td style="padding-left: 10px;"><input type="button"  value="Creat New User" id="createUser" class="mybtn" style="display:none;"/></td>
								
					<td style="padding-left: 10px;"><s:reset id="reset" cssClass="mybtn" onclick="resetFunction();" /></td>				
				</tr>
				</table>
		</fieldset>
		<div id="userDetailsDiv">		
		<!-- Existing User table -->
		</div>
		<a id="BOTTOM"></a>
		<div id="userRolesList" style="display:none;" >	
		<!-- User Role List Table -->	
		</div>	
		</div>		
		<s:token />	
		<a href="#TOP" style="font-size: 22px;"> Go To Top</a>
	</s:form>	
	
</body>
</html>

