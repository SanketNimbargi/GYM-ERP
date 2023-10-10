<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Shailesh Halor
	 Date: 14/07/2014
	 Purpose:Login
-->

<html>
<head>
<!-- <META HTTP-EQUIV="Refresh"> -->

<title><%= application.getAttribute("gym_name") %>	</title>
<!-- <link rel="icon" href="images/favicon.ico" type="image/x-icon">  -->
 <link rel="icon" href="<%=application.getAttribute("favicon") %>" type="image/x-icon">  
<!-- ...............................CSS Files.......................................... -->
<link type="text/css" href="<%=request.getContextPath()%>/css/bootstrap-cerulean.css" rel="stylesheet">
<link type="text/css" href="<%=request.getContextPath()%>/css/login_style.css" rel="stylesheet">
<link type="text/css" href="<%=request.getContextPath()%>/css/charisma-app.css" rel="stylesheet">
<link type="text/css" href="<%=request.getContextPath()%>/css/om_style.css" rel="stylesheet">

<!-- ...............................JS Files.......................................... -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-2.1.1.min.js"></script>			<!-- Jquery Min  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>


<style>			
			#divlog
			{			  
				width:100%;
				height:100%;
				margin:0;
			}
			
</style>

<script type="text/javascript">
	$(document).ready(function()
	{
		//Set Focus on Useername textfield
		$("#user_name").focus();
		
		//Fields Validation
		$("#loginForm").validate({
			debug : true,
			rules : {
				"userName" : "required",
				"password" : "required"
			},
			messages : {
				"userName" : "Enter Username",
				"password" : "Enter Password"
			},
			submitHandler : function(form) {
				form.submit();
			}
		});
		
		
	});	
	var clearMSG=function(){	
		$('#logMsg').empty();
	};

</script>

<s:head/>
</head>
<body style="background:url(images/login_page_bg.jpg) no-repeat center; background-size:100% 100%; overflow:hidden;">
<div id="divlog">
	<div class="container-fluid">
		<div class="row-fluid">

			<div class="row-fluid">
				<div class="span12 login-header">
					<!-- <img src="images/movable_gym_name.gif" style="width:400px; height:100px; margin:45px 0 0 100px;" alt=" "/>  -->
					
				</div><!--/span-->
			</div><!--/row-->
			<div class="row-fluid" style="background:(050,050,050,0.5);">
				<div class="well span5 login-box" style="box-shadow:rgba(0,0,0,0.5) 3px 3px 3px 3px; margin:50px 0 0 50px; background:rgba(200,200,200,0.8) ">
					<div class="alert alert-info">Please login with your Username and Password.</div>
					
					<s:form cssClass="form-horizontal" id="loginForm" action="loginUser" theme="css_xhtml"  onclick="clearMSG();">
						<center>
						<div id="logMsg">
							<s:if test="hasActionErrors()">
									<s:actionerror />
							</s:if>
						</div>
							<fieldset>
								<table>
									<tr align="center">
										<td>
											<div class="input-prepend" title="Usertype"
												data-rel="tooltip">
												<s:select name="userType"
													list="#{'User':'User','Admin':'Admin'}" onkeypress="clearMSG();" onclick="clearMSG();" onchange="clearMSG();"/>
											</div>
										</td>
									</tr>
									<tr align="center">
										<td><div class="input-prepend" title="Username"
												data-rel="tooltip" style="width: 200px;">
												<span class="add-on" style="float: left;"><i
													class="icon-user"></i></span>
												<s:textfield cssClass="input-large span10"
													style=" width: 170px; float: left;" name="userName"
													id="userName" onkeypress="clearMSG();" onclick="clearMSG();" onfocus="clearMSG();"/>
											</div></td>
									</tr>
									<tr align="center">
										<td><div class="input-prepend" title="Password"
												data-rel="tooltip" style="width: 200px;">
												<span class="add-on" style="float: left;"><i
													class="icon-lock"></i></span>
												<s:password cssClass="input-large span10"
													style=" width: 170px; float: left;" name="password"
													id="password" onkeypress="clearMSG();" onclick="clearMSG();" onfocus="clearMSG();"/>
											</div></td>
									</tr>
								</table>

								<table>
									<tr>
										<%-- <td><s:submit value="Login" cssStyle="background:#fff; color:#f00; border:0px; box-shadow:1px 1px 1px 1px #ccc; height:40px; width:80px;" /></td> --%>
										<td><s:submit value="Login" cssStyle="myButton  border:0px; color:#F0E68C; height:40px; width:80px;" /></td>
									</tr>
								</table>
							
							</fieldset>
						</center>
					</s:form>
				</div><!--/span-->
			</div><!--/row-->
		</div><!--/fluid-row-->

	</div><!--/.fluid-container-->
</div>
</body>
</html>