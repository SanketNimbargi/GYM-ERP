
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title></title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.10.22/css/dataTables.bootstrap4.min.css" rel="stylesheet"> -->
  
  <link rel="stylesheet" href="<%=request.getContextPath()%>/dataTable/bootstrap.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/dataTable/dataTables.bootstrap4.min.css">
</head>
<body>
<%
List l = (List)request.getAttribute("list");
Map mp = (Map)l.get(l.size()-1);
%>
<div class="container">
  <h2>Details</h2> 
   <a href="enquiryUpdate?enqId=<%= mp.get("displayEnquiryId")%>" class="btn btn-info" role="button">Re-Enquiry</a>   
  <table id="example" class="table table-striped table-bordered table-hover" style="width:100%">
    <thead>
      <tr>
        <th>firstNameEnquiry</th>
        <th>lastNameEnquiry</th>
        <th>contactNoEnquiry</th>
        <th>enquiryHandledBy</th>
        <th>feedbackEnquiry</th>
        <th>enquiryDate</th>
        <th>firstreplyDate</th>
      </tr>
    </thead>
    <tbody>
     	<%
 //out.println(m.get("firstNameEnquiry")+"  "+m.get("lastNameEnquiry")+"  "+m.get("contactNoEnquiry")+"  "+m.get("enquiryHandledBy")+"  "+m.get("enquiryStatus")+"  "+m.get("enquiryDate")+"  "+m.get("firstreplyDate"));
	
	//out.print(l);
	if(l!=null)
	{
		for(int i=0;i<l.size();i++)
		{
			Map m = (Map)l.get(i);
		%>
		
		<tr>
			<td><%= m.get("firstNameEnquiry")%></td>
			<td><%= m.get("lastNameEnquiry")%></td>
			<td><%= m.get("contactNoEnquiry")%></td>
			<td><%= m.get("enquiryHandledBy")%></td>
			<td><%=	m.get("feedbackEnquiry")%></td>
			<td><%= m.get("enquiryDate")%></td>
			<td><%= m.get("firstreplyDate")%></td>
			
		</tr>

		
			
<%			
		}
	}
%>
    </tbody>
  </table>
</div>
<script src="<%=request.getContextPath()%>/dataTable/dataTables.bootstrap4.min.js"></script>
<script src="<%=request.getContextPath()%>/dataTable/jquery-3.5.1.js"></script>
<script src="<%=request.getContextPath()%>/dataTable/jquery.dataTables.min.js"></script>

<%-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.22/js/dataTables.bootstrap4.min.js"></script> --%>
<script type="text/javascript">
$(document).ready(function() {
    $('#example').DataTable();
} );
</script>
</body>
</html>
