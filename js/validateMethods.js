
	//	Add Validation method for eMAIL
	$.validator.addMethod("checkMail", function(value, element) {
		return this.optional(element) || /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(value);
	}, "Enter Valid email Id ex(abc@gmail.com).");

	//	Add Validation method for Contact Number
	$.validator.addMethod("checkMobilNo", function(value, element) {
		 valid = false;
		    check = /^(\+\d{1,3}[- ]?)?\d{10}$/.test(value);
		    if(check==true)
		        valid = true;
		return valid;
	}, "Enter Valid 10 Digit No.");
	
	//	Add Validation method for Text Only
	$.validator.addMethod("textOnly", function(value, element) {
		 valid = false;
		    check = /[^-\.a-zA-Z\s\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02AE]/.test(value);
		    if(check==false)
		        valid = true;
		    return this.optional(element) || valid;
	}, "Please enter letters only");		

	$.validator.addMethod("nameText", function(value, element) {
		 valid = false;
		    check = /[^a-zA-Z]/.test(value);
		    if(check==false)
		        valid = true;
		    return this.optional(element) || valid;
	}, "Please enter characters only");	
	
	//	Add Validation method for integer/float value Only
	$.validator.addMethod("valueOnly", function(value, element) {
		 valid = false;
		    check = /[^-\.0-9\s\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02AE]/.test(value);
		    if(check==false)
		        valid = true;
		    return this.optional(element) || valid;
	}, "Please enter digit only");
	
	//	Add Validation method for date
	$.validator.addMethod("checkDate", function(value, element) {
		return this.optional(element) || validateDate(value);
	}, "Date should be like DD/MM/YYYY");
	
	//	Validation for date
	function validateDate(inputText)  
	{  
		var dateformat = /^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/;  
		// Match the date format through regular expression  
		if(dateformat.test(inputText))  
		{  
			//Test which separator is used '/' or '-'  
			var opera1 = inputText.split('/');  
			var opera2 = inputText.split('-');  
			lopera1 = opera1.length;  
			lopera2 = opera2.length;  
			var pdate=0;
			// Extract the string into month, date and year  
			if (lopera1>1)  
			{  
				pdate = inputText.split('/');  
			}  
			else if (lopera2>1)  
			{  
				pdate = inputText.split('-');  
			}  
			var dd = parseInt(pdate[0]);  
			var mm  = parseInt(pdate[1]);  
			var yy = parseInt(pdate[2]);  
			// Create list of days of a month [assume there is no leap year by default]  
			var ListofDays = [31,28,31,30,31,30,31,31,30,31,30,31];  
			if (mm==2)  
			{  
				var lyear = false;  
				if ( (!(yy % 4) && yy % 100) || !(yy % 400))   
					lyear = true;  
				if ((lyear==false) && (dd>=29))  
					return false;  
				if ((lyear==true) && (dd>29))  
					return false;  
				else
					return true;
			} 
			else
			{
				if (dd>ListofDays[mm-1])  
					return false;
				else
					return true;
			}
		}  
		else {  
			return false;  
		}  
	}  
	
	
	//Add Validation method for Due date
	$.validator.addMethod("checkMemberId", function(value, element) {
		valid = true;
		stringMemberId =  (element.value).substring(0,1);
		intMemberId = (element.value).substring(1);
		 if(intMemberId > 0 && stringMemberId == 'M'){
		        	valid = true;
		    }
		 else
			 {
			 	valid = false;
			 }
    		
		return valid;
	}, "Enter Valid Member Id Ex: M1");
	