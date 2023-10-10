<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 06/09/2014
	 Purpose: Personal Trainer Registration
-->

<!-- Java Script -->

<script type="text/javascript">
	$("#document").ready(function(){
		
		if($("#connected").val() == "Disconnected"){
			$("#device").show();
			$("#connect").show();
			$("#disconnect").hide();
		}
		else{
			$("#device").hide();
			$("#connect").hide();
			$("#disconnect").show();
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

	<!-- 	<div style="width: 80%;"> -->
	<div style="width: 80%;margin-left: 10%;">
		<s:form id="configureConnection" theme="css_xhtml">
			<fieldset id="device">
				<legend>Configure Connection</legend>
				<s:hidden id="connected" value="%{connected}" />
				<table>
					<tr>
						<td><label>Operator Name</label></td>
						<td><label>Device Name</label></td>
					</tr>
					<tr>
						<td><s:select name="operatorNo" id="operatorNo" cssStyle="width: 160px;"
							headerKey="" headerValue="Select Operator"
							list="#{'+919809099060':'AIRCEL',
									'+919890051914':'AIRTEL',
									'+919440099997':'BSNL Old',
									'+919422999997':'BSNL NEW',
									'+919847099996':'IDEA',
									'+919020000500':'RELIANCE GSM',
									'+919032055002':'TATA DOCOMO',
									'+919084051550':'UNINOR',
									'+919846000040':'VODAFONE'}"/></td>
						<td><s:select name="portNo" id="portNo" cssStyle="width: 160px;"
							headerKey="" headerValue="Select Mobile/Modem" list="comPortList" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="connect">
				<s:submit action="connect" align="center" value="Connect" />
			</fieldset>
		</s:form>
		<s:form theme="css_xhtml">
			<fieldset id="disconnect">
				<s:submit action="disconnect" align="center" value="Disconnect" />
			</fieldset>
		</s:form>
	</div>