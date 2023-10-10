<!DOCTYPE >
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!-- Developed by: Sunil Jagtap
	 Date: 13/09/2014
	 Purpose: Restore BackUp
-->


<script type="text/javascript">
	$("#document").ready(function() {
		
		
	});
	</script>
	
	
	<s:form id="memberRegistration" theme="css_xhtml" method="post" enctype="multipart/form-data">
		<div style="width: 90%;">
			<fieldset>
				<legend>Restore BackUp</legend>
					<table>
					<tr>
						<td><label>Choose BackUp File</label></td>
					</tr>
					<tr>
						<td> <input type="file" id="backUpFile" name="backUpFile"/>  </td>
					</tr>
					
					</table>
			</fieldset>
			
			<fieldset>
				<s:submit align="center" action="restoreBackUp" id="restore"
					value="Restore BackUp" />
			</fieldset>
		</div>
	</s:form>