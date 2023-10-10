<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<s:form id="ptWiseMember" name="ptWiseMember" theme="css_xhtml">
		<div style="width: 90%;">
		
				
			<fieldset>
			<legend>Personal Trainer Wise Member</legend>
				 <table>
					<tr>
					<td>Select Personal Trainer</td>
							<td><s:select list="ptNameMap" name="memberRegistrationModel.ptNameList" id="ptList" headerKey="0" headerValue="Select PT"  value="" cssStyle="width:140px;"></s:select></td>
					</tr>
					
				</table> 
			</fieldset>
			<fieldset>
			<s:submit action="printPtwiseMember" id="PrintPtMember" name="PrintPtMember" align="center" value="Print"/>
			</fieldset>
			</div>
</s:form>
</body>
</html>