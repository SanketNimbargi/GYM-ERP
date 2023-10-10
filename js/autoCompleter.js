//Auto Complete for Search By PT Name for renew
var autoCompletePTRenew = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchPTNamesRenew',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.fetchPTNamesRenewList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("PT"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};

//Auto Completer PT Renew By Number
var autoCompleterPTNumberRenew = function(autocompleteTextField,idTextField,functionToCall){
	
	var availableTags = new Array();
	$.getJSON('fetchPTNumberRenew').done(function(data)			//Fetch Members Name List
	{
		availableTags = data.fetchPTNumberRenewList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("PT"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};
//Auto Complete for Search By Member Name
var autoComplete = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchMembersNames',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.memberNamesList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};


//Auto Complete for Search By Member Name
var autoCompleteBothMembers = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchBothMembersNames',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.bothMemberNamesList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};

var homepageAutoComplete = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchBothMembersNames',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.bothMemberNamesList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};


//Auto Complete for Search By personal trainer Name
var autoCompletePT = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchPTNames',{startString:startString}).done(function(data)			//Fetch Members Name List
	{	
		availableTags = data.ptNameList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("PT"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin PT Name. Please relode page...").show();
	});
	
};


//Auto Complete for Search By personal trainer Number
var autoCompletePTNumber = function(autocompleteTextField,idTextField,functionToCall){
	var availableTags = new Array();
	$.getJSON('fetchPTNumber').done(function(data)			//Fetch Members Name List
	{
		availableTags = data.fetchPTNumberList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("PT"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin PT Name. Please relode page...").show();
	});
	
};



//Auto Complete for Enquiry
var autoCompleteEnquiry = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchEnquiryNames',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.enquiryNameList;
		prevId=	availableTags.id;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val(ui.item.id);					//Assign Enquiry Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
		
		 
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Enquiry Name. Please relode page...").show();
	});
	
};

//Auto Complete for Address
var autoCompleteAddress = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchAddressNames',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.addressNameList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val(ui.item.id);					//Assign address Id					
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Address Name. Please relode page...").show();
	});
	
};

//Auto Complete for ReEnquiry By Contact No
var autoCompleteEnquirybyNo = function(autocompleteTextField,idTextField,functionToCall){
	var availableTags = new Array();
	$.getJSON('fetchEnquiryContactNo').done(function(data)			//Fetch Members Name List
	{
		
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchEnquiryContactNoList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val(ui.item.id);					//Assign Enquiry Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Enquiry Name. Please relode page...").show();
	});
	
};



//Auto complete for search member details by contact number.
var autoCompleteSearchMember = function(autocompleteTextField,idTextField,functionToCall){
	var availableTags = new Array();
	$.getJSON('fetchSearchMember').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchMemberDetailsList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetching Members Name. Please relode page...").show();
	});
	
};

//Auto complete for search member details by contact number.
var autoCompleteSearchMemberBoth = function(autocompleteTextField,idTextField,functionToCall){
	var availableTags = new Array();
	$.getJSON('fetchSearchMemberBoth').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchBothMemberDetailsList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetching Members Name. Please relode page...").show();
	});
	
};



//Auto Complete for Search By Member Name for Rejoin
var autoCompleteMemberNameRejoin = function(autocompleteTextField,idTextField,functionToCall){
	var startString=$("#"+autocompleteTextField).val();	
	var availableTags = new Array();
	$.getJSON('fetchMembersNamesRejoin',{startString:startString}).done(function(data)			//Fetch Members Name List
	{
		availableTags = data.fetchMembersNamesRejoinList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
				$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};

//Auto complete for search member details by contact number for Rejoin.
var autoCompleteMemberNumberRejoin = function(autocompleteTextField,idTextField,functionToCall){
	
	var availableTags = new Array();
	$.getJSON('fetchMemberNumberRejoin').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchMemberNumberRejoinList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
	
};

//Auto complete for search PT members by date of birth
var autoCompletePTDOB=function(autocompleteTextField,idTextField,functionToCall){
	
	var availableTags = new Array();
	$.getJSON('fetchPTMemberByDOB').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchPTMemberByDOBList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("PT"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
};

var autoCompletePTRenewDOB=function(autocompleteTextField,idTextField,functionToCall){
	
	var availableTags = new Array();
	$.getJSON('fetchPTRenewMemberByDOB').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchPTRenewMemberByDOBList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("PT"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
};

var autoCompleteMemberByDOB=function(autocompleteTextField,idTextField,functionToCall){
	
	var availableTags = new Array();
	$.getJSON('fetchMemberByDOB').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchMemberByDOBList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
};

var autoCompleteRenewMemberByDOB=function(autocompleteTextField,idTextField,functionToCall){
	
	var availableTags = new Array();
	$.getJSON('fetchRenewMemberByDOB').done(function(data)			//Fetch Members Name List
	{
		//alert(data.fetchMemberDetailsList);
		availableTags = data.fetchRenewMemberByDOBList;
		$("#"+autocompleteTextField).autocomplete({
			source : availableTags,
			select : function( event, ui ) {
			$("#"+idTextField).val("M"+ui.item.id);			//Assign Members Id
				if ($.isFunction(functionToCall)){
					functionToCall();								//Call Function
				}
			}
		});
	})
	.fail(function(jqxhr, textStatus, error) {
		$("#message").text("Error in fetchin Members Name. Please relode page...").show();
	});
};

