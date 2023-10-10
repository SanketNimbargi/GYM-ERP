<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by:Sunil JAGTAP
	 Date: 12/09/2014
	 Purpose: send message to member
-->

<!-- Java Script -->

<script type="text/javascript">
	$("#document").ready(function(){	
		
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
			$("#check").click(function(){
				$('input:checkbox').prop('checked', false).removeAttr("checked");
				var from = $("#from").val();
				var to = $("#to").val();
				$('input:checkbox').slice( parseInt(from)-1, parseInt(to) ).prop('checked', true).attr('checked', 'checked');
				
			});
		});
	

	function addContactHiddenTable(){
		var contactNo = [];
		$(':checkbox:checked').each(function(i){
			contactNo[i] = $(this).val();
	    	{
	      		var table = document.getElementById("tbl_CheckedContactNo");
	      		var rowCount = table.rows.length;
	      		var counts = rowCount - 1;
	      		var row = table.insertRow(rowCount);
	      		
	      		var cellSubExamId = row.insertCell(0);
	      		var eleSubExamId = document.createElement("input");
	      		eleSubExamId.type = "text";
	      		eleSubExamId.name = "contactList[" + counts + "].contact_no";
	      		eleSubExamId.value = parseInt(contactNo[i]);
	      		cellSubExamId.appendChild(eleSubExamId);
	    	}
	    });
	}
		
		//Fields Validation
		$("#configureConnection").validate({
			debug : true,
			rules : {
				"operatorNo" : "required",
				"portNo" : "required"
			},
			messages : {
				"operatorNo" : "Please select operator name.",
				"portNo" : "Please select Device."
			},
			submitHandler : function(form) {
				form.submit();
			}
		});
		
	});
</script>

<!-- Body starts here -->
<!-- 	<div style="width: 90%;"> -->
	<div style="width: 90%;margin-left: 5%;">
		<s:form id="sendMessage" theme="css_xhtml">
			<fieldset>
				<legend>Send Message To Member</legend>
				<table >
					
					<tr>
						<td ><label>Select Member Type</label></td>
						<td ><s:select name="memberStatus" id="memberStatus" cssStyle="width:140px;"
								list="#{'registered':'Register Member','remove':'Cancel Member'}" headerKey="" headerValue="Select Member Type"/>
						</td>
						<td >
							<s:submit action="memberTypeDetails" align="center" value="Get Member List" />
						</td>
						
					</tr>
				</table>
				<hr/>
				<table >
					<tr>
						<td ><label>Message :</label></td>
						<td  colspan="2"><s:textarea id="message" name="message" cssStyle="width:300px; height:50px;" value=""/></td>
						<td style="valin:middle;" ><s:submit  action="sendMsgToMember" value="Send" cssClass="smallBtn"/> </td>
						<s:token />
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
								list="#{'All':'Select All',
										'Particular':'Select Particular'}">
							</s:select>
						</td>
						<td style="vertical-align: top; visibility: hidden;" id="1">From Sr. No. :</td>
						<td style="visibility: hidden;" id="2">
							<s:textfield name="from" id="from"/>
						</td>
						<td style="vertical-align: top; visibility: hidden;" id="3">To Sr. No. :</td>
						<td style="visibility: hidden;" id="4">
							<s:textfield name="to" id="to"/>
						</td>
						<td style="visibility: hidden;" id="5">
							<input type="button" name="check" id="check" value="Check" />
						</td>
					</tr>
				</table>
				
				<fieldset style="width:95%;">
					<table class="display">
						<thead>
							<tr height="30px" bgcolor="CACECF">
								<th>Sr. No.</th>
								<th>Member ID</th>
								<th>Member Name</th>
								<th>Mobile Number</th>
							</tr>
						</thead>
						<tbody>
							<% int sr_no = 0; %>
							<s:iterator value="memberTypeList">
								<tr>
									<td align="center" style="width: 8%">
										<% sr_no = sr_no + 1; %>
										<div style="float: left;"><label><%= sr_no %></label></div>
										<input type="checkbox" id="check" name="check[<s:property value='memberId'/>]" value="<s:property value='contactNo'/>">
									</td>
									<td align="center" style="width: 25%">
										M<s:property value="memberId"/>
									</td>
									<td style="width: 45%">
										<s:property value="lastName"/>&nbsp;<s:property value="firstName"/>&nbsp;<s:property value="middleName"/>
									</td>
									<td align="center" style="width: 25%">
										<s:property value="contactNo"/>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</fieldset>
			</fieldset>			
			
		</s:form>
		
	</div>