<style>
a#logged{color:rgb(250,200,100);}
a#logged:hover{color:rgb(250,250,10);}

#myheader
{
	background-repeat: repeat-x;
		/* Firefox 3.6+ */
	background: -moz-linear-gradient(100% 100% 90deg, rgb(50,50,200), #000);
		
		/* Safari 4-5, Chrome 1-9 */ /* -webkit-gradient(<type>, <point> [, <radius>]?, <point> [, <radius>]? [, <stop>]*) */
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#000), to(rgb(50,50,200)));
		
		/* Safari 5.1+, Chrome 10+ */
	background: -webkit-linear-gradient(rgb(50,50,200), #000);
		
		/* Opera 11.10+ */
	background: -o-linear-gradient(rgb(50,50,200), #000);
}
</style>


<%@taglib uri="/struts-tags" prefix="s"%>
<!-- <div class="navbar">
			<div class="navbar-inner">
				<div class="brand">
				 <span> <img style="width:25px; height:25px;" src="images/slimLine image.jpg"> </span>  	
					<span>SlimLine Fitness</span>					
				</div>	
				<div class="pull-right">				 
					<span>SlimLine Fitness</span>
				</div>			
			</div>
			
		</div> -->

<%-- <div class="row-fluid navbar navbar-inner ">
	<div class="row span10">
		<div class="brand">
			<span>SlimLine Fitness</span>
		</div>
	</div>
	<div class="row span2 pull-right" style="padding: 8px 0px 0px 20px;">
		<div class="row-fluid">
			<div class="row span11" style="margin-left: 40px;">
				<label class="span4">Log In As</label>
				<s:label value="%{session.userName}"
					cssStyle="font-size: 17px;color:#cc8811;" />
			</div>
		</div>
	</div>

</div> --%>


<s:if test="%{#application.gym_name==null}">
<script type="text/javascript">
alert("Please restart server and login again...");
window.location = "logOut";
</script>

</s:if>
<div class="navbar-inner" id="myheader">
	<div class="navbar  span8">
		<div class="brand" style="width:120%;">
		<%-- <img alt="Logo" src="<%=request.getContextPath()%>/images/gym_logo.png" width="35" height="30" /> --%>
		<%-- <img alt="Logo" src="<%=request.getContextPath()%>${applicationScope['gym_logo']}" width="35" height="30" /> --%>
		 
		<img alt="Logo" src="<%=application.getAttribute("gym_logo")%>" width="35" height="30" />
		<span style="color: #fff;text-shadow:2px 2px 2px #ea8000; font-family:Segoe , "Segoe UI", "DejaVu Sans", "Trebuchet MS", Verdana, sans-serif;">
		<%= application.getAttribute("gym_name") %>	
		
		</span>
		</div>
	</div>

	<div class="navbar span8 pull-right">
		<div class="row brand" style="  width: 97%;">
			
			<label class="pull-right"><a id="logged" href="logOut" class="pull-right" Style="font-size: 15px; padding:0 10px; border-left:1px solid; border-right:1px solid;">LogOut</a></label>
			<s:label value="%{session.userName}" cssStyle="font-size: 17px;color:#fff; padding-right:20px;" cssClass="pull-right" />
			<input type="hidden" value="<%=session.getAttribute("userName")%>" id="loggedUser" />
			<label class="span pull-right">logged in as&nbsp;&nbsp;</label>
			<!-- <a href="logOut"  Style="position:fixed; top:30px; right:25px; font-size: 15px;color:#f00;">LogOut</a> -->
		</div>
	</div>
</div>

