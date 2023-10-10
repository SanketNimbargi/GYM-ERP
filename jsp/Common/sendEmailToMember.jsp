<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Gavate Yogesh
	 Date: 1/01/2015
	 Purpose: send Email to member
-->

<!-- Java Script -->

<script type="text/javascript">

$("#document").ready(function(){	
	
		//Validation for form
		$("#emailForm").validate({
			debug : true,
			rules : {
				"from":{required:true ,checkMail:true},
				"to":{checkMail:true},
				"bodyField":{required:true},
				"password":{required:true},
			},
			messages : {
				"from":{required:"Enter Email Id"},
				"to":{required:"Enter Email Id"},
				"bodyField":{required:"Enter text Message"},
				"password":{required:"Enter Currect Password"},
			},
			submitHandler : function(form) {
				form.submit();
			}
		});     
    
	$("#memberStatus").change(function()
		{
		var memberStatus = $("#memberStatus").val(); 
		
	    if(memberStatus == "One")
	    	{
			 	$("#toEmail").show();
			 	$("#contactField").hide();
				$("#getList").hide();
	    	}
	    else 
	    	{
				$("#toEmail").hide();
	        	$("#contactField").show();
	        	$("#getList").show();
	       }
	});
	
	$("#getList").click(function(){
		var memberStatus = $("#memberStatus").val();
		$.getJSON('fetchMemberListForEmailAction',{memberStatus : memberStatus}).done(function(data)
		{
			if(data.emailMemberTypeList[0] == undefined)
				$("#message").text("Member list Empty...").show();
			else{
				//Table created again. Delete previous Table.
				var tableDivId = $("#divTable");			    
				tableDivId.empty();
				$('<table class="display" id="memberTableList">'+
					'<thead><tr height="30px" bgcolor="CACECF"><th>Sr. No.</th><th> ID</th><th>Name</th><th>EmailId</th></tr></thead>'+
					'<tbody></tbody></table>') .appendTo(tableDivId);				
				createTable($("#memberTableList tbody"),data.emailMemberTypeList);		
			}		
			
		}).fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Fetching. Please Try Again...").show();
		});
		
	});
	$(function(){			
		$("#number_selection").change(function(){
			var opt = $("#number_selection").val();
			if(opt == "All")
			{
				$("#1").css("visibility","hidden");
				$("#2").css("visibility","hidden");
				$("#3").css("visibility","hidden");
				$("#4").css("visibility","hidden");
				$("#5").css("visibility","hidden");
				$('input:checkbox').prop('checked', true).attr('checked', true);
			}
			
			if(opt == "Particular")
			{
				$('input:checkbox').prop('checked', false).removeAttr("checked");
				$("#1").css("visibility","visible");
				$("#2").css("visibility","visible");
				$("#3").css("visibility","visible");
				$("#4").css("visibility","visible");
				$("#5").css("visibility","visible");
			}
			
		});
	});
	
	$(function(){			
		$("#checkButton").click(function(){
			$('input:checkbox').prop('checked', false).removeAttr("checked");
			var from = $("#fromSrNo").val();
			var to = $("#toSrNo").val();
			$('input:checkbox').slice( parseInt(from)-1, parseInt(to) ).prop('checked', true).attr('checked', 'checked');
			
		});
	});

//Create Table
var createTable = function(tableName,data){
	//tableName.empty();		
	for (var i = 0; i < data.length; i++) {		
		var row = $('<tr id="tr'+i+'"></tr>').appendTo( tableName);		
		$('<td  align="center" style="width: 8%"><div style="float: left;padding-top:5px ;"><label>'+(i+1)+'</label></div>'
				+'<input type="checkbox" class="checkbox" id="check" name="check['+data[i].memberId+']" value="'+data[i].firstName+'/'+data[i].emailId+'"></td>').appendTo(row);			
		$('<td>M'+data[i].memberId+'</td>').appendTo(row);
		var name=data[i].firstName+" "+data[i].middleName+" "+data[i].lastName;
		$('<td style="width: 50%"></td>').text(name).appendTo(row);		
		$('<td></td>').text(data[i].emailId).appendTo(row);		
	}
	// $("#memberTableList").dataTable();
};
	
});
</script>
	<em> 
   Only Enter a Email Username and Password
   </em>
<s:form theme="css_xhtml" id="emailForm" name="emailForm" >
	<fieldset>
				<legend>Send Email To Member</legend>
				<table >					
					<tr>
						<td ><label>Select Member Type</label></td>
						<td ><s:select name="memberStatus" id="memberStatus" cssStyle="width:140px;" headerValue="select list" headerKey=" "
								list="#{'One':'Select one','registered':'Register Member','remove':'Cancel Member','enquired':'Enquiry','reenquired':'ReEnquiry'}" />
						</td>
						<td >
						<input type="button" name="getList" id="getList"  value="Get Member List" style= "display: none;" class="mybtn"/>
							<%-- <s:submit action="emailmemberTypeDetails" name="emailmemberTypeDetails" id="emailmemberTypeDetails" align="center" value="Get Member List" style= "display: none;" /> --%>
						</td>
						
					</tr> 
				</table>
				
	   <table>
	   
 		<tr>
			<td ><label>From<span class="required">*</span></label></td>			
			<td><s:textfield name="from" id="from" value="%{emailSetting.get(0).emailId}"  cssStyle="width:200px;"/></td>
		</tr>
		<tr>
			<td ><label>Password<span class="required">*</span></label></td>
			<td><s:password name="password" id="password" value="%{emailSetting.get(0).password}" showPassword="true" cssStyle="width:200px;" /></td>
		</tr>
		
	
	    <tr id="toEmail" style= "display: none;">
			<td ><label>To</label></td>
			<td><s:textfield name="to" id="to" value=""  /></td>
		</tr> 
		
		<tr>
		
			<td ><label>Subject</label></td>
			<td><s:textfield name="subject" id="subject" value=""  /></td>
		</tr>
		<tr>
		    <td ><label>Message<span class="required">*</span></label></td>
			<td><s:textarea name="bodyField" id="bodyField" value=""  /></td>
		</tr> 
		<tr>
			<td>
				<s:submit value="Send" id="Send" action="sendEmail" />
			</td>
		</tr>
	</table>
	</fieldset>
	
	<fieldset id="contactField" >
				<div id="count" style="float: right; font-weight: bolder; color: green; font-family: cursive;"></div>
				<table>
					<tr>
						<td style="vertical-align: top;">Number Selection :</td>
						<td>
							<s:select name="number_selection" id="number_selection" cssStyle="width:140px;"
								headerKey="-1" headerValue="--- Select ---"
								list="#{'All':'Select All','Particular':'Select Particular'}">
							</s:select>
						</td>
						<td style="vertical-align: top; visibility: hidden;" id="1">From Sr. No. :</td>
						<td style="visibility: hidden;" id="2">
							<s:textfield name="fromSrNo" id="fromSrNo"/>
						</td>
						<td style="vertical-align: top; visibility: hidden;" id="3">To Sr. No. :</td>
						<td style="visibility: hidden;" id="4">
							<s:textfield name="toSrNo" id="toSrNo"/>
						</td>
						<td style="visibility: hidden;" id="5">
							<input type="button" name="checkButton" id="checkButton" value="Check" class="mybtn"/>
						</td>
					</tr>
				</table>
				
				<fieldset style="width:95%;">
				<div id="divTable">
					<table class="display" id="memberTableList">
						<thead>
							<tr height="30px" bgcolor="CACECF">
								<th>Sr. No.</th>
								<th> ID</th>
								<th>Name</th>
								<th>EmailId</th>
							</tr>
						</thead>						
					</table>
			</div>
				</fieldset>
			</fieldset> 
			<s:token />
	</s:form>
 

	