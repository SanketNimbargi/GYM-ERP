<%@ taglib uri="/struts-tags" prefix="s"%>
<!-- Developed by: Shailesh Halor
	 Date: 01/10/2014
	 Purpose: Make Payment
-->
<html>
<head>

<script type="text/javascript">
completedFeesList = null;
isAlreadyPaid=false;
$("#document").ready(function(){   	
	//Set Focus		
	$("#displayMemberId1").focus();
	//alert($("#dispMemberId").val());
	if(parseInt($("#dispMemberId").val()) > 0){		
		$("#ledgerData").show();
		$.each($(".packageId"),function(){
			$(this).prop('selectedIndex',0).attr('disabled',true).attr("onchange", "onPackageSelect(this);");
		});
	}
	
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
		//	"totalPaidFees":{ min: 1},
		},
		messages : {
			"displayMemberId1" :{required:"Enter Member Id"},
			"paymentMode":{required:"Select Payment Mode"},
		//	"totalPaidFees":{ min: "Please make some Payment."},
		},
		submitHandler : function(form) {
			if($("#totalPaidFees").val()==0){
				$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
				$("#message").text("Please make some Payment.").show();;	
			}else{
			/* 
			<p>If this is correct, click Submit Form.</p>
			<p>To edit, click Cancel.</p>
			 $("p#dialog-confirm").html($("input#totalPaidFees").val());
		       alert( $('#dialog').dialog('open'));  */	
		     //alert($("input#displayRegistrationFee").val()+""+isNaN(parseFloat($("input#displayRegistrationFee").val())));		      
		     var amount =parseFloat($("input#totalPaidFees").val());
		     var details = "Total Ledger Amount: "+amount;
		     if(!isNaN(parseFloat($("input#displayRegistrationFee").val())) && !isAlreadyPaid 
		    		 && $(':checkbox:checked[id=regCheckBox]').prop("checked") == true){
		    	 amount+=parseFloat($("input#displayRegistrationFee").val());
		    	 details += "\nReg Fees: "+$("input#displayRegistrationFee").val();
		     }
		     
		       var isConfirm= confirm(details+"\nTotal : Rs. "+amount+" /- \n If this is correct, click OK. \n To edit, click Cancel.");
		       if(isConfirm){
		    	   form.submit();
		       }
		/*        alertMsg({
		   		title: "Are you sure?",
		   		text: "Rs. "+amount+" /- \n If this is correct, click Submit Form. \n To edit, click Cancel.",
		   		type: "warning",
		   		showCancelButton: true,
		   		confirmButtonColor: '#DD6B55',
		   		confirmButtonText: 'Submit Form',
		   		//closeOnConfirm: false
		   	},
		   	function(isConfirm){
		   		if (isConfirm){
		   			$("form").submit();		   			
		   		} else {
		   			//skip 
		   		}
		   	});   */
					//form.submit();	
			
			}
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
	
	 $("#totalPendingFees").css("color","red");
	
});	

//Confirm Dialog box 
 var finalConfirm=function(){
       // jQuery UI Dialog   
       
	//var msg = "Are you sure delete this record.";

/* 	$('<div id="dvConfirmModal"></div>').appendTo('body').html("<p>"+msg+"</p>") */
     /*   $("#dialog").dialog({
       //	title: "Please confirm that you want to submit?",
           autoOpen: false,
           width: 400,
           modal: true,
           resizable: false,
           buttons: {
               "Submit Form": function() {  
            	   $(this).dialog("close");
       			   return true;
                   //document.memberFeesForm.submit();
               },
               "Cancel": function() {            	 
                   $(this).dialog("close");
                   return false;
                  	
               }
           }
       }); */
        
       $('form#memberFeesForm').submit(function(e){       
           e.preventDefault();
           $("p#dialog-confirm").html($("input#totalPaidFees").val());
           $('#dialog').dialog('open');
       });
};


 /*  $('#makePayment').click(function(){
    submit = false;
  // if(yesNo!=null && yesNo != 0){
	    $("#confirm").dialog({
	//showMessage({	
	title: "Are you sure?",
	text: "",
	type: "warning",				
	cancelButtonText:'cancel',
	showCancelButton: true,				
	confirmButtonColor: '#DD6B55',
	confirmButtonText: 'Yes',	
	//closeOnConfirm: false,
	//closeOnCancel: false
	  buttons: {
            'Submit': function() {
                $(this).dialog('close');
                submit = true;
                submitForm.submit();
            },
            'Cancel': function() {
               // $(this).dialog('close');
            	// submit = false;
            	 $(this).dialog('close');
            	// 
 	          // return false;
            	// $("#makePayment").parent().appendTo($("#memberFeesForm"));
            	 submit = false;
            }
        }

});
	
   $("#confirm").parent().appendTo($("#memberFeesForm"));

	    submitForm.submit(function() {
	        if (submit) {
	            return true;
	        } else {
	            $("#confirm").dialog('open');
	            return false;
	        }
	    });
	});
});	 */
/* ------------------------------------ User Defined Functions ------------------------------------- */
//On Member Id Change Event get member details, Fees details
function onChangedisplayMemberId(){

	onMemberIdChange();						//Fetch Members Details On Change of Member Id
}
var isNewReceipt=false;
	var onMemberIdChange = function(){
		
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
		clearForm();
		var memberId=parseInt($("#displayMemberId1").val().substring(1));
		var checkMemberString=$("#displayMemberId1").val().substring(0,1);
		
		if(memberId > 0 && checkMemberString == 'M')
		{				
			$("#dispMemberId").val(memberId); 	
			
			$.getJSON('fetchMemberPaymentDetails',{memberId : memberId})			//Json To Fetch Data
				.done(function(data)
				{				
					//JSON.stringify(source);
					//alert(JSON.stringify(data.memberPaymentDetailsList));
					if(data.memberDetails[0] != undefined){					
						$("#membersNameAutocomplete1").val(data.memberDetails[0].firstName+" "+data.memberDetails[0].middleName+" "+data.memberDetails[0].lastName);
						$("#contactNo1").val(data.memberDetails[0].contactNo);
						if(data.memberDetails[0].status != 'registered'){
							$("#message").text("This member is canceld. Please first rejoin him and then make payment.").show();
							return false;
						}
						$("#ledgerData").show();
						if(data.completedFeesList[0] != undefined)
							completedFeesList = null;//completedFeesList = data.completedFeesList;
						else
							completedFeesList = null;						
						
						$("#regFeesStatus").val("");
						if(data.memberPaymentDetailsList[0] != undefined && data.memberPaymentIncompleteList.length>0){							
								assignFeeData(data);
								//assignFeeData(data.memberPaymentDetailsList);
								makePaidTextBoxeReadOnly();	
								isNewReceipt=false;
								
						}
						else{
							$("#regFees").empty();					
							//$("#regFees").append("Paid Reg Fees");
							$('<label>Registration Fees</label>').appendTo($("#regFees"));
							//$('<label>AlreadyPaid Reg Fees</label>').appendTo();
						
							if(data.checkFirstTimeFees == "Yes"){
								$("#message").text("This is First Fees of this Member.").show();
								// First Time when First receipt drawn
									$("#displayRegistrationFee").val(data.registrationFee);
									$("#regCheckBox").prop('checked', true).attr("onclick","calculate();");
									$("#regFees").show();
									$("#tdRegFees").show();	
									isAlreadyPaid=false;
							
							}else{
								
								if(data.registrationFeePaid=="noPaid"){ //still not paid
										$("#displayRegistrationFee").val(data.registrationFee);
										$("#regCheckBox").prop('checked', false).attr("onclick","calculate();");
										$("#regFees").hide();
										$("#tdRegFees").hide();	
										isAlreadyPaid=false;
										$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
										$("#message").text("Still Member has not paid any Registration fees.").show();
								}else{	
							
										$("#displayRegistrationFee").val(data.registrationFee);
										$("#regCheckBox").prop('checked', false).attr("onclick","showWarningMessage(); return false;");
										$("#regFees").hide();
										$("#tdRegFees").hide();	
										isAlreadyPaid=true;
								}
							}
								$('input:radio[name=discountType]').attr('disabled', false); 
								$('input:radio[name=taxTypeGroup]').attr('disabled', false); 
								$("#discountType1").prop("checked","true");								
								$("#taxType2").prop("checked","true");
								$("#taxType").val("Inclusive");
								enterDiscount();	
								//alert("New Final ReceiptNumber="+data.displayFinalReceiptNo);
								//$("#finalReceiptNo").val(data.displayFinalReceiptNo);		
								isNewReceipt=true;
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
	var showWarningMessage=function(){
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));	
		$("#message").text("Member had already submited registration fees.").show();
		alertMsg("Member had already submited registration fees.");	
		
	};
	var makePaidTextBoxeReadOnly=function(){
		//make due date read only
		var totalPaidFees=parseFloat($("#totalPaidFees").val());
	    $.each($('.ledgerPendingFees'), function() {  
	    	var ledgerPendingFees = 0;
			var id = $(this).attr('id').substring(17);		
			if($('#errorDisplay'+id).length != 0)
				$("#errorDisplay"+id).remove();	 	    	
	    	/* if(totalPaidFees == 0){
	    		 $("#ledgerPaidFees"+id).attr('readonly',true).attr('disabled',true);
	    		 
	    	}else{ */
				if(!isNaN($(this).val()) && ($(this).val()).length!=0) 
					ledgerPendingFees = $(this).val();				
				if(ledgerPendingFees == 0){					
					$("#ledgerPaidFees"+id).attr('readonly',true).attr('disabled',true);				
				}			    	
			 	else{					
					$("#ledgerPaidFees"+id).attr('readonly',false).attr('disabled',false);
			 	}			    
	    	//}		 
			
	    });
	};
	//Assign Fees Data To fields
	var assignFeeData = function(jsondata){
		/* $("#feesData, #saveAdvanceData, #receiptData, #paymentData").show(); */
		data=jsondata.memberPaymentDetailsList;
		$("#feesData, #saveData, #receiptData, #paymentData").show();
		var discountAmount=$("#discount").val();
		 
		//if(data[0].feeStatus=="Incomplete")
		{			
			var discount=data[0].discount;
			if(discount!=0){				
				$('input:radio[name=discountType]').attr('disabled', true); 
				$("#discountType2").attr('checked',true);
				$("#discount").val(discount).attr('readonly',true);
				$(".discountAmount").show();				
			}	
			var taxType=data[0].taxType;
			if(taxType=="Inclusive"){				
				$('input:radio[name=taxTypeGroup]').attr('disabled', true); 
				$("#taxType2").attr('checked',true);								
			}else{
				$('input:radio[name=taxTypeGroup]').attr('disabled', true); 
				$("#taxType1").attr('checked',true);				
			}	
			$("#taxType").val(taxType);
			
			//alert(data[0].finalReceiptNo);
			//$("#finalReceiptNo").val(data[0].finalReceiptNo);
			var tableName = $("#fees tbody");
			
			//$("#tax").val(data[0].tax);
			
			for (var i = 0; i < data.length; i++) {
				var id = data[i].ledgerId;				
				 $("#check"+id).prop('checked', true).attr("onclick", "return false;"); 
				$("#packageId"+id).val(data[i].packageId).attr('disabled',false).attr('readonly',true).attr("onchange", "return false;");				
				var row = $('<tr id="row'+id+'"></tr>').appendTo( tableName);	
				
				$('<td width="140px;"></td>').text($("#check"+data[i].ledgerId).val()).appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerTotalFees" id="ledgerTotalFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.ledgerTotalFees" value="'+data[i].ledgerTotalFees+'" onkeyup="calculate();" onblur="calculate();" /></td>').appendTo(row);
			/* 	//change
				$('<td><input type="text" style="width:80px;" class="ledgerGrossFees" id="ledgerGrossFees'+id+'" value="" readonly="true" /></td>').appendTo(row);
		 */
				var ledgerAlreadyPaidFees = data[i].ledgerAlreadyPaidFees + data[i].ledgerPaidFees;
				$('<td><input type="text" style="width:80px;" class="ledgerAlreadyPaidFees" id="ledgerAlreadyPaidFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerAlreadyPaidFees" value="'+ledgerAlreadyPaidFees+'" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerPaidFees" id="ledgerPaidFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerPaidFees" value="" onkeyup="calculate();" onblur="calculate();" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerPendingFees" id="ledgerPendingFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerPendingFees" value="'+data[i].ledgerPendingFees+'" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="startDate " id="startDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.startDate" value="'+convertToUserDate(data[i].startDate)+'" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="endDate" id="endDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.endDate" value="'+convertToUserDate(data[i].endDate)+'" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="dueDate" id="dueDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.dueDate" value="'+convertToUserDate(data[i].dueDate)+'" /></td>').appendTo(row);
				$('<td><s:hidden name="ledgerFeesPaids['+id+'].ledgerFees.ledgerFeesId" value="'+data[i].ledgerFeesId+'" /></td>').appendTo(row);
				
				assignEndDate(id);
				assignDueDate(id);
			}
		
		}
		
		
		if(jsondata.registrationFeePaid=="noPaid"){ //still not paid
			$("#displayRegistrationFee").val(jsondata.registrationFee);
			$("#regCheckBox").prop('checked', false).attr("onclick","calculate();");
			$("#regFees").hide();
			$("#tdRegFees").hide();	
			isAlreadyPaid=false;
			$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
			$("#message").text("Still Member has not paid any Registration fees.").show();
		}else{ // if paid
			//alert(jsondata.registrationFeePaid+":"+jsondata.registrationFee)	
			if(jsondata.registrationFeePaid=="takenOnSameFinalReceipt"){ //Allready paid
				 	$("#displayRegistrationFee").val(jsondata.registrationFee);
					$("#regCheckBox").prop("checked", true).attr("onclick", "return false;"); 
					
					$("#regFees").empty();					
					//$("#regFees").append("Paid Reg Fees");
					//$('<label>Registration Fees</label>').appendTo();
					$('<label>AlreadyPaid Reg Fees</label>').appendTo($("#regFees"));
					$("#regFeesStatus").val("AlreadyPaid");
					
					$("#regFees").show();
					$("#tdRegFees").show();	
					isAlreadyPaid=true;
			}else{
		 		$("#displayRegistrationFee").val(data.registrationFee);
				$("#regCheckBox").prop('checked', false).attr("onclick","showWarningMessage(); return false;");
				$("#regFees").empty();					
				//$("#regFees").append("Paid Reg Fees");
				$('<label>Registration Fees</label>').appendTo($("#regFees"));
				//$('<label>AlreadyPaid Reg Fees</label>').appendTo($("#regFees"));
				$("#regFees").hide();
				$("#tdRegFees").hide();	
				isAlreadyPaid=false;
			}
		
			/* */
			
		}
		calculate();
			
	};

	//On Select of Package get Package Fees using ajax
	var onPackageSelect = function($this){
		$('<div class="errors" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
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
	

//On Checked Event
var onCheck = function($this){
	$("#feesData, #saveData, #receiptData, #paymentData").show();
	
	var tableName = $("#fees tbody");
	var id = $($this).attr('id').substring(5);
	//alert(id);
	var startDate = "";
	var endDate = "";
	
	//===============================Not used/executed this code since completedFeesList is set to null====
	if(completedFeesList != null){
		for (var i = 0; i < completedFeesList.length; i++) {
			if( completedFeesList[i].ledgerId == id){
				startDate = convertToUserDate(completedFeesList[i].endDate);
				startDate = addDaysMonthsYears(startDate, 1, 0, 0);
				var months = $("#packageId"+id+" :selected").text();
				endDate = addDaysMonthsYears(startDate, -1, months, 0);
				isNew=false;
				break;
			}			
		}
		
	}
	//=======================================================================================================
	//if(isNewReceipt){	
	 //then find endDate of last package  
		var packageId =id;
	
		var memberId=parseInt($("#displayMemberId1").val().substring(1));
		//alert("packageId="+packageId+" memberId= "+memberId);	
		$.getJSON('fetchSelectedPackageDetails',{memberId:memberId,packageId : packageId}).done(function(data){	
			$('<div class="welcome" id="message" style="width: 400px; display: none;"></div>').appendTo($("#errorContainer"));
			if($this.checked){
					if(data.lastSelectedPackageDetails[0] != undefined && data.lastSelectedPackageDetails.length>0){
						//alert(data.lastSelectedPackageDetails[0].endDate);				
						startDate = convertToUserDate(data.lastSelectedPackageDetails[0].endDate);
						alertMsg("Previous '"+data.lastSelectedPackageDetails[0].ledgerName+"' Package end date is \n '"+startDate +"'.Please check starting and ending package date accordingly.");
						startDate = addDaysMonthsYears(startDate, 1, 0, 0);				
						var months = $("#packageId"+id+" :selected").text();
						endDate = addDaysMonthsYears(startDate, -1, months, 0);	
					}
					else{
						$("#message").text("This is new package. Please select start date...").show();
					}
			
			//=====================================
			
				//alert(id+"="+$this.checked);
				$("#packageId"+id).removeAttr('disabled');
				var row = $('<tr id="row'+id+'"></tr>').appendTo( tableName);
				$('<td width="140px;"></td>').text($($this).val()).appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerTotalFees" id="ledgerTotalFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.ledgerTotalFees" value="'+$("#packageFees"+id).val()+'" onkeyup="calculate();" onblur="calculate();" /></td>').appendTo(row);
				
			/* 	//change
				$('<td><input type="text" style="width:80px;" class="ledgerGrossFees" id="ledgerGrossFees'+id+'" value="" readonly="true" /></td>').appendTo(row);
		 */
				$('<td><input type="text" style="width:80px;" class="ledgerAlreadyPaidFees" id="ledgerAlreadyPaidFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerAlreadyPaidFees" value="0.0" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerPaidFees" id="ledgerPaidFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerPaidFees" value="" onkeyup="calculate();" onblur="calculate();" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="ledgerPendingFees" id="ledgerPendingFees'+id+'" name="ledgerFeesPaids['+id+'].ledgerPendingFees" value="0.0" readonly="true" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="startDate " id="startDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.startDate" value="'+startDate+'" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="endDate" id="endDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.endDate" value="'+endDate+'" /></td>').appendTo(row);
				$('<td><input type="text" style="width:80px;" class="dueDate" id="dueDate'+id+'" name="ledgerFeesPaids['+id+'].ledgerFees.dueDate" value="" /></td>').appendTo(row);
				$('<td><s:hidden name="ledgerFeesPaids['+id+'].ledgerFees.ledgerFeesId" value="0" /></td>').appendTo(row);
				$('<td><s:hidden name="ledgerFeesPaids['+id+'].ledgerFeesPaidId" value="0" /></td>').appendTo(row);
				
				assignStartDate(id);
				assignEndDate(id);
				assignDueDate(id);
			}
			else{
				$("#packageId"+id).val($("#packageId"+id+" option:first").val()).attr('disabled',true);
				$("#row"+id).remove();
				
				if($("#fees tbody tr").length == 0){
					$("#feesData, #saveData, #receiptData, #paymentData").hide();
					//alert("sewt false");
					 $("#regCheckBox").prop('checked', false);
					//$("#displayRegistrationFee").prop("checked",false);
				}
			}
			
			calculate();
					
				//=================================	
		})
		.fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Fetching. Please Try Again...").show();
		});
	//}	
	
	
};

//Assign Datepicker to start date and calculate end Date
var assignStartDate = function(id){
	//Datepicker
	$("#startDate"+id).datepicker({
		changeMonth: true,
		changeYear: true,
		dateFormat: 'dd/mm/yy',
		minDate:$("#startDate"+id).val(),
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
		minDate:$("#endDate"+id).val(),
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
	
	$("#dispMemberId").val(0);
	$("#membersNameAutocomplete1").val("");
	
	$.each($(".check"),function(){
		this.checked = false;
		$(this).attr("onclick", "onCheck(this);");
	});
	$.each($(".packageId"),function(){
		$(this).prop('selectedIndex',0).attr('disabled',true).attr("onchange", "onPackageSelect(this);");
	});
	
	$("#fees tbody").empty();
	
	//$("#tax").val("");
	
	$("#paymentMode").val("");
	$(".transactionDetail").val("").attr('readonly',true);
	$("#transactionDate").val("").attr('disabled',true);
	$("#displayRegistrationFee").val("");

	calculate();
};
var addRegFees = function(){	
	if($("input[name='regCheckBox']").is(":checked")){
	//if($('.regCheckBox').is(":checked")){	
			$("#regFees").show();
			$("#tdRegFees").show();	
			//alert($('.regCheckBox').is(":checked"));
	    	totalFees =parseFloat($("#totalFees").val())+parseFloat($("#displayRegistrationFee").val());
	   		//alert(totalFees );
	   		$("#totalFees").val(totalFees.toFixed(2)); 
  		}
	else{
		$("#regFees").hide();
		$("#tdRegFees").hide();
	}
/* 	else{
		$("#regFees").hide();
		$("#tdRegFees").hide();
		//alert(($('.regCheckBox').is(":checked")));
		totalFees =parseFloat($("#totalFees").val())-parseFloat($("#displayRegistrationFee").val());
		$("#totalFees").val(totalFees.toFixed(2)); 
	} */
}
//Calculate All Fees
var calculate = function(){
	
	var totalFees = 0;	
	$.each($('.ledgerTotalFees'), function() {
   	 if(!isNaN(this.value) && this.value.length!=0) {    		 
   		 totalFees += parseFloat(this.value);
   		//alert(totalFees );
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
		
		//alert($("#ledgerTotalFees"+id).val());
			if(!isNaN($("#ledgerTotalFees"+id).val()) && ($("#ledgerTotalFees"+id).val()).length!=0) {
			ledgerPendingFees += $("#ledgerTotalFees"+id).val();
			
		} 
			
		if(!isNaN($("#ledgerAlreadyPaidFees"+id).val()) && ($("#ledgerAlreadyPaidFees"+id).val()).length!=0) 
			ledgerPendingFees -= $("#ledgerAlreadyPaidFees"+id).val();
		
		if(!isNaN(this.value) && this.value.length!=0) 
			ledgerPendingFees -= parseFloat(this.value);
		
		
		 if(ledgerPendingFees == 0 || totalPendingFees == 0){			
			 $("#dueDate"+id).val("").attr('readonly',true).attr('disabled',true);
		 }
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
	
    addRegFees();
    calculateTax();  
  
};


//==================================================================================================================
	//calculate tax
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
	var taxType=$('input:radio[name=taxTypeGroup]:checked').val(); 
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
	  $("#taxType").val(taxType);
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
				if(ledgerPendingFees == 0){
					$("#dueDate"+id).val("").attr('readonly',true).attr('disabled',true);								
				}			    	
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
};

//====================================Not used==============================================================================
// old Calculate Tax
var calculateTax1 = function(){
	var tax = 0;
	if(!isNaN($("#tax").val()) && ($("#tax").val()).length!=0) 
		tax = parseFloat($("#tax").val());
	
	var totalTaxAmount = 0;
	var finalAmount = 0;
	var taxType=$('input:radio[name=taxTypeGroup]:checked').val();  
	
    if(taxType=="Exclusive"){
    	//Exclusive
    	$.each($('.ledgerGrossFees'), function() {
    		 //change
    		
      	 	var id = $(this).attr('id').substring(15); 
      	 	//alert("each gross..."+id);
       	 	var ledgerGrossFees = 0;
       		if($('#errorDisplay'+id).length != 0)
     			$("#errorDisplay"+id).remove();
       	 
     		if(!isNaN($("#ledgerTotalFees"+id).val()) && ($("#ledgerTotalFees"+id).val()).length!=0) 
     			ledgerGrossFees = parseFloat($("#ledgerTotalFees"+id).val());
     		
     		
     		if(ledgerGrossFees<0){
   				var message="<label id='errorDisplay"+id+"' class='error'>Error..</label>";		//Create Message
   				$("input#ledgerGrossFees"+id).after(message);																	//Append Message
   				$("#makePayment").attr('disabled',true);
   			}
   			else{
   			// alert("each gross..."+ledgerGrossFees);
   				$("#ledgerGrossFees"+id).val(ledgerGrossFees.toFixed(2));
   				$("#makePayment").attr('disabled',false);
   			}
    	});   	
    	
    	$.each($('.ledgerPaidFees'), function() {
    		var ledgerPaidFees = 0;
    		if(!isNaN(this.value) && this.value.length!=0) 
    			ledgerPaidFees = parseFloat(this.value);
    		
    		var taxAmount = 0;
    		taxAmount = ledgerPaidFees*tax/100;    		
    		totalTaxAmount += taxAmount;
    	});   	
    	var totalPaidFees=parseFloat($("#totalPaidFees").val());
        $("#totalGrossFees").val(totalPaidFees.toFixed(2));   //change
    }else{
    	//Inclusive  	
    	var totalGrossAmount=0;
    	$.each($('.ledgerPaidFees'), function() {
    		var ledgerPaidFees = 0;
    		if(!isNaN(this.value) && this.value.length!=0) 
    			ledgerPaidFees = parseFloat(this.value);   		
    		
    		var grossAmount=(ledgerPaidFees*100)/(tax+100); 
    		totalGrossAmount+=grossAmount;
    		//alert(totalGrossAmount);
    		var taxAmount = 0;	    		
    		taxAmount = ledgerPaidFees-grossAmount;    		
    		totalTaxAmount += taxAmount;
    		
    	});
    	$("#totalGrossFees").val(totalGrossAmount.toFixed(2));   //change
    }
  //$("#totalTaxAmount").val(totalTaxAmount.toFixed(2));
	
	//var finalAmount = 0; totalGrossFees
	/* if(!isNaN($("#totalPaidFees").val()) && ($("#totalPaidFees").val()).length!=0)
		finalAmount = parseFloat($("#totalPaidFees").val()); */
	if(!isNaN($("#totalGrossFees").val()) && ($("#totalGrossFees").val()).length!=0)
			finalAmount = parseFloat($("#totalGrossFees").val());
	finalAmount += totalTaxAmount;
    
	$("#totalTaxAmount").val(totalTaxAmount.toFixed(2));
	$("#finalAmount").val(finalAmount.toFixed(2));
};

//====================================Not used==============================================================================
//// Old calculate discount function
var calculateDiscount1=function(){
	var Discount=$("#discount").val();
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
    
  /*  var ledgerpaidFees=$('.ledgerPaidFees').val();
   var ledgeralreadypaidFees=$('.ledgerAlreadyPaidFees').val();
   var ledgerpendingFees=ledgeralreadypaidFees-ledgerpaidFees-Discount;
   $('.ledgerPendingFees').val(ledgerpendingFees.toFixed(2)); */
	 
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
	
};
//====================================Not used==============================================================================

</script>

</head>
<body onclick="parent_disable();">
	<!-- <div style="margin: 0 -12%"> -->
	<div>
		<s:form id="memberFeesForm" name="memberFeesForm" theme="css_xhtml">
		<s:textfield name="receiptType" id="receiptType" value="Advance" style="display:none;"/>
		<s:textfield name="regFeesStatus" id="regFeesStatus" value="" style="display:none;"/>
			<fieldset>
			<legend>Make Payment</legend>
				<table>
					<tr>
						<td><label>Member Id</label></td>
						<td><s:hidden name="memberId" id="dispMemberId" value="%{memberId}" /> 
							<s:if test="memberId != 0">
								<s:textfield name="displayMemberId" id="displayMemberId1" value="M%{memberId}" placeholder="M1" onkeyup="upperCase(this);"/>
							</s:if>
							<s:else>
								<s:textfield name="displayMemberId" id="displayMemberId1" value="" placeholder="M1" onkeyup="upperCase(this);"/>
							</s:else>
						</td>
						<td><label>Member Name</label></td>
						<td><s:textfield id="membersNameAutocomplete1" name="membersNameAutocomplete"
								placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" value="%{name}" /></td>
						<td><label>Contact No.<span class="required">*</span></label></td>
						<td valign="top"><s:textfield name="contactNo" id="contactNo1"
								value="%{contactNumber}" /></td>
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
												onclick="onCheck(this);" /></td>
											<td width="160px;"><label><s:property value="ledgerName" /></label></td>
											<td><label>Package</label></td>
											<td><s:hidden id="packageFees%{ledgerId}" value="%{packageFees}" /> 
												<s:select name="ledgerFeesPaids[%{ledgerId}].ledgerFees.packageId" id="packageId%{ledgerId}" 
													list="ledgerPackageMaps" cssStyle="width:40px; padding: 0px" value=""
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
						<!-- <td><input type="checkbox" class="regCheckBox" id="regCheckBox" name="regCheckBox" onclick="calculate()"/></td> -->
						<td><s:checkbox name="regCheckBox" id="regCheckBox" onclick="calculate();"/></td>
						<td><label>Registration Fee</label></td>
						<%-- <td><s:textfield name="displayRegistrationFee" id="displayRegistrationFee" value="%{displayRegistrationFee}"/> </td> --%>
					</tr>
					<tr>
						<td><s:textfield name="receiptNo" id="receiptNo" value="%{displayReceiptNo}" readonly="true"/>
						<%-- <s:textfield name="finalReceiptNo" id="finalReceiptNo" value="%{displayFinalReceiptNo}" readonly="true"/> --%></td>
						<td><s:textfield name="receiptDate" id="receiptDate" value="">
								<s:param name="value"> <s:date name="new java.util.Date()" format="dd/MM/yyyy" /> </s:param>
							</s:textfield></td>
						<td><s:textfield name="tax" id="tax" value="%{displayTaxAmount}" onkeyup="calculateTax();"  onblur="calculateTax();" style="width:80px;" /></td>
						<td><label>%</label></td>
						 <td colspan="2" style="padding-left:20px;">	
						 Inclusive  <input type="radio" name="taxTypeGroup" id="taxType2" value="Inclusive" onclick="calculateTax();" checked="checked" >		 
						 Exclusive  <input type="radio" name="taxTypeGroup" id="taxType1" value="Exclusive" onclick="calculateTax();">&nbsp;&nbsp;
						 <s:hidden name="taxType" id="taxType" value="Inclusive"/>
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
							<!-- <th width="100px;"><label>Gross Fees</label></th> -->
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
						<td  width="19px"></td>
						<td width="100px;" style="display: none" id="regFees"><label>Registration Fees</label></td>
						<td><label>Total Fees</label></td>						
						<td><label>AlreadyPaid Fees</label></td>
						<td><label>TotalPaid Fees</label></td>
						<td><label>TotalPending Fees</label></td>
						<td><label>TotalGross Fees</label></td>   <!-- change   -->            
						<td width="19px"></td>
						<td><label>Tax Amount</label></td>
						
						<td><label>FinalAmountWithTax&nbsp;&nbsp;</label></td>	
						<td><label>AdvanceAmount</label></td>				
					</tr>
					<tr>
					<td>
						<td style="display: none" id="tdRegFees" ><s:textfield name="displayRegistrationFee" id="displayRegistrationFee" value="%{displayRegistrationFee}" readonly="true"  cssStyle="width:80px;" /> </td>
						<td><s:textfield id="totalFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td><s:textfield id="totalAlreadyPaidFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td><s:textfield name="totalPaidFees" id="totalPaidFees" value="0.0" readonly="true" cssStyle="width:80px;"/></td>
	
						<td><s:textfield id="totalPendingFees"  name="totalPendingFees" value="0.0" readonly="true" cssStyle="width:80px;"/></td>
	
	<!-- change   --> 	<td><s:textfield name="totalGrossFees" id="totalGrossFees" value="0.0" readonly="true" cssStyle="width:80px;" /></td>
						<td>+</td>
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
			<fieldset id="saveData">
				<s:submit id="makePayment" value="Make Payment" action="makePayment" align="center" ></s:submit>
				</fieldset>
		<!-- <div id="dialog" style="display: none;"> -->
				<!-- <div id="dialog" title="Please confirm that you want to submit"> -->
			<%-- <p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 0 0;"></span> Are You Sure You Enter Correct Fees:</p> --%>
		<!-- 	<p id="dialog-confirm"></p>
			<p>If this is correct, click Submit Form.</p>
			<p>To edit, click Cancel.</p> -->
		<!-- </div> -->
		
			
		
			<%-- <fieldset id="saveAdvanceData" style="display: none;">
				<s:submit id="makeAdvancePayment" value="Make Payment" action="makeAdvancePayment" align="center" />
			</fieldset> --%>
			<s:token />
		</s:form>
	</div>

</body>
</html>