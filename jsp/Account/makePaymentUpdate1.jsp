<%@ taglib uri="/struts-tags" prefix="s"%>
<!-- Developed by: Shailesh Halor
	 Date: 01/10/2014
	 Purpose: Make Payment
-->
<html>
<head>

<script type="text/javascript">
completedFeesList = null;

$("#document").ready(function(){
	
	//Set Focus
	$("#displayMemberId1").focus();
	
	//Jquery validations for class
	jQuery.validator.addClassRules({
		ledgerTotalFees: { number: true, min: 0, checkledgerTotalFees:true },
		ledgerPaidFees: { number: true, min: 0 },
		startDate:{ required:true },
		endDate:{ required:true },
		dueDate:{checkDate:true, checkDueDate:true},
		transactionDetail:{checkTransactionDetails:true}
	});

	//Validation for form
	$("#memberFeesForm").validate({
		debug : true,
		rules : {
			"displayMemberId1" :{required:true, checkMemberId:true},
			"paymentMode":{required:true},
			"transactionDate":{checkDate:true},
			"tax":{number: true, min: 0},
			"totalPaidFees":{ min: 1},
		},
		messages : {
			"displayMemberId1" :{required:"Enter Member Id"},
			"paymentMode":{required:"Select Payment Mode"},
			"totalPaidFees":{ min: "Please make some Payment."},
		},
		submitHandler : function(form) {
			form.submit();
		}
	}); 
	
	//Add Validation method for Due date
	$.validator.addMethod("checkDueDate", function(value, element) {
		valid = true;
		var id = $(element).attr('id').substring(7);
		
		var ledgerPaidFees = 0;
		if(!isNaN($("#ledgerPaidFees"+id).val()) && $("#ledgerPaidFees"+id).val().length!=0) 
			 ledgerPaidFees = parseFloat($("#ledgerPaidFees"+id).val());
		var ledgerPendingFees = 0;
		if(!isNaN($("#ledgerPendingFees"+id).val()) && $("#ledgerPendingFees"+id).val().length!=0) 
			ledgerPendingFees = parseFloat($("#ledgerPendingFees"+id).val());
		var ledgerAlreadyPaidFees = 0;
		if(!isNaN($("#ledgerAlreadyPaidFees"+id).val()) && $("#ledgerAlreadyPaidFees"+id).val().length!=0) 
			ledgerAlreadyPaidFees = parseFloat($("#ledgerAlreadyPaidFees"+id).val());
		
		if((ledgerPaidFees > 0 && ledgerPendingFees > 0 ) || (ledgerPaidFees == 0 && ledgerAlreadyPaidFees == 0 )){
	    	 if(element.value != "")
	        	valid = true;
	    	 else
	    		 valid = false;
	    }
		return valid;
	}, "Enter Due Date");
	
	//Add Validation method for Due date
	$.validator.addMethod("checkledgerTotalFees", function(value, element) {
		var id = $(element).attr('id').substring(15);
		return (parseFloat($("#ledgerAlreadyPaidFees"+id).val()) <= element.value);
	}, "Amount shoud be greter than Already paid amount.");
	
	//Add Validation method for ChequeNo
	$.validator.addMethod("checkTransactionDetails", function(value, element) {
		 valid = true;
		    if($("#paymentMode").val() == "Cheque" || $("#paymentMode").val() == "Card"){
		    	 if(element.value != "")
		        	valid = true;
		    	 else
		    		 valid = false;
		    }
		return valid;
	}, "Enter Transaction Details");
	

	// payment mode
	$('#paymentMode').change(function(data){
		
		if($(this).val()=="Cash"){
			$(".transactionDetail").val("").attr('readonly',true);
			$("#transactionDate").val("").attr('disabled',true);
		}
		else{
			$(".transactionDetail").attr('readonly',false);
			$("#transactionDate").attr('disabled',false);
		}
			
	});
	
	//Auto Complete for Search By Member Name
	//autoComplete("membersNameAutocomplete1","displayMemberId1",onMemberIdChange);
	$("#membersNameAutocomplete1").keyup(function(){			
		autoComplete("membersNameAutocomplete1","displayMemberId1",onMemberIdChange);
	});
	
	//Auto Complete for Search By number
	autoCompleteSearchMember("contactNo1","displayMemberId1",onMemberIdChange);
	
	// DatePicker
	$("#transactionDate").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
		minDate: $("#receiptDate").val(),
	});
	// DatePicker
	$("#receiptDate").datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
		onClose : function(date){
			$("#transactionDate").datepicker( "option", "minDate", date );
		}
	});
	// fetch member details
	$("#displayMemberId1").change(function(){
		onMemberIdChange();						//Fetch Members Details On Change of Member Id
	});
});

/* ------------------------------------ User Defined Functions ------------------------------------- */
//On Member Id Change Event get member details, Fees details
	var onMemberIdChange = function(){
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
		clearForm();
		var memberId=parseInt($("#displayMemberId1").val().substring(1));
		var checkMemberString=$("#displayMemberId1").val().substring(0,1);
		if(memberId > 0 && checkMemberString == 'M')
		{
			$("#memberId").val(memberId);
			$.getJSON('fetchMemberPaymentUpdateDetails',{memberId : memberId})			//Json To Fetch Data
				.done(function(data)
				{
					if(data.memberDetails[0] != undefined){						
						$("#membersNameAutocomplete1").val(data.memberDetails[0].firstName+" "+data.memberDetails[0].middleName+" "+data.memberDetails[0].lastName);
						$("#contactNo1").val(data.memberDetails[0].contactNo);
						if(data.memberDetails[0].status != 'registered'){
							$("#message").text("This member is canceld. Please first rejoin him and then make payment.").show();
							return false;
						}else{
							if(data.memberPaymentDetailsList[0] == undefined || data.memberPaymentIncompleteList.length==0){
								$("#message").text("This member has not any Incomplete receipt.").show();
								return false;
							}
						}
						$("#ledgerData").show();
					
						if(data.completedFeesList[0] != undefined)
							completedFeesList = data.completedFeesList;
						else
							completedFeesList = null;

						/* if(data.memberPaymentDetailsList[0] != undefined && data.memberPaymentIncompleteList.length>=0){ */
						 if(data.memberPaymentDetailsList[0] != undefined && data.memberPaymentIncompleteList.length>0){ 

						/* if(data.memberPaymentDetailsList[0] != undefined && data.memberPaymentIncompleteList.length>=0){ */
						if(data.memberPaymentDetailsList[0] != undefined && data.memberPaymentIncompleteList.length>0){

							assignFeeData(data.memberPaymentDetailsList, data.checkFirstTimeFees);		
						}	
						else{
							if(data.checkFirstTimeFees == "Yes"){
							$("#message").text("This Member has not paid any fees...").show();
							}
							$('input:radio[name=discountType]').attr('disabled', false); 
							$('input:radio[name=taxType]').attr('disabled', false); 
							$("#discountType1").prop("checked","true");								
							$("#taxType2").prop("checked","true");
							enterDiscount();
						}
						}
					}
					else
						$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
				})
				.fail(function(jqxhr, textStatus, error) {
					$("#message").text("Error While Fetching. Please Try Again...").show();
				});
		}
		else
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
	};
	
	//Assign Fees Data To fields
	var assignFeeData = function(data, checkFirstTimeFees){
		$("#feesData, #saveData, #receiptData, #paymentData").show();
			
		var tableName = $("#fees tbody");
		//alert(data[0].transactionDetailsId+" recNo="+data[0].receiptNo);
		$("#transactionDetailsId").val(data[0].transactionDetailsId);
		$("#receiptNo").val(data[0].receiptNo);
		$("#receiptDate").val(convertToUserDate(data[0].receiptDate));
		$("#tax").val(data[0].tax);
		
		var discount=data[0].discount;
		if(discount!=0){				
			//$('input:radio[name=discountType]').attr('disabled', true); 
			$("#discountType2").attr('checked',true);
			$("#discount").val(discount).attr('readonly',false);
			$(".discountAmount").show();				
		}	
		var taxType=data[0].taxType;
		if(taxType=="Inclusive"){				
			//$('input:radio[name=taxType]').attr('disabled', true); 
			$("#taxType2").attr('checked',true);
			//$("#discount").val(discount).attr('readonly',true);
			//$(".discountAmount").show();				
		}else{
			//$('input:radio[name=taxType]').attr('disabled', true); 
			$("#taxType1").attr('checked',true);
			//$("#discount").val(discount).attr('readonly',true);
			//$(".discountAmount").show();
		}	
		
		if(data[0].paymentMode != "Cash"){
			$(".transactionDetail").attr('readonly',false);
			$("#transactionDate").attr('disabled',false);
		}
		$("#paymentMode").val(data[0].paymentMode);
		$("#transactionNo").val(data[0].transactionNo);
		$("#transactionDate").val(convertToUserDate(data[0].transactionDate));
		$("#bankName").val(data[0].bankName);
			
		for (var i = 0; i < data.length; i++) {
				var id = data[i].ledgerId;
				$("#check"+id).prop('checked', true).attr("onclick", "return false;").removeAttr('disabled');
				$("#packageId"+id).val(data[i].packageId).attr('disabled',false);
				
				if(data[i].hourType == "Regular Hour")
					$("#hourType1"+id).prop('checked',true).attr("onclick","return false");
				else
					$("#hourType2"+id).prop('checked',true).attr("onclick","return false");
				
				var row = $('<tr id="row'+id+'"></tr>').appendTo( tableName);
				$('<td width="140px;"></td>').text($("#check"+data[i].ledgerId).val()).appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerTotalFees" id="ledgerTotalFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.ledgerTotalFees" value="'+data[i].ledgerTotalFees+'" onkeyup="calculate();" onblur="calculate();" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerAlreadyPaidFees" id="ledgerAlreadyPaidFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerAlreadyPaidFees" value="'+data[i].ledgerAlreadyPaidFees+'" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerPaidFees" id="ledgerPaidFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerPaidFees" value="'+data[i].ledgerPaidFees+'" onkeyup="calculate();" onblur="calculate();" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerPendingFees" id="ledgerPendingFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerPendingFees" value="'+data[i].ledgerPendingFees+'" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="startDate " id="startDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.startDate" value="'+convertToUserDate(data[i].startDate)+'" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="endDate" id="endDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.endDate" value="'+convertToUserDate(data[i].endDate)+'" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="dueDate" id="dueDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.dueDate" value="'+convertToUserDate(data[i].dueDate)+'" /></td>').appendTo(row);
				$('<td><s:hidden name="ledgerFeesPaids['+id+'].ledgerFees.ledgerFeesId" value="'+data[i].ledgerFeesId+'" /></td>').appendTo(row);
				$('<td><s:hidden name="ledgerFeesPaids['+id+'].ledgerFeesPaidId" value="'+data[i].ledgerFeesPaidId+'" /></td>').appendTo(row);
				
				
				assignStartDate(id);
				assignEndDate(id);
				assignDueDate(id);
		}
		calculate();
	};

	//On Select of Package get Package Fees using ajax
	var onPackageSelect = function($this){
		var packageId = parseInt($($this).val());
		var id = $($this).attr('id').substring(9);
		$.getJSON('fetchPackageFees',{packageId : packageId}).done(function(data){		//Json To Fetch Data
			if(data.packageFees != undefined){
				$("#ledgerTotalFees"+id).val(data.packageFees);
				
				var date = $("#startDate"+id).val();
				var months = $("#packageId"+id+" :selected").text();
				endDate = addDaysMonthsYears(date, -1, months, 0);
				$("#endDate"+id).val(endDate);
				
				calculate();
			}
			else
				$("#message").text("Package Id is not Valid. Please Select Valid Package Id...").show();
		})
		.fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Fetching. Please Try Again...").show();
		});
	};
	
	var changePackage = function(id,hourType){
		
		
		//alert("id=="+id);
		//alert("hourType===="+hourType);
		/* if(id == undefined)*/
			//var ledgerId = $('input[type$="checkbox"]:checked').attr('id').substring(5); 
			/* if(hourType1=="Regular Hour) */
		//var ledgerId = id;
		// var hourType = $('input[name$="hourType'+id+'"]:checked').val();
		 var hourType = hourType;
		 //var ledgerId =  $('input[name$="hourType'+id+'"]:checked').attr('id').substring(9);
		 if(hourType == "Regular Hour")
			 var ledgerId =  $('input[id$="hourType1'+id+'"]:checked').attr('id').substring(9);
		else if(hourType == "Happy Hour")
			var ledgerId =  $('input[id$="hourType2'+id+'"]:checked').attr('id').substring(9); 
		//var hourType = hourType1;
		//alert("hourType1=="+hourType);
		//alert("ledgerId1=="+ledgerId);
		$("#checkHour"+id).val(hourType);
		//var RH = $("#hourType1").attr('checked');
		
		 /* if($("input[type='radio'].hourType[value='Regular Hour']").is(":checked")){
			 alert("Hi.....Regular");
		 $('#hourType2').attr('checked', false);
			 hourType = $("#hourType1").val();
		 }
		 else if(($("input[type='radio'].hourType[value='Happy Hour']").is(":checked"))){
			 alert("Hi.....Happy");
			 if($("input[type='radio'].hourType[value='Regular Hour']").is(":checked")){
				 $('#hourType1').prop('checked', false);
			 }
			 hourType = $("#hourType2").val();
		 } */

		alert("packageId=="+$("#packageId").val($('input[id$="hourType1'+id+'"]:checked')));

		/* var hourType =$("#hourType1").val();
		hourType=$("#hourType2").val(); */
		/* if($('#hourType1').prop('checked',true)){
			//$('#hourType2').prop('checked',false);

			var hourType =$('#hourType1').val();
		}
		else{
			//$('#hourType1').prop('checked',false);

			var hourType =$('#hourType2').val();
		} */
		//alert(hourType);
		//var	ledgerId=$(input[id=hourType]:checked')
		//var ledgerId = $($this).attr('id').substring(9);
		
		$("#packageId"+ledgerId).empty();
		//var ledgerId = $("")
		//alert("ledgerId :"+ledgerId);
		//$('select').empty();

		/* var sel=$(".packageId");
		  $('<option>').text('0').val('-1').appendTo(sel);  */
		$.getJSON('fetchSelectedPackageMonth',{ledgerId : ledgerId,hourType : hourType}).done(function(data){	
			
			if(data.ledgerPackageMonth[0] != undefined){
			for(var i=0; i <= data.ledgerPackageMonth.length; i++){
			
				var sel=$("#packageId"+ledgerId);
				  $('<option>').text(data.ledgerPackageMonth[i].month).val(data.ledgerPackageMonth[i].packageId).appendTo(sel);

			
			}

			}
			});
		  //onPackageSelect();
		  calculate();
		//onPackageSelect();
		}  

//Assign Datepicker to start date and calculate end Date
var assignStartDate = function(id){
	//Datepicker
	$("#startDate"+id).datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
		onClose : function(date){
			var months = $("#packageId"+id+" :selected").text();
			var endDate = addDaysMonthsYears(date, -1, months, 0);
			$("#endDate"+id).val(endDate).datepicker( "option", "minDate",endDate );
			$("#dueDate"+id).datepicker( "option", "minDate",date );
		}
	});
};
//assign Date picker to end Date
var assignEndDate = function(id){
	//Datepicker
	$("#endDate"+id).datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
	});
};
//assign Date picker to due Date
var assignDueDate = function(id){
	$("#dueDate"+id).datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
		minDate:$("#startDate"+id).val()
	});
};

//Reset All Fields of Form to default values
var clearForm = function(){
	$("#feesData, #saveData, #receiptData, #paymentData, #ledgerData, #message").hide();
	
	$("#memberId").val(0);
	$("#membersNameAutocomplete1").val("");
	
	$.each($(".check"),function(){
		this.checked = false;
		$(this).attr('disabled',true);
	});
	$.each($(".packageId"),function(){
		$(this).prop('selectedIndex',0).attr('disabled',true).attr("onchange", "onPackageSelect(this);");
	});
	
	$("#fees tbody").empty();
	
	$("#tax").val("");
	$("#transactionDetailsId").val(0);
	$("#receiptNo").val("");
	$("#receiptDate").val("");
	
	$("#paymentMode").val("");
	$(".transactionDetail").val("").attr('readonly',true);
	$("#transactionDate").val("").attr('disabled',true);
	
	calculate();
};

//Calculate All Fees
var calculate = function(){
	
	//Calculate Total Fees Before Tax and Discount 
	var totalFees = 0;
    $.each($('.ledgerTotalFees'), function() {
    	 if(!isNaN(this.value) && this.value.length!=0) {    		 
    		 totalFees += parseFloat(this.value);
    	 }    	 
    });
    
    $("#totalFees").val(totalFees.toFixed(2));
    
 	//Calculate Total Already Paid Fees 
	var totalAlreadyPaidFees = 0;
    $.each($('.ledgerAlreadyPaidFees'), function() {
    	 if(!isNaN(this.value) && this.value.length!=0) 
    		 totalAlreadyPaidFees += parseFloat(this.value);
    });
	
    $("#totalAlreadyPaidFees").val(totalAlreadyPaidFees.toFixed(2));
	
    //Calculate Total Paid Fees
	var totalPaidFees = 0;
    $.each($('.ledgerPaidFees'), function() {
    	 if(!isNaN(this.value) && this.value.length!=0) 
    		 totalPaidFees += parseFloat(this.value);
    });
    $("#totalPaidFees").val(totalPaidFees.toFixed(2));    
    //Calculate Total Pending Fees 
    calculateDiscount(); 
    // var totalPendingFees = totalFees - totalAlreadyPaidFees - totalPaidFees;
   //$("#totalPendingFees").val(totalPendingFees.toFixed(2));
	var totalPendingFees=$("#totalPendingFees").val();
	//Calculate Ledger Pending Fees
    $.each($('.ledgerPaidFees'), function() {
    	
    	var ledgerPendingFees = 0;
		var id = $(this).attr('id').substring(14);
		
		if($('#errorDisplay'+id).length != 0)
			$("#errorDisplay"+id).remove();
		
		if(!isNaN($("#ledgerTotalFees"+id).val()) && ($("#ledgerTotalFees"+id).val()).length!=0) 
			ledgerPendingFees += $("#ledgerTotalFees"+id).val();
		
		if(!isNaN($("#ledgerAlreadyPaidFees"+id).val()) && ($("#ledgerAlreadyPaidFees"+id).val()).length!=0) 
			ledgerPendingFees -= $("#ledgerAlreadyPaidFees"+id).val();
		
		if(!isNaN(this.value) && this.value.length!=0) 
			ledgerPendingFees -= parseFloat(this.value);
		
		 if(ledgerPendingFees == 0 || totalPendingFees == 0)
		    	$("#dueDate"+id).val("").attr('readonly',true).attr('disabled',true);
		    else
		    	$("#dueDate"+id).attr('readonly',false).attr('disabled',false);

		 if(ledgerPendingFees<0){ 
			var message="<label id='errorDisplay"+id+"' class='error'>Value should be less than Pending Fees..</label>";		//Create Message
			$("input#ledgerPaidFees"+id).after(message);																	//Append Message
			$("#makePayment").attr('disabled',true);
		}
		else{				
			$("#ledgerPendingFees"+id).val(ledgerPendingFees.toFixed(2));			
			$("#makePayment").attr('disabled',false);
		}
    });
    calculateTax();   
};

//==================================================================================================================
//New Function to calculate Tax
var calculateTax = function(){
	var tax = 0;
	if(!isNaN($("#tax").val()) && ($("#tax").val()).length!=0) 
		tax = parseFloat($("#tax").val());
	var totalFees = parseFloat($("#totalFees").val());
	var totalPendingFees=parseFloat($("#totalPendingFees").val());
	var totalPaidFees=parseFloat($("#totalPaidFees").val()); 
	var totalTaxAmount = 0;
	var finalAmount = 0;
	var taxType=$('input:radio[name=taxType]:checked').val(); 
	  if(taxType=="Exclusive"){//Exclusive		
		  finalAmount=(totalFees*(100+tax)/100);
		  totalTaxAmount = finalAmount-totalFees;  	  		   		 		
    	 $("#totalGrossFees").val(totalFees.toFixed(2));   
		  
	  }else{//Inclusive
		  var grossFees=(totalFees*100)/(100+tax);  //gross fees
		  totalTaxAmount = totalFees-grossFees;  //gross fees-total fees		  
		  var finalAmount=totalFees;  		 		
    	 $("#totalGrossFees").val(grossFees.toFixed(2));   
	  }  	
	
	  if(totalPendingFees>0){		 
			 $("#advanceAmount").val(totalPaidFees.toFixed(2));   
		  } else{			
			 $("#advanceAmount").val(totalPendingFees.toFixed(2));
		 } 
	  $("#totalTaxAmount").val(totalTaxAmount.toFixed(2));
	  $("#finalAmount").val(finalAmount.toFixed(2));
	  decidePaymentOption();
};

var enterDiscount=function(){
	var discountType=$('input:radio[name=discountType]:checked').val(); 
	
	 if(discountType=="discounted"){//discounted	
		 $("#discount").val("0.0");
		 $(".discountAmount").show();
	 }else{//final
		 $("#discount").val("0.0");
		 $(".discountAmount").hide();
	 }		
	 calculateDiscount();
};
//New calculate discount function
var calculateDiscount=function(){
	var Discount= parseFloat($("#discount").val());    
	
	var totalFees = 0;
  $.each($('.ledgerTotalFees'), function() {
  	 if(!isNaN(this.value) && this.value.length!=0) 
  		 totalFees += parseFloat(this.value);
  });
  
  $("#totalFees").val(totalFees.toFixed(2));
//Calculate Total Already Paid Fees 
	var totalAlreadyPaidFees = 0;
  $.each($('.ledgerAlreadyPaidFees'), function() {
  	 if(!isNaN(this.value) && this.value.length!=0) 
  		 totalAlreadyPaidFees += parseFloat(this.value);
  });
	
  $("#totalAlreadyPaidFees").val(totalAlreadyPaidFees.toFixed(2));   
  
  //Calculate Total Paid Fees
	var totalPaidFees = 0;
  $.each($('.ledgerPaidFees'), function() {
  	 if(!isNaN(this.value) && this.value.length!=0) 
  		 totalPaidFees += parseFloat(this.value);
  });
  $("#totalPaidFees").val(totalPaidFees.toFixed(2));  
	 
  //Calculate Total Pending Fees with discount
  var totalPendingFees = totalFees - totalAlreadyPaidFees - totalPaidFees-Discount;
 	if($('#errorDisplaydiscount').length != 0)
		$("#errorDisplaydiscount").remove();
  if(totalPendingFees>=0){
  	$("#totalPendingFees").val(totalPendingFees.toFixed(2));
  	$("#makePayment").attr('disabled',false);
  }
  else{
  	var discount=$("#discount");
  	totalPendingFees=0;
      $("#totalPendingFees").val(totalPendingFees.toFixed(2));
      var message="<label id='errorDisplaydiscount' class='error'>Value should be less than Total Pending Fees..</label>";		//Create Message
		$("input#discount").after(message);																	//Append Message
		$("#makePayment").attr('disabled',true);
  }  	
	//===================		
	//make due date read only
	    $.each($('.ledgerPendingFees'), function() {  
	    	var ledgerPendingFees = 0;
			var id = $(this).attr('id').substring(17);		
			if($('#errorDisplay'+id).length != 0)
				$("#errorDisplay"+id).remove();	 	    	
	    	if(totalPendingFees == 0){
	    		 $("#dueDate"+id).attr('readonly',true).attr('disabled',true);
	    	}else{
				if(!isNaN($(this).val()) && ($(this).val()).length!=0) 
					ledgerPendingFees = $(this).val();				
				if(ledgerPendingFees == 0)
			    	$("#dueDate"+id).val("").attr('readonly',true).attr('disabled',true);
			 	else{
					 $("#dueDate"+id).attr('readonly',false).attr('disabled',false);
			 	}			    
	    	}		 
			
	    });
	//====================	
	//var totalPendingFees=parseFloat($("#totalPendingFees").val());
  if(totalPendingFees>0){		 
		 $("#advanceAmount").val(totalPaidFees.toFixed(2));   
	  } else{			
		 $("#advanceAmount").val(totalPendingFees.toFixed(2));
	 } 
  decidePaymentOption();
};

//advance or Final
var decidePaymentOption = function(){
	var totalPendingFees=parseFloat($("#totalPendingFees").val());
	  if(totalPendingFees>0){	
		 // $("#saveData").hide();
		  $("#receiptType").val("advance");
		//  $("#saveAdvanceData").show();   
	 } else{	
		 $("#receiptType").val("final");
		// $("#saveAdvanceData").hide();
		 //   $("#saveData").show();   
		   
	 }
}
//===================================================old Not used===========================	
//Calculate All Fees
var calculate1 = function(){
	
	//Calculate Total Fees Before Tax and Discount 
	var totalFees = 0;
    $.each($('.ledgerTotalFees'), function() {
    	 if(!isNaN(this.value) && this.value.length!=0) 
    		 totalFees += parseFloat(this.value);
    });
    
    $("#totalFees").val(totalFees.toFixed(2));
    
 	//Calculate Total Already Paid Fees 
	var totalAlreadyPaidFees = 0;
    $.each($('.ledgerAlreadyPaidFees'), function() {
    	 if(!isNaN(this.value) && this.value.length!=0) 
    		 totalAlreadyPaidFees += parseFloat(this.value);
    });
	
    $("#totalAlreadyPaidFees").val(totalAlreadyPaidFees.toFixed(2));
	
    //Calculate Total Paid Fees
	var totalPaidFees = 0;
    $.each($('.ledgerPaidFees'), function() {
    	 if(!isNaN(this.value) && this.value.length!=0) 
    		 totalPaidFees += parseFloat(this.value);
    });
    $("#totalPaidFees").val(totalPaidFees.toFixed(2));
    
    //Calculate Total Pending Fees
    var totalPendingFees = totalFees - totalAlreadyPaidFees - totalPaidFees;
    $("#totalPendingFees").val(totalPendingFees.toFixed(2));
    
	//Calculate Ledger Pending Fees
    $.each($('.ledgerPaidFees'), function() {
    	
    	var ledgerPendingFees = 0;
		var id = $(this).attr('id').substring(14);
		
		if($('#errorDisplay'+id).length != 0)
			$("#errorDisplay"+id).remove();
		
		if(!isNaN($("#ledgerTotalFees"+id).val()) && ($("#ledgerTotalFees"+id).val()).length!=0) 
			ledgerPendingFees += $("#ledgerTotalFees"+id).val();
		
		if(!isNaN($("#ledgerAlreadyPaidFees"+id).val()) && ($("#ledgerAlreadyPaidFees"+id).val()).length!=0) 
			ledgerPendingFees -= $("#ledgerAlreadyPaidFees"+id).val();
		
		if(!isNaN(this.value) && this.value.length!=0) 
			ledgerPendingFees -= parseFloat(this.value);
		
		 if(ledgerPendingFees == 0)
		    	$("#dueDate"+id).val("").attr('readonly',true).attr('disabled',true);
		    else
		    	$("#dueDate"+id).attr('readonly',false).attr('disabled',false);
		 
		if(ledgerPendingFees<0){
			var message="<label id='errorDisplay"+id+"' class='error'>Value should be less than Total Fees..</label>";		//Create Message
			$("input#ledgerPaidFees"+id).after(message);																	//Append Message
			$("#makePayment").attr('disabled',true);
		}
		else{
			$("#ledgerPendingFees"+id).val(ledgerPendingFees.toFixed(2));
			$("#makePayment").attr('disabled',false);
		}
    });
    calculateTax();
};

//Calculate Tax
var calculateTax1 = function(){
	var tax = 0;
	if(!isNaN($("#tax").val()) && ($("#tax").val()).length!=0) 
		tax = parseFloat($("#tax").val());
	
	var totalTaxAmount = 0;
	$.each($('.ledgerPaidFees'), function() {
		var ledgerPaidFees = 0;
		if(!isNaN(this.value) && this.value.length!=0) 
			ledgerPaidFees = parseFloat(this.value);
		
		var taxAmount = 0;
		taxAmount = ledgerPaidFees*tax/100;
		
		totalTaxAmount += taxAmount;
	});
	
	
	$("#totalTaxAmount").val(totalTaxAmount.toFixed(2));
	
	var finalAmount = 0;
	if(!isNaN($("#totalPaidFees").val()) && ($("#totalPaidFees").val()).length!=0)
		finalAmount = parseFloat($("#totalPaidFees").val());
	finalAmount += totalTaxAmount;
	$("#finalAmount").val(finalAmount.toFixed(2));
};


</script>

</head>
<body>


	<!-- <div style="margin: 0 -12%"> -->
	<div>
		<s:form id="memberFeesForm" theme="css_xhtml">
		<s:textfield name="receiptType" id="receiptType" value="Advance" style="display:none;"/>
			<fieldset>
			<legend>
				<span class="legendtext">Update Payment</span>
			</legend>
				<table>
					<tr>
						<td><label>Member Id</label></td>
						<td><s:hidden name="memberId" id="memberId" value="" /> 
							<s:textfield name="displayMemberId" id="displayMemberId1" placeholder="M1" onkeyup="upperCase(this);" />
						</td>
						<td><label>Member Name</label></td>
						<td><s:textfield id="membersNameAutocomplete1" name="membersNameAutocomplete"
								placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
						<td><label>Contact No</label></td>
						<td valign="top"><s:textfield name="contactNo" id="contactNo1"
								value="" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="ledgerData" style="display: none;">
				<s:if test="ledgerPackageList.size() > 0">
					<table>
						<s:iterator value="ledgerPackageList" status="currentRecord">
							<s:if test="(#currentRecord.index % 3) == 0">
								<s:if test="#currentRecord.index > 0">
									</tr> <!-- It's not the first, close previous row -->
								</s:if>
								<tr> <!-- Open row -->
							</s:if>
							<td>
								<div>
									<table class="display" id="ledger">
										<tr>
											<td><input type="checkbox" class="check" id="check<s:property value="ledgerId" />"
												name="check[<s:property value="ledgerId" />]" value="<s:property value="ledgerName" />"
												 disabled="disabled" /></td>
											<td width="160px;"><label><s:property value="ledgerName" /></label></td>
											<td><label>Package</label>
												<input type="radio"  name="hourType<s:property value="ledgerId" />" value="Regular Hour" id="hourType1<s:property value="ledgerId" />" class="hourType" onclick="changePackage(<s:property value="ledgerId" />,'Regular Hour');"  disabled="false" > RH &nbsp;&nbsp;
											<input type="radio"  name="hourType<s:property value="ledgerId" />" value="Happy Hour" id="hourType2<s:property value="ledgerId" />" class="hourType"  onclick="changePackage(<s:property value="ledgerId" />,'Happy Hour');" disabled="false" >HH  <%-- onchange="onPackageSelect(<s:property value="ledgerId" />)" --%>
											<s:hidden id="checkHour%{ledgerId}" name="checkHour[%{ledgerId}]" value="" />
											</td>
											<td><s:hidden id="packageFees%{ledgerId}" value="%{packageFees}" /> 
												<s:select name="ledgerFeesPaids[%{ledgerId}].ledgerFees.packageId" id="packageId%{ledgerId}" 
													list="#{ }" cssStyle="width:40px; padding: 0px" value=""
													disabled="true" cssClass="packageId" /></td>
										</tr>
									</table>
								</div>
							</td>
						</s:iterator>
						</tr> <!-- close last open row -->
					</table>
				</s:if>
			</fieldset>
			<fieldset id="receiptData" style="display: none;">
				<table>
					<tr>
						<td><label>Receipt No.</label></td>
						<td><label>Receipt Date</label></td>
						<td colspan="2"><label>Tax</label></td>
						<td colspan="2" style="padding-left:20px;"><label>Select Tax Type</label></td>
						<td colspan="2" style="padding-left:20px;"><label>Payment Type</label></td>
						<td colspan="2" style="padding-left:20px;display:none;" class="discountAmount"><label>Discount Amount</label></td>
					</tr>
					<tr>
						<td><s:hidden name="transactionDetailsId" id="transactionDetailsId" value="" />
							<s:textfield name="receiptNo" id="receiptNo" value="" /></td>
						<td><s:textfield name="receiptDate" id="receiptDate" value="" /></td>
						<td><s:textfield name="tax" id="tax" value="12.3" onkeyup="calculateTax();"  onblur="calculateTax();" style="width:80px;"/></td>
						<td><label>%</label></td>
							 <td colspan="2" style="padding-left:20px;">	
						 Inclusive  <input type="radio" name="taxType" id="taxType2" value="Inclusive" onclick="calculateTax();" checked="checked" >		 
						 Exclusive  <input type="radio" name="taxType" id="taxType1" value="Exclusive" onclick="calculateTax();">&nbsp;&nbsp;
						 </td> 	
						 <td colspan="2" style="padding-left:20px;">						 
						  Final  <input type="radio" name="discountType" id="discountType1" value="final" onclick="enterDiscount();" checked="checked" >		 
						  Discounted  <input type="radio" name="discountType" id="discountType2" value="discounted" onclick="enterDiscount();">&nbsp;&nbsp;
							
						  <%-- <s:radio name="isDiscounted" list="#{'final':'final','discounted':'discounted'}"/> --%>
						</td>	
						<td  colspan="2" style="display:none;padding-left:20px;" class="discountAmount">
						<s:textfield id="discount" value="0.0" name="discount" cssStyle="width:80px;" onblur="calculateDiscount();" onkeyup="calculateDiscount();" class="discountAmount"/>
						</td>
					</tr>
				</table>
			</fieldset>

			<fieldset id="feesData" style="display: none;">
				<table id="fees">
					<thead>
						<tr>
							<th width="140px;"></th>
							<th width="100px;"><label>Total Fees</label></th>
							<th width="100px;"><label>Already Paid Fees</label></th>
							<th width="100px;"><label>Paid Fees</label></th>
							<th width="100px;"><label>Pending Fees</label></th>
							<th width="100px;"><label>Start Date</label></th>
							<th width="100px;"><label>End Date</label></th>
							<th width="100px;"><label>Due Date</label></th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
				<hr>
				<table>
					<tr>
						<td><label>Total Fees</label></td>
						<td><label>Already Paid Fees</label></td>
						<td><label>Total Paid Fees</label></td>
						<td><label>Gross Fees</label></td>   <!-- change   --> 
						<td><label>Total Pending Fees</label></td>
						<td><label>Total Tax Amount</label></td>
						<td><label>Final Amount To Pay</label></td>		
						<td><label>Advance Amount To Pay</label></td>				
					</tr>
					<tr>
						<td><s:textfield id="totalFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td><s:textfield id="totalAlreadyPaidFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td><s:textfield name="totalPaidFees" id="totalPaidFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
	<!-- change   --> 	<td><s:textfield name="totalGrossFees" id="totalGrossFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td><s:textfield id="totalPendingFees"  name="totalPendingFees" value="0.0" readonly="true" cssStyle="width:80px;"/></td>
						<td><s:textfield id="totalTaxAmount" name="totalTaxAmount" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td><s:textfield id="finalAmount" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
	<!-- change   --> 					
						<td><s:textfield id="advanceAmount" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="paymentData" style="display: none;">
				<table>
					<tr>
						<td><label>Payment Mode</label></td>
						<td><label>Cheque/Transaction No.</label></td>
						<td><label>Cheque/Transaction Date</label></td>
						<td><label>Bank Name</label></td>
					</tr>
					<tr>
						<td><s:select name="paymentMode" id="paymentMode" cssStyle="width:140px;" headerKey="" value="" 
								headerValue="Select Payment Mode" list="#{'Cash':'Cash','Cheque':'Cheque','Card':'Card Payment'}" /></td>
						<td><s:textfield cssClass="transactionDetail" name="transactionNo" id="transactionNo" value="" readonly="true" /></td>
						<td><s:textfield cssClass="transactionDetail" name="transactionDate" id="transactionDate" value="" readonly="true" disabled="true" /></td>
						<td><s:textfield cssClass="transactionDetail" name="bankName" id="bankName" onkeyup="upperCase(this);" value="" readonly="true" /></td>
					</tr>
				</table>
			</fieldset>
			<fieldset id="saveData" style="display: none;">
				<s:submit id="makePayment" value="Make Payment" action="updatePaymentDetails" align="center" />
			</fieldset>
			<s:token />
		</s:form>
	</div>




</body>
</html>