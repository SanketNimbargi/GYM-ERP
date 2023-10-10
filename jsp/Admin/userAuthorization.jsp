
<%@taglib uri="/struts-tags" prefix="s"%>
<script type="text/javascript">
$("#document").ready(function(){	
	$(function(){			
		$("#authorization_selection").change(function(){			
			var opt = $("#authorization_selection").val();
			if(opt == "All"){			
				$('input:checkbox').prop('checked', true);
			}			
			if(opt == "None"){
				$('input:checkbox').prop('checked', false).removeAttr("checked");		
			}	
			makeListOfUserRoles();
		});
	});	
	
	 $(function(){			
			$(".checkBoxClass").click(function(){				
				makeListOfUserRoles();
			});
	});
	/* $(function(){	
		
		$("#checkBoxClass").click(function(){			
			$('input:checkbox').prop('checked', false).removeAttr("checked");
			var from = $("#from").val();
			var to = $("#to").val();
			$('input:checkbox').slice( parseInt(from)-1, parseInt(to) ).prop('checked', true).attr('checked', 'checked');
			
		});
	}); */	
});
</script>
<!-- <input  type="button" value="Show" onclick="addAuthorizationTable();"/> 	 -->	
<fieldset id="authorizationField"><legend>Authorization</legend>
		<%-- <s:form id="authorizationForm" theme="css_xhtml" >		 --%>		
				<table>
					<tr>
						<td style="vertical-align: top;">Authorization :</td>
						<td>
							<s:select name="authorization_selection" id="authorization_selection" cssStyle="width:140px;"
								headerKey="-1" headerValue="--- Select ---"
								list="#{'All':'Select All',
										'None':'None'}">
							</s:select>
						</td>						
					</tr>
				</table>				
				<fieldset style="width:95%;">
					<table class="display" id="moduleTable">
						<thead>
							<tr height="30px" bgcolor="CACECF">
								<th>Sr. No.</th>
								<th>User Roles</th>								
								
							</tr>
						</thead>
						<tbody>
							<% int sr_no = 0; %>
							<s:iterator value="moduleList">
								<tr>
									<td align="center" style="width: 8%">
										<% sr_no = sr_no + 1; %>
										<div style="float: left;"><label><%= sr_no %></label></div>
										<input type="checkbox" class="checkBoxClass" id="<s:property value='objectType'/>" name="check[<%= sr_no %>]" value="<s:property value='objectType'/>"/>
									</td>
									<td align="center" style="width: 25%">
									<s:property value='objectType'/>
									</td>									
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</fieldset>		
				<%-- </s:form> --%>
			</fieldset>	