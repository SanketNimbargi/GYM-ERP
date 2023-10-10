<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Shailesh Halor
	 Date: 20/09/2014
	 Purpose: Assign ledger Package
-->
<!--*****************start Script *************************  -->
<script type="text/javascript">
	$("#document").ready(function()
   {
		var ledgerPackhourType='<%=application.getAttribute("ledgerPackhourType")%>';	
		if(ledgerPackhourType=="true"){
			$("#hourType").val("Regular Hour").attr('readonly',false).attr("onchange", "return true;");
			$(".hourDetails").show();
		}else{
			$("#hourType").val("Regular Hour").attr('readonly',true).attr("onchange", "return false;").attr("onchange", '$("#hourType").val("Regular Hour");return false;');
			$(".hourDetails").hide();
		}
			
		
		
		jQuery.validator.addClassRules({
			packageFees: { number: true, min: 0 },
		});

		
		$("#assignLedgerPackageFees").validate({
			debug:true,
			rules:{
				
				"ledgerPackageModels[0].ledgerModel.ledgerId":{required:true },
				 "hourType":{required:true},
				"month":{required:true },
				"packageFees":{required:true , number:true},
			},
			messages:{
				
				"ledgerPackageModels[0].ledgerModel.ledgerId":{required:"Select Ledger" },
				 "hourType" : {required:"Select Hour Type"}, 
				"month":{required:"Select Package" },
				"packageFees":{required: "Enter Package Fees" , number: "Please Enter Numbers only."},
			},
			submitHandler:function(form){
				form.submit();
			}
		}); 
		$("[id^='check']").click(function(){
			var id = $(this).attr('id').substring(5);
			$("#packageFees"+id).val(0);
			
			if(this.checked)
				$("#packageFees"+id).attr('readonly',false);
			else
				$("#packageFees"+id).attr('readonly',true);
		});
		
		//Fetch Ledger Package Detais
		$("#ledgerId").change(function(){
			clearForm();
			var ledgerId = $("#ledgerId").val();
			//alert(ledgerId);
			var hourType = $("#hourType").val();
			$.getJSON('fetchLedgerPackageFees',{ledgerId : ledgerId, hourType : hourType}).done(function(data){
				if(data.ledgerPackageModelsList.length >0)
				{ 
					for (var i = 0; i < data.ledgerPackageModelsList.length; i++) {
						$("#packageId"+data.ledgerPackageModelsList[i].month).val(data.ledgerPackageModelsList[i].packageId);
						if(data.ledgerPackageModelsList[i].packageFees > 0){
							$("#check"+data.ledgerPackageModelsList[i].month).prop('checked', true).attr("checked",true);
							$("#packageFees"+data.ledgerPackageModelsList[i].month).val(data.ledgerPackageModelsList[i].packageFees).attr('readonly',false);
						}
											
					}
			 	}			
				
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		});
		
	});
	
	var clearForm = function(){
		$.each($(".check"),function(){
			this.checked = false;
		});
		$.each($(".packageFees"),function(){
			$(this).val("").attr('readonly',true);
		});
		$(".packageIds").val(0);
	};
	</script>
<!-- ******************************************************* -->

<!--*************Body start here *************************** -->
<s:form id="assignLedgerPackageFees" theme="css_xhtml">

	<div>
		<fieldset>
			<legend>Assign Ledger Package</legend>
			<table>
				<tr>
					<td  class="hourDetails" style="display: none;"><label>Hour Type<span class="required">*</span></label></td>
					<td><label>Ledger Name<span class="required">*</span></label></td>
				</tr>
				<tr>
					<td class="hourDetails"  style="display: none;"><s:select list="#{'Regular Hour':'Regular Hour','Happy Hour':'Happy Hour' }" id="hourType" name="ledgerPackageModels.hourType" headerKey="" headerValue="Select Type" value="" cssStyle="width:140px;" /></td>
					<td><s:select id="ledgerId" name="ledgerPackageModels[0].ledgerModel.ledgerId" value="" cssStyle="width:240px;"
							headerKey="" headerValue="Select Ledger Name" list="ledgerNamesMap" /></td>
				</tr>
			</table>
			<s:if test="packageMonthList.size() > 0">
				<table>
					<s:iterator value="packageMonthList" status="currentRecord">
						<s:if test="(#currentRecord.index % 3) == 0">
							<s:if test="#currentRecord.index > 0">
								</tr> <!-- It's not the first, close previous row -->
							</s:if>
							<tr> <!-- Open row -->
						</s:if>
						<td>
							<div>
								<table class="display" id="ledgerPackageFees">
									<tr>
										<td><s:hidden id="packageId%{packageMonth}" cssClass="packageIds" name="ledgerPackageModels[%{packageMonth}].packageId" value="0" />
											<s:checkbox cssClass="check" id="check%{packageMonth}"  name="check[%{packageMonth}]" value="false" />
										</td>
										<td width="160px;"><label><s:property value="packageMonth" /> Month</label></td>
										<td><s:textfield cssClass="packageFees" name="ledgerPackageModels[%{packageMonth}].packageFees" 
												id="packageFees%{packageMonth}" value="" readonly="true" /></td>
									</tr>
								</table>
							</div>
						</td>
					</s:iterator>
					</tr>
					<!-- close last open row -->
				</table>
			</s:if>
			<table>
				<tr>
					<td><s:submit id="save" value="Save" action="saveLedgerPackageFees" cssClass="smallBtn"/></td>
					<s:token />
				</tr>
			</table>
		</fieldset>
	</div>
	<s:token />
</s:form>