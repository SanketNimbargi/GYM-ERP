//Check Available for single textfield
function checkAvailable(action,textField,message)
{
	var checkValue = $("#"+textField).val();
	$( "#save" ).attr( "disabled", true );
	$( "#update" ).attr( "disabled", true );

	$.getJSON('ajax/'+action+'.action', { checkValue : checkValue , columnName:textField}, function(data) {

		if (data.present.trim() == "present") 
		{
			if($('#errorDisplay').length == 0)
			{
				var append="<label id='errorDisplay' class='error'>"+message+"</label>";	//Create Message
				$("input#"+textField).after(append);										//Append Message
			}
		} 
		else {
			$("#errorDisplay").remove();
			$( "#save" ).attr( "disabled", false );
			$( "#update" ).attr( "disabled", false );
		}
	});
}

//Check Available for Two textfields
function checkAvailableTwo(action,textField1,textField2,message)
{
	var checkValue1 = $("#"+textField1).val();
	var checkValue2 = $("#"+textField2).val();
	$( "#save" ).attr( "disabled", true );
	$( "#update" ).attr( "disabled", true );

	$.getJSON('ajax/'+action+'.action', { checkValue1 : checkValue1 , columnName1:textField1,checkValue2 : checkValue2 , columnName2:textField2}, function(data) {
		if (data.present.trim() == "present") 
		{
			if($('#errorDisplay').length == 0)
			{
				var append="<label id='errorDisplay' class='error'>"+message+"</label>";	//Create Message
				$("input#"+textField2).after(append);										//Append Message
			}
		} 
		else {
			$("#errorDisplay").remove();
			$( "#save" ).attr( "disabled", false );
			$( "#update" ).attr( "disabled", false );
		}
	});
}