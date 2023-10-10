//Convert strings All letter to upper case
var upperCase = function(string)
{
   $(string).val($(string).val().toUpperCase());
};

//Convert strings to Sentence case
var sentenceCase = function(string)
{
   $(string).val($(string).val().charAt(0).toUpperCase() + $(string).val().substr(1).toLowerCase());
};

//Convert strings first letter to upper case
var firstUpper = function(string)
{
   $(string).val($(string).val().charAt(0).toUpperCase() + $(string).val().substr(1));
};

//Convert words first letter to upper case
var firstCharWordUpper = function(string)
{
	var str =$(string).val();	
	//str = str.toLowerCase();
	//Replace first characters in a word with upper case character:  str.substring(0,1).toUpperCase()
	str = str.replace(/(?:_|\b)(\w)/g, function(str, p1) { return p1.toUpperCase();});
	//Replace first characters in a word with upper case character:
	//str = str.replace(/(?:_|\b)(\w)/g, function(str, p1) { return p1.toUpperCase();});
	//Replace all _ and spaces and first characters in a word with upper case character:
	//str = str.replace(/(?:_| |\b)(\w)/g, function(str, p1) { return p1.toUpperCase();});
	$(string).val(str);
};

//Date Utility to convert 'yyyy-MM-dd' format date to 'dd/MM/yyyy' format 
var convertToUserDate = function(date){
	if(date == null)
		return date;
	var dateAr = date.split('-');
	var newDate = dateAr[2] + '/' + dateAr[1] + '/' + dateAr[0];
	return newDate;
};

var currentDate = function(){
	var d = new Date();
	var month = d.getMonth()+1;
	var day = d.getDate();
	return (day<10 ? '0' : '') + day + '/' +  (month<10 ? '0' : '') + month + '/' +  d.getFullYear() ;
};


//Add Days months and Years to date
var addDaysMonthsYears = function(date, addDays, addMonths, addYears){
    if(date.length!=0) {
		from = date.split("/");
		var date1 = new Date(from[2], from[1]-1, from[0]);
		
		date1.add(parseInt(addYears)).years();
		date1.add(parseInt(addMonths)).months();
		date1.add(parseInt(addDays)).days();
		
		var day = date1.getDate();
		var month = date1.getMonth()+1;
		var year = date1.getFullYear();
		
		var date2 = (day<10 ? '0' : '') + day + '/' +  (month<10 ? '0' : '') + month + '/' + year;

		return date2;
    }
    else
    	return "";
};