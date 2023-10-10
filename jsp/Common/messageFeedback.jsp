<%@taglib uri="/struts-tags" prefix="s"%>

<!--  This Page is not used -->
<script type="text/javascript">
var smstextMsg="";
	$("#document").ready(function() {				
		/*	var url="<s:property value='url'/>";		
		alert(url);
		var pos=url.search("amp;");		
		while (pos > 0) {
		    pos=url.search("amp;");
		    url = url.replace("amp;","");			
		}	
		alert(url); */
		var url=$("#url").val();	
		//alert("URL===="+url);
		//loadEnquiryPage();	
		var isTextSMSModuleGiven='<%=(Boolean)application.getAttribute("isTextSMSModuleGiven")%>';		
		if(isTextSMSModuleGiven=="true"){
			sendMessage(url);
		}else{	
			 smstextMsg="";
			loadEnquiryPage1();
		}
		
		
		
	});
	function sendMessage(url)
	{		
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
		//alert("xmlhttp.readyState="+xmlhttp.readyState+"xmlhttp.status="+xmlhttp.status);
	  if (xmlhttp.readyState==4 && xmlhttp.status==0)
	    {	
		  smstextMsg="SMS text are sent.";
		  loadEnquiryPage1();		 
	    }
	};	
	xmlhttp.open("POST",url,true);
	xmlhttp.send();
	}
	function loadEnquiryPage1()
	{
		var actionURL=$("#actionURL").val();		
		if(smstextMsg!=""){			
			showMessage({title: "",	text: smstextMsg ,timer: 1500,
				  showConfirmButton: false});			
		}		
		window.location.replace(actionURL);
	}
	//var hostname=window.location.hostname+""+window.location.pathname.substring(0,window.location.pathname.indexOf("/",2));
	//var hostname=window.location.hostname;
	/* var url=hostname+"/"+actionURL; */
	
	//NOT Used..................................................
	function loadEnquiryPage()
	{
		
	 var xmlhttp;
	 if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {	
		alert("xmlhttp.readyState="+xmlhttp.readyState+"xmlhttp.status="+xmlhttp.status);
	  	if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {		 
	     document.getElementById("myDiv").innerHTML=xmlhttp.responseText;	     
	     $("#myDiv").html(xmlhttp.responseText);
         $("#myDiv").find("script").each(function(i) {
             eval($(this).text());
         });
	     alertMsg("Message sent!");
	    }
	};
	var actionURL=$("#actionURL").val();	
	alert("actionURL="+actionURL);
	xmlhttp.open("POST",actionURL,true);
	xmlhttp.send();
	
	}
</script>
<input type="hidden" id="url" value='<s:property value="url"/>'/>
<input type="hidden" id="actionURL" value='<s:property value="session.feedbackSource"/>'/>

<%-- <s:set value="" name="feedbackSource"/> --%>
<div id="myDiv"></div>

