<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
 
<head>
<link rel="stylesheet" href="/css/jquery-ui.css">
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/jquery-ui.js"></script>
<!-- This Java Script should be used for TTS. Text To Speech-->
<%-- <script type="text/javascript" src="<%=request.getContextPath()%>/js/tts/speakClient.js"></script> --%>

<style>

body {
	font-family: "Trebuchet MS", "Helvetica", "Arial",  "Verdana", "sans-serif";
	font-size: 62.5%;
}
</style>

<style type="text/css">
.topClass{
	margin: 0;
}
.labelClass{
font-size: 15px;
font-family: Verdana;
}
#notificationLists {
	width:160px;
    height: 450px;
    margin-left: 5px;
    float: left;
    overflow: auto;
    overflow-x: hidden;
    
}
 #toggle {
  /*   width: 100px;
    height: 100px;
    background: #ccc; */ 
  }
  div.picture1 {
   width:15px;
   height:300px;  /*height of your image*/
  <%--  background-image:url('<%=request.getContextPath() %>/images/leftToggle.jpg') ; --%> /* url('yourimage.file'); */
   margin: 50px 0px 0px 0px;  /* If you want no margin */
   padding:0;
   text-align: center; 
}

</style>

</head>
<body>

		<!-- Working -->		
		<s:form theme="css_xhtml">
		<td colspan="2"><s:textfield id="membersNameAutocompleteNotification" name="membersNameAutocomplete" 
							placeholder="First Name Middle Name Last Name" cssStyle="width:250px;" /></td>
		</s:form>		
		
 <div>
		<fieldset id="fieldset1"><legend>Daily Attendance</legend>
		<div style="width: 100%;">	
		<table>
		<tr><td>Member Id <input type="hidden" name="memberId" id="memberId" value="" /><input type="hidden" name="attendanceId" id="attendanceId" value="" /></td>
		<td><input type="text" name="displayMemberId" id="displayNotificationMemberId" placeholder="" onkeyup="upperCase(this); " tabindex="0"/></td>
		<td>Member Name <input type="text" id="membersNameAutocompleteNotification" name="membersNameAutocomplete" placeholder="First Name Middle Name Last Name" style="width:250px;" /></td>
		<td>Contact No.<input type="text" name="contactNo" id="contactNoNotification"	value="" /></td>
		</tr>
		</table>
        
        <table table class="display" id="attendanceDetails" style="display: none;" border="">
        <tr><td id="image" align="center" rowspan="3"></td><td><label>Member name</label></td><td><label>In Time</label></td>	<td><label>Out Time</label></td></tr>
		 <tr id="tr"><td><label id="memberName"></label></td>
						<td><input type="button" id="in" class="mybtn"  tabindex="1" value="In" class="smallBtn"/>
						<input type="text" name="inTime" id="inTime" readonly="true" value="00:00" style="width:80px; display:none;" /></td>
						<td><input type="button" id="out" class="mybtn"  tabindex="2" value="Out" class="smallBtn"/>
						<input type="text" name="outTime" id="outTime" readonly="true" value="00:00" style="width:80px; display:none;" /></td>
					</tr>	
		 </table>
		 </div>
		 </fieldset>
		 
		 <fieldset id="fieldset2" style="display:none;">
		 <div>
		 <table align="left" >
			<tr>
			<td><label>Member Id</label></td><td style=" padding-left: 16px;"><label id="memberIdForDisplay"></label></td><td style=" padding-left: 16px;"></tr>
			<td><label>Joining Date</label></td><td style=" padding-left: 16px;"><label id="joiningDate"></label></td><td style=" padding-left: 16px;"><label>Total Fees</label></td><td><label id="totalFees"></label></td></tr>
			<tr><td><label>Due Date</label></td><td style=" padding-left: 16px;"><label id="dueDate"></label></td><td style=" padding-left: 16px;"><label>Paid Fees</label></td><td><label id="paidFees"></label></td></tr>
			<tr><td><label>End Date</label></td><td style=" padding-left: 16px;"><label id="endDate"></label></td><td style=" padding-left: 16px;"><label>Pending Fees</label></td><td><label id="pendingFees" ></label></td>
		<!-- 	<tr><td><input type="button" id="testFing" class="mybtn"  tabindex="4" value="Test Finger Prints" class="smallBtn"/>
					 	<label id="scanMessage"></label></td>
					 	<td> Current Scanned Id <input type="text" id="currentId"/>
					 	
			</tr> -->
		 </table><br>	
		  <table id="memberInfo">
		  </table>	
	   </div>
		</fieldset>	
 
</div>


</body>
<script type="text/javascript">
	function beep1() {
	    // Beep Sound For Presenty
		var snd = new Audio("data:audio/wav;base64,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qJrx4KOQjahZxWbcZgztj2c49nKmkId44S71j0c8eV9yDK6uPRzx5X18eDvjvQ6yKo9ZSS6l//8elePK/Lf//IInrOF/FvDoADYAGBMGb7FtErm5MXMlmPAJQVgWta7Zx2go+8xJ0UiCb8LHHdftWyLJE0QIAIsI+UbXu67dZMjmgDGCGl1H+vpF4NSDckSIkk7Vd+sxEhBQMRU8j/12UIRhzSaUdQ+rQU5kGeFxm+hb1oh6pWWmv3uvmReDl0UnvtapVaIzo1jZbf/pD6ElLqSX+rUmOQNpJFa/r+sa4e/pBlAABoAAAAA3CUgShLdGIxsY7AUABPRrgCABdDuQ5GC7DqPQCgbbJUAoRSUj+NIEig0YfyWUho1VBBBA//uQZB4ABZx5zfMakeAAAAmwAAAAF5F3P0w9GtAAACfAAAAAwLhMDmAYWMgVEG1U0FIGCBgXBXAtfMH10000EEEEEECUBYln03TTTdNBDZopopYvrTTdNa325mImNg3TTPV9q3pmY0xoO6bv3r00y+IDGid/9aaaZTGMuj9mpu9Mpio1dXrr5HERTZSmqU36A3CumzN/9Robv/Xx4v9ijkSRSNLQhAWumap82WRSBUqXStV/YcS+XVLnSS+WLDroqArFkMEsAS+eWmrUzrO0oEmE40RlMZ5+ODIkAyKAGUwZ3mVKmcamcJnMW26MRPgUw6j+LkhyHGVGYjSUUKNpuJUQoOIAyDvEyG8S5yfK6dhZc0Tx1KI/gviKL6qvvFs1+bWtaz58uUNnryq6kt5RzOCkPWlVqVX2a/EEBUdU1KrXLf40GoiiFXK///qpoiDXrOgqDR38JB0bw7SoL+ZB9o1RCkQjQ2CBYZKd/+VJxZRRZlqSkKiws0WFxUyCwsKiMy7hUVFhIaCrNQsKkTIsLivwKKigsj8XYlwt/WKi2N4d//uQRCSAAjURNIHpMZBGYiaQPSYyAAABLAAAAAAAACWAAAAApUF/Mg+0aohSIRobBAsMlO//Kk4soosy1JSFRYWaLC4qZBYWFRGZdwqKiwkNBVmoWFSJkWFxX4FFRQWR+LsS4W/rFRb/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////VEFHAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAU291bmRib3kuZGUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAMjAwNGh0dHA6Ly93d3cuc291bmRib3kuZGUAAAAAAAAAACU=");  
	    snd.play();		 
	    
	}
	function beep2() {
		 // Beep Sound For Member having Pending Fees
		var snd = new Audio("data:audio/wav;base64,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ASYIWAcEj0a5xGWaZTDQwAo/L7n4aXKOhBjGIApZps9YUbh5AfIKaNChSZQUiQS7Tvs1pt/v/gvWD2qzMtFNWeiWtNEhsTmmR2UiIb1hxSfHyZYVoVLI8EIlXPbrhMUIivUyRExcXrKxIcNxDdFXHqEmOlty4CTTB8sYOpq8vLqfi71F5ub0mZBCAIVsiQBQAC3ZnwBADXYXLMCwAAWAwWejMYA4c5jiofGBhcPqboTEJa/MLD/kAIZTuGeBSmdBMr5ghY0P5T4oEpQ1NRWzzuv76vhvmNZlUjKnodj/jNrSxI9QpE4UMTC0TNQuLtPuDY3KVNHDEorm5Ov/+pLArejlABctCU2u7eu6ciEpNd2xd2zRGJdLT5VQ4b9lcU9ajT4aqiuUPOIrlHb3F9thu1w8QNvfmuncFmnccN1FP//////////////////////////////////////////////////////////////////////////////////////////////////////////////2aJDRT21rYAcBrhIZqGSVGwwZCks26IcAZggIBzU9ocYZ1aQDsOheUCwoMImzMkfle8Yp3IbaJyqNVBEBRFgiEv03WCKecib8xsqLHj1e2ZRrXzoqltsuI1XPCShJHzxePTy0d+OzAGrI0j6TK2LJaXoi5SwRFhaaNlcyW6JLbf+++qgdWM0+knE5jfe1E9RMbldYkYffWtokQ0VNtbGApCA03lg3SLAEgwMEnmUoKjwLnOpkDw25tGiq38QuQaxMRA4VpQUqv9S07Jpdhfh6JX7Nzjtz8Qj+Ef+sT09zw+pgzgUFQc0EsJzdAfJx4SnUQ5l0sVH9cWanqU0OR9oWMJZKZocrzEwiNVaw//qSwEGx/4AeaQk/r23rsl2g6PXdMXawXUBpw6Cl9Kf1xo3PkRSwsK+fX9ZRG7LNaJHdbO13/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////3qZDaU3+0YFdpSgJap4SEEDAfUBR6AoCAgHPdC4eAZFYeerT5PWqoIQMwy/MxAXIm3Mw3rcH5dt9/C7vDP94MzG+VK+r3aoTMdsQkpXBW7qo6LlCV0filrArFUZOknpWvIrMrFSx1SaXYVVC8DJgJpsO4xobI4wl60FcQ561radljSSKqBSufj/NZNv0aG6IkNAu2yNAQ03Qvk1xpQUAEwNEAHAE01BCYDiIdhsOGFnNlyZqupBZpBICXrMIbHxcUtwit3W3+is9hnlasV+WvpKZ9ptmkSxh6qtMGNjne12Ayg1OeVP49YnrLWUl6et4qpaqksR3EfNI+ocNQIRYVG12//6ksDEgP+AH5kHSa7ti7o4IKm1zb12efR3s+nOi0wd9l+tN5lul1f///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////5YAA0ApbGiBAsBF3WzwwWqAAJZqyoMAgEG57bhAYql9FRUY9a8I6SgAMRAoAxEgTrPLIea/8aWixs/zuWV+m+x6RkUoThuBtAKR6QK2hWCgaWaIk5AKYCT5FRsyfVEhMDNtx+pbxXevYpmMkUc1aF0n2biritRuhrbyr/6/thNuiRNQDtsiQDFIbR0YhJ1CTCMFEuocEQFjAYGnM/pOJUxBnZIOVRlq3okFRA5eDJUM8//7yD6l+X97nTX7cM27cqX2Q7OJ2KtQGbIujOcusWNFSJyi9yNG+oXIdyyXG4Ejixe/G5ZIiiXsMPrevmMavdjnc//+pLA1dn/gCF5BUOu6Yu5+6Dntc0ldraxtPyl4dn/3Iq1Zx9Rr///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+/JFVgq2yNALckBcJEhXiSYcFqJDZxQCiAITB6KhwKyiJu0jiWsctCkv+icKznwl/c+87zL+//ssTaUuai0kHnOOSw5AYSWTjFY5KOUy0xOSKBhelhOnCBBGRmdog/qRTIMEbssiHyi7lSvaVHTJnnWsyZqBndl/85qQDGArLIiAxTIgAKrFKwoAhIHuvMkQDLAQM1YcDDFpSgvukpRrAqXFuCoKENQSYS+13//99/H/ii+BiBa43ku73d+XTC1Z8w7HE5tDpo/jPTz8hL7+kZk8hVSkxI2tfXrVcDqaaNzR+jGGlxFCNG59t/+///qSwD+D/4AiUQlBrumLseId6HXdJW//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////vrZMgCtsjQCrYYaCoPAAjAJiYPNIWyMAgu2cF5QDVxiLEJBCciIjQBRQNnhjAQ6BnnQ+2l9uMPmopfLLwmpN81B8pJKK0kJBVRTa7epa5XzFC2wik5hqsSmWteE5r7BGWR2opJjddcTBBQT1hRqg5r6kDWArbIiAxSQBUHLkLZQYMLF3HpEb4APO/Q4EPXWAwSC4gxQFwCIwxkQukC1hJD/b1NiEDjVQdbGwUtXviQOKuUWJbgiWueMxSIkyNSqEr6Q+CNEijUozirpBqv1t2u9wTDjTosL6eS/////////////////6kMB5wP+AI0DXP65pi3m+nah1yaVu////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+akgxAKSNogSHF8VCWuIYggFSiEAYQppnK44PPLUe5ksvaMjTSpaMnEIJP7TY///++fn/9xzrWcb+KWZ9mY+B9CZyS0sn+vp1RmHR6OH59Zp2ZarazbLvKtpM1kvB9DtZkdL4ox2Mat2kgNgKSNkAY++MtfksAgGhebTTUFWQdQiJEq0qirSYYAlLZUAQGFGWxPnCf///+d/D+TTQ8i8VOxZzjnOgQwixsj4c3GolOQpZI5bXMqYkx7aFLzYtpnvk46c19YF3//////////////////////////////6ksAmF/+AJHDdQa3RK3GeHie1zJl2////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+akgyAOSxogZbkTL2EEoBEQIjydqTTYjgKWDYh0oiFA/cFrCEgd0AiYIghPoPip/rXMaFe9/bX747PFd7CIKKwYddiWc+yF61E2dIJZ/3mPnfXb/ZffNVzlC6Fmi1XtRmigMgCkjaIF6XO2vCVpTCMUtja8FwPBxyA4iyLToFfpG1NCOPC4QIBJbR5XWf///z8cv8EhjJYCJkUklmKCA2dU6tqiZXBWiTgMhYtyKsDJwwQ19tXaoI6EJhWZgnaksp6/Nu1//////////////////////+pLAZLv/gCVw0TuuZQt5fZrn9cmZbv////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////91UBkJdtkSAqV6FxZchxJQ5/jAAkzAhUeJ3sS+X3P1mZkwDYm4iIBf4W3SHnZ/+d/9/97n2rqlpVsOekIejVNC0yogKx/pFwzwUwxtzvVHe5upgzMMZDBAsnIRZN6eLpcmDaS5I2QBB1uijySoJCgoPtNUmm0sCfYsJ8sQaG2wFLT5fVUBe8HFiKUnjqxb///5zVP/5Hk4dGOcL+RwLRoay57bz0iw2IoiZLigCwDPdockt/////////////////////////////////////////////qSwO0v/4AlfN89rmRreXwX6HW8oW7//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8ubBlJkkbJAhGOctkYMAzDToeAi9s6jMd68goZxnGYuRMRYLgoKl3V8sFJ44rvnP/95Yyqm/p2u3ipbhrieLBDe5rmre6L+Iut3MmooghxaigIAmZcshZXlzGk36tCbNgyFSSNogQnCyps5KORiBGrSw4mA1ZzjIx4XYpUXl1uhIX6jJCEIkBc6c1zK7fzl9vkO4d75lsz3jfzLNDsm7brTUu/ed1pyN7Dbr1rmm/Xvf39PmnF3NE7nUsP5Lv/////////////////////////////6ksAD9/+AJaS3Pa3ka3F3Fqe1vKFu/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////mzYNhUkjaAEm269K2RqBhYQpytQs+3Y0eBdxKXRbBFp2rvEpU/iTxFrVvPt2k9lmXZP/oh1LV2sjNXaKZS2n6Z192QPIZZSorrZ673inLcwyq6Sm9gVyltsiAHPwtw6452IjwqMzDINAEpOVvXvaHebk7sqSIGSg6oZNnInLp2ns0iIDfUiPS1mroKZqFNb3ZElFt1s9Fq0nZ2XrNgONUPgjVsb1f//////////////////////////////////////////////+pLA/13/gCb4zz2t5Mt5TRpn9bwJb/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////83kCvc1tkQA59muztmBQWhT0F7Y4KRVuMSkTmORD7rvQWuU0FYiBkzhelKAR2biP09qCdaV0vR9juvVUATkZGmftu5jmoVLLqzcQHjmsVz6JvYDe5bbI0Bz8t6QzA3DDK7EK5g9SOx5QA90w7kdd5AIO2FEl/VwveuFvv/7Mq7eIdbkZWOqKxZXMoGarbvOq7lZiSwVtLXKU7HmRydgUKgMGGhQQFSy79vUr////////////////////////////////////qSwCdp/4AnXKNFrOmpcUCXaLWtCW7/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////5vYFe7bbIgB/2qzrqqHU7S2wujwys4Aa3ehqNRlc9lAhIBlYm0tW1HCISMyDEsXYJauqm748752qw5kRUpS6UUxzehOOImGNWi+Tm1ib2BXy22yIAc6TQpMDzCBDOji8xqpocC3J+B52tLcExRU8Tgaj/CAE4MQn9NyEV8S8fVNT8z39591Tz7/zdv3dWmQDx1q0Fj0hsUQYvX/////////////////////////////////////////////////////6ksDNqf+AJ8jRRazkq3ExlGi1jJ0u//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////83sBvlttkQA5+FrrYjHNlsqfrEyJbPdvdr5O12YtkqBPrlgX7ucta33UV1typIxiyWVSVUzhwipap0YqkueZHuEymRXXZTCKgIOXlbkCOMm9gV8ttsiAHPzwjkTMQnegCBqxj9TTFjOf5PSGAkhSoYRu0z7w9KZz///kWHmiPTcqZa3YtMDux0roell35bQhSOoCkQLKlkwEWX////////////////////////////////////////////////////////+pLAo73/gCd8o0WpaQlxPJeotZyVbv///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////u6QGaSyRtADXi203AYzhVWZJQmJvO9szHMp+cjLLSxMJ2xxklvGz//Xzd3MzXpP5pSaJiGNPsiY1JblBqkL3/sne+2f9S+1OZdYDdLJI2gBz8tUzslYifTiuLNCuEqq+5NrjtSV4kpxmQHGv9Edctf3uHx7+J7TKZ2neeUBZP9n8Xi0/O4O79zLL5yqV5AdsOOJb7z///////////////////////////////////////////////////////qSwDAX/4AoXKVFrGRrcSAJJ/T85N////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////l1oV0tkjaAHNa1HWZAEi6VhgSaZBMavaPGSUtNSZ0y+R1YSrncd7y52HgFYmmreYv/uZ+ZttjZpKtKrjbu9JqbJUw74TnnRO0+atbd66hzSAzSSSNkAc/vxpO0RNXc2hc+PGSMItQJ2Q5fKp9ow8ATGDwUP33n5ZJDMLWkxatUPDc9JN0OzCBgXq+nwbk9pWEqpoFHzt5vZvfz///////////////////////////////////////////////////////6ksDUnv+AJ5DTP6zka3k5FGf1jKEv/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////ErYNsn/QB/7ym18EIz7tUCw8YG50ILV5EdvH7l0xGn6IHzhCsR63rmu9w3SX9rszpY1aKrXIcEVdLuqmuhqvZBouORa4SPVtbpoEtgVskbaRAH/n2kZWQSl+Je9UFmg2EJupTvVDdJOX8aYYBD0Hlv3Nup54ZExyozum1dHXY1xyhnS1Ufe63vKk+imrfgQtRExoq9U+a1//D//////////////////////////////////////////////////+pLAidX/gCgYeTusaQk5KRSmsZyVbv///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////EtgVtn/QB/4/TO7VDBl0iAOAhnAtlDtZlsq7AdLUoRgQxrZ7uGvx3/cZJ3g9i8xWqjdtkCY2cr6puykQlVSNWW7eKfAWb/GFwaHcQZ5fa6VAD/3qUtUIRMhaUFyvyf6lAtHeo6Ltf8a7+nuw0Km/mWWt5ZzEj2zUdxcm/VVjjOFTGup9pLVumUaH1LA+wCvMjp7b3P/+/////////////////////////////////////////////////////qSwDJH/4AoWHc3rOVJOSEU5rGclW////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////4K8wCO8NbbIgB//uzGwYVGh+maPuYmIGPZpNxybqTHeWGygLGJ+u9DEQG6XcxL2ecYZS7id8pHGUPP2fQRGcE7+3Iv/2K2/WsAeIAVZ2stkIA//oiRITKExAkWIAkKRS21hljY5zdwvFW3jzWFTWP7jGbXbuUhZ1VGqpQux6XWp3dHM72YxA6ciqPcDwLC0j3unUf////////////////////////////////////////////////////////6ksCuCf+AKFynL+xkq2kfjyW9jJ0l///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////4k2Ms0kcaAA7LAUD8OAFkhgzAoqcubwx3//67bO9iLQxAKspTXU8vtdiLER8OiyWG3JC4nMh15L1elCNBASbhKHgecIBCaZnQUGlSTQRzWblz02cCFP96MBPeTSxAwypZcGnoVo+i/6LS3hv/////////////////////////////////////////////////////////////////////////////////////////////+pLAp7b/gCnUsSvn4Ktg8A9k9HyVJP//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////AABIAG2oqGRnfi6R93otulotssP1OR60pgAAQQB8AVDot9zLk9j+Y716UhWg8mv///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////qSwIzw/4AuQEsZYWBGwGMAItAAAAD///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////85AYQFNRtLf//WlPiMK2itSk7ciI70MJJ3eiquEy3R/T5ty0N7lf/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////6ksAVmf+ALsABFoAAAABTAGMUAAAA/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////5LNX+j6VbO9Rn+x2y8sAAIAAHm2bE6VDtSf2P/bbY1os5Okm5f/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+pLACxD/gC+cARYAAAAAOAAiwAAAAP////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////Sm9X0PbXd1GCH/tiiVpAhBU+Cg+rzj9mrQH7X2topZVtaj//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////qSwMAH/4AvbAEWgAAAAD2AYsAAAAD////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////AAAIAHbLPWs5bn1cObXXoa1fse5IAAAgAQORbmD9XR/9LjaL3X7nWV9df///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////6ksDREP+ALsgDGwAAAABSgGLQAAAA///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////dSv/3dy/9KPc1tLOa30Us1+/+9f5m5FL99mLp////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////+pLADl//gC+0ARaAAAAANYAiwAAAAP////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8AAAEA/3fX+9WwBLH/////cv////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////qSwJOu/4AvQAEWAAAAACOAY1AAAAT///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP/6ksBYY/+AMWABLgAAACAAACXAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=");  
	    snd.play();
	     
	}
	function beep11() {
		 // Beep Sound For Member having Pending Fees
		var snd = new Audio("data:audio/wav;base64,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");
		 snd.play();
		  
	}
	//Function to Fetch Members Details On Change of Member Id
	var onMemberIdChange1 = function(){
		
				
		var fDate =  convertToUserDate(today);
		//alert('fDate ' +fDate);
		$("#attendanceDate").text(fDate);
		
		//alert('inside onMemberIdChange1 ');
		$("#errorContainer").empty();
		$('<div class="errors" id="message" style="width: 530px;" style="display:none;"></div>').appendTo($("#errorContainer"));	
		NotificationClearForm();	
		var memberId=$("#displayNotificationMemberId").val();//.substring(1);
		//var checkMemberString=$("#displayNotificationMemberId").val().substring(0,1);		
		if($("#displayNotificationMemberId").val().substring(0,1)=='M'){
			memberId=$("#displayNotificationMemberId").val().substring(1);
			$("#displayNotificationMemberId").val(memberId);
		}
		
		
		if(memberId > 0 )//&& checkMemberString == 'M')
		{
			//alert('memberId > 0');
			$("#scanMessage").hide();
			$("#memberId").val(parseInt(memberId));		
			$.getJSON('fetchMemberAttendance',{memberId : memberId}).done(function(data){		//Json To Fetch Data	
		      	console.log(data);
				if(data.memberStatusList[0] != undefined){						
					//alert('inside memberStatusList');
						if(data.memberStatusList[0].status=="registered" && data.memberDetailsList[0] != undefined){
							
							assignNotificationData(data.memberDetailsList[0],data.attendanceDetailsList[0],data.pendingFeesDetailsList[0],data.fetchLedgerPackageDetails);
							//assignNotificationDataToTable(data.pendingFeesDetailsList[0]);						
							/* if(today > data.memberDetailsList[0].endDate) */
							var packageEndData=data.fetchLedgerPackageDetails[0];
							var yellowpackageEndData=null;
							var redpackageEndData=null;
							var key = 	packageEndData.ledgerType+""+packageEndData.ledgerName;
							let pkgData = new Map();
							pkgData.set(key,packageEndData);
							var flag=true;
							for(let i=1;i<data.fetchLedgerPackageDetails.length;i++)
							{
								key = 	data.fetchLedgerPackageDetails[i].ledgerType+""+data.fetchLedgerPackageDetails[i].ledgerName;
								var obj = pkgData.get(key);
								if(!obj){
									//condition for checking the package end date is lesser than 45 days if yes it will not considered 
									if( ( (  new Date(data.fetchLedgerPackageDetails[i].endDate).getTime() - new Date(today).getTime())/(oneday)) > -10){
										pkgData.set(key,data.fetchLedgerPackageDetails[i]);
									}
								}else if(obj.ledgerType == data.fetchLedgerPackageDetails[i].ledgerType &&
										obj.ledgerName == data.fetchLedgerPackageDetails[i].ledgerName &&
										obj.ledgerFeesId < data.fetchLedgerPackageDetails[i].ledgerFeesId){
									//obj = data.fetchLedgerPackageDetails[i];
									pkgData.set(key,data.fetchLedgerPackageDetails[i]);
								}
								
								 /* if(packageEndData.endDate>data.fetchLedgerPackageDetails[i].endDate)
									{
										packageEndData=data.fetchLedgerPackageDetails[i];
									}  */
							}
							//console.log( pkgData);
							 
							setTimeout(function(){    
								
							pkgData.forEach(function(pkg,keys){ 
								//console.log(pkg+" :: "+keys);
								if(( (  new Date(pkg.endDate).getTime() - new Date(today).getTime())/(oneday)) < 0 && pkg.activeStatus==1)
								{
									redpackageEndData=pkg;
									
									return;
								}else if(( (  new Date(pkg.endDate).getTime() - new Date(today).getTime())/(oneday)) <= 5)
								{
									yellowpackageEndData=pkg;
								
								}
							});
							
							 
							if(redpackageEndData){ 
								var ledName=redpackageEndData.ledgerName.toUpperCase();
								 if(ledName.includes('PT') )  
									if(parseInt(redpackageEndData.ptNameList) > 0)
										packageEndData=redpackageEndData;
									 
									else 
										flag= false;
								 		
								 else if(!ledName.includes('PT'))  
									 packageEndData=redpackageEndData;
							}
							else if(yellowpackageEndData){
								packageEndData=yellowpackageEndData;
								
							}
							//console.log(packageEndData);
							//console.log(new Date(data.fetchLedgerPackageDetails[i].endDate.getTime()) );
							 	if(( (  new Date(packageEndData.endDate).getTime() - new Date(today).getTime())/(oneday)) < 0 && flag && packageEndData.activeStatus==1)
							 	{
							 		//data.pendingFeesDetailsList[0]
							 		/* alert('inside red block.... ');
							 		alert('oneday '+oneday);
							 		alert('end date: '+data.memberDetailsList[0].endDate); */
							 		
							 		var t1 = new Date(data.memberDetailsList[0].endDate).getTime();
							 		var t2 = new Date(today).getTime();
							 		var t3 =  new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime();
							 		var t4 =  (  new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime())/(oneday);
							 		/* alert('t1 : '+t1);
							 		alert('t2 : '+t2);
							 		alert('t3 : '+t3);
							 		alert('t4 : '+t4); */
							 		/* alert(( ( new Date(packageEndData.endDate).getTime() - new Date(today).getTime())/(oneday)) );
							 		alert(packageEndData.endDate +" "+packageEndData.ledgerName); */  
									$("#tr").css("background","linear-gradient(rgb(250, 200, 200), rgb(250, 100, 100))");  //red
									if(( (  new Date(packageEndData.endDate).getTime() - new Date(today).getTime())/(oneday)) > -5){
										beep11();	// beep sound for 5 days from end date of package 	
										 
										
									}
									flag=!flag;
								}
							
							 
								 else
								 {
								 	if((( (  new Date(packageEndData.endDate).getTime() - new Date(today).getTime())/(oneday)) > 5) || !flag || packageEndData.activeStatus==0)
									/* if(today < data.memberDetailsList[0].endDate) */	{
										$("#tr").css("background", "linear-gradient(rgb(170, 250, 170), rgb(50, 250, 50))"); //green
										flag=!flag;
								 	}
							 		else 
									{ 
										$("#tr").css("background","linear-gradient(rgb(250, 250, 200), rgb(250, 250, 50)");  //yellow
									 }
								
								 }			
							  }, 500); 
							/* else if(( (new Date(data.memberDetailsList[0].endDate).getTime() - new Date(today).getTime())/(oneday)) <= 5 && ( (new Date(list[0].endDate).getTime() - new Date(today).getTime())/(oneday)) >= 0)
										 $("#tr").css("background","linear-gradient(rgb(250, 250, 200), rgb(250, 250, 50)");  //yellow */
						}else{									
							
							   // assignNotificationData(data.memberDetailsList[0],data.attendanceDetailsList[0],data.pendingFeesDetailsList[0]);
							   
								assignNotificationStatusData(data.memberStatusList[0]);
								$("#message").text("Member has not paid fees.").show();
								$("#displayNotificationMemberId").focus();
							 }	
						
				
				}else{
						$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
					 }
			})
			.fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Fetching. Please Try Again...").show();
			});
		}
		else{
			$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. 1,2)").show();
		}
		
		
		//document.getElementById('displayNotificationMemberId').value='';
		var memberIdDisp = $("#displayNotificationMemberId").val();
		memberIdDisp ="M"+memberIdDisp;
		//alert(memberIdDisp);
		 $("#memberIdForDisplay").text(memberIdDisp);
		 
		$("#displayNotificationMemberId").val("");
		$("#displayNotificationMemberId").focus();
		
				
	};
	
	
	
	
</script>

<script type="text/javascript">

var assignNotificationStatusData = function(memberData){
	
	 var ctx ='<%=request.getContextPath()%>';	
	 $('<img src="'+ctx+'/MemberImages/'+memberData.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" alt="Image Not Added" />').appendTo($("#image"));
		
		$("#membersNameAutocompleteNotification").val(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName); 
		$("#memberName").text(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
		$("#contactNoNotification").val(memberData.contactNo);
};

		var assignNotificationData = function(memberData,attendanceData,pendingFeesDetailsData,fetchLedgerPackageDetailsData){
			$('#memberInfo').empty();
			 var ctx ='<%=request.getContextPath()%>';	
			$("#attendanceDetails").show();
			$("#fieldset2").show();	
			//console.log(fetchLedgerPackageDetailsData);
			  var sizeOfList = fetchLedgerPackageDetailsData.length;
			  sizeOfList > 5 ? sizeOfList=5:sizeOfList;
			 $('<img src="'+ctx+'/MemberImages/'+memberData.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" alt="Image Not Added" />').appendTo($("#image"));
			 for(let i=0;i<sizeOfList;i++)
			{
				 $('<tr><td><label>ledgerName</label></td><td style=" padding-left: 16px;"><label>'+fetchLedgerPackageDetailsData[i].ledgerName+'</label></td><td style=" padding-left: 16px;"><label>ledgerTotalFees</label></td><td><label>'+fetchLedgerPackageDetailsData[i].ledgerTotalFees+'</label></td>').appendTo($('#memberInfo'));
				 $('<tr><td><label>'+fetchLedgerPackageDetailsData[i].ledgerName+' Start Date</label></td><td style=" padding-left: 16px;"><label>'+fetchLedgerPackageDetailsData[i].startDate+'</label></td><td style=" padding-left: 16px;"><label>End Date</label></td><td><label>'+fetchLedgerPackageDetailsData[i].endDate+'</label></td>').appendTo($('#memberInfo'));
			}
			 
			 			 
			 
			 
			$("#membersNameAutocompleteNotification").val(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName); 
			$("#memberName").text(memberData.firstName+" "+memberData.middleName+" "+memberData.lastName);
			$("#contactNoNotification").val(memberData.contactNo);

			//$("#feesName").text(pendingFeesDetailsData.ledgerName);
			$("#joiningDate").text(convertToUserDate(memberData.joiningDate));
			$("#startDate").text(convertToUserDate(memberData.startDate));
			$("#endDate").text(convertToUserDate(pendingFeesDetailsData.endDate));
			$("#dueDate").text(convertToUserDate(pendingFeesDetailsData.dueDate));
			$("#totalFees").text(pendingFeesDetailsData.ledgerTotalFees);
			$("#paidFees").text(pendingFeesDetailsData.ledgerPaidFees);
			$("#pendingFees").text(pendingFeesDetailsData.ledgerPendingFees);
			
			//$("#startDate").text(convertToUserDate(pendingFeesDetailsData.startDate));
			//$("#endDate").text(convertToUserDate(pendingFeesDetailsData.endDate));
		
			

		    if(memberData.status=="registered"){  
			         $("#attendanceDetails").show();
			if(attendanceData != undefined)
			{
							
				if(attendanceData.inTime != null){
					$("#inTime").show();
					$("#in").hide();
					var time24HR = attendanceData.inTime;
					var time12HR = getTimeIn12Hour(time24HR);
					
					$("#inTime").val(time12HR);
					
				}
				if(attendanceData.outTime != null){
					$("#outTime").show(); 
					$("#out").hide();
					
					var time24HR = attendanceData.outTime;
					var time12HR = getTimeIn12Hour(time24HR);
					$("#outTime").val(time12HR);
				}
				$("#attendanceId").val(attendanceData.attendanceId);
			}				
		    }else{
		    	$("#message").text("Member Id is not currently Registered. He is removed. ").show();
		    }
		    
		    $("#displayNotificationMemberId").focus();
		};	


//Personal Trainer Ready Function
$(document).on('ready readyAgain1', function(){	
	
	$("#errorContainer").empty();
	$("#scanMessage").hide();
	
	
	//action="saveEsslSettingAction"
	$("#saveEsslSetting").click(function(){					
		$('<div class="errors" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));				
		var esslIP=$("#esslIP").val();
		$("#saveEsslSetting").prop("disabled",true);
		var serverName=$("#serverName").val();
		var portNo=$("#portNo").val();
		var databaseName=$("#databaseName").val();			
		   $.ajax({url: "saveEsslSettingAction",  data:{serverName : serverName , portNo : portNo,databaseName:databaseName,esslIP:esslIP},type: 'GET',/* async: false, */
			   success: function(result,status,xhr){			 
				   //alert("success="+status);
	            },beforeSend:function(xhr){
	            	//$("#wait").css("display", "block");
	            },complete:function(xhr,status){
	            	//$("#wait").css("display", "none");
	            	if(status=="success"){
	            		$("#errorContainer").empty();		            	
	            		$('<div class="welcome" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));
	            		$("#message").text("Detail Saved").show();
	            	}		            		
	            	else{
	            		$("#message").text("Error While Saving. Please Try Again...").show();
	            	}		            		
	            	$("#saveEsslSetting").prop("disabled",false);
	            }
		   
		   }).fail(function(jqxhr, textStatus, error) {
				$("#message").text("Error While Saving. Please Try Again...").show();
			});
		   
		    
		
		/* $.getJSON('saveEsslSettingAction',{serverName : serverName , portNo : portNo,databaseName:databaseName,esslIP:esslIP}).done(function(data){
			alert("Details Saved..");
			//$(selector).getJSON(url,data,success(data,status,xhr))
			
		})
		.fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Saving. Please Try Again...").show();
		});			
		 	$(document).ajaxStart(function(){
		        $("#wait").css("display", "block");
		    });
		    $(document).ajaxComplete(function(){
		        $("#wait").css("display", "none");
		    }); 			    
		 */
		
	});
	//Autocompleter For Personal Trainer By Contact No
	autoCompletePTNumber("contactNoNotification","displayNotificationPersonalTrainerId",onPersonalTrainerIdChange); 	
	
	/* Edited By Raju Sable */
	//Auto Complete for Search By Member Name
//autoComplete("membersNameAutocomplete1","displayMemberId1",onMemberIdChange);
$("#membersNameAutocomplete1").keyup(function(){			
	homepageAutoComplete("membersNameAutocomplete1","displayMemberId1",onMemberIdChange);
});

// fetch member details
 $("#displayMemberId1").change(function(){
	onMemberIdChange();						//Fetch Members Details On Change of Member Id
}); 

//Auto Complete for Search By number
	$("#contactNo1").keyup(function(){			
		autoCompleteSearchMemberByContact("contactNo1","displayMemberId1",onMemberIdChange);
	});

//On Member Id Change Event get member details, Fees details
$("#displayMemberId1").blur(function(){
		onMemberIdChange();							//Fetch Members Details On Change of Member Id
	});

var onMemberIdChange = function(){
	

	$('<div class="errors" id="message" style="width: 530px;display:none;"></div>').appendTo($("#errorContainer"));
	var fetchMemberId = $("#displayMemberId1").val().substring(1);
	var checkMemberString=$("#displayMemberId1").val().substring(0,1);
	clearForm();
	if(fetchMemberId > 0 && checkMemberString == 'M')
	{
		$("#memberId").val(parseInt(fetchMemberId));
		$.getJSON('fetchMemberDetails',{fetchMemberId : fetchMemberId}).done(function(data){
			 
			if(data.memberList[0] == undefined)
				$("#message").text("Member Id is not Registered. Please Enter Valid Member Id...").show();
			else
				assignData(data.memberList[0]);
		})
		.fail(function(jqxhr, textStatus, error) {
			$("#message").text("Error While Fetching. Please Try Again...").show();
		});
	}
	else
		$("#message").text("Member Id is not valid. Please Enter Valid Member Id...(ex. M1,M2)").show();
};	

//Clear Form
var clearForm = function() {
	$("#imageMember").remove();
	//$("#message").show();
	$("#update").attr("disabled", true);
	$("#joiningDate").val("");
	$("#lastName").val("");
	$("#firstName").val("");
	$("#middleName").val("");
	$("#gender").val("");
	$("#dateOfBirth").val("");
	$("#address").val("");
	$("#contactNo").val("");
	$("#alternateContactNo").val("");
	$("#emailId").val("");
	$("#height").val("");
	$("#weight").val("");
	$("#chest").val("");
	$("#bicep").val("");
	$("#tricep").val("");
	$("#imageMember").remove();
	$("#memberId").val(0);
	$("#age");
	$("#maritalStatus").val("");
	$("#membersNameAutocomplete").val("");
	$("#anniversaryDate").val("");
};

//Assign Data
var assignData = function(data){
	
	$("#MemberDetailsForm").show();

	$("#message").hide();
	$("#update").attr("disabled",false);
	$("#joiningDate").val(convertToUserDate(data.joiningDate)); 
	$("#lastName").val(data.lastName);
	$("#firstName").val(data.firstName);
	$("#middleName").val(data.middleName);
	$("#gender").val(data.gender);
	$("#dateOfBirth").val(convertToUserDate(data.dateOfBirth));
	$("#address").val(data.address);
	$("#age").val(data.age);
	$("#contactNo").val(data.contactNo);
	$("#dispMemberId").val(data.memberId);
	$("#displayMemberId").val("M"+data.memberId);
	$("#displayMemberId1").val("M"+data.memberId);
	$("#contactNo1").val(data.contactNo);
	$("#memberId").val(data.memberId);
	$("#alternateContactNo").val(data.alternateContactNo);
	$("#emailId").val(data.emailId);
	$("#height").val(data.height);
	$("#weight").val(data.weight);
	$("#chest").val(data.chest);
	$("#bicep").val(data.bicep);	
	$("#maritalStatus").val(data.maritalStatus);
	$('#anniversaryDate').val("");			
	if(data.maritalStatus=="Married"){	
		 $('.annDate').show();
		$("#anniversaryDate").val(convertToUserDate(data.anniversaryDate));		
		$('#anniversaryDate').attr("disabled",false);
	} 	else{
		$("#maritalStatus").val("Unmarried");
		$('#anniversaryDate').attr("disabled",true);
		 $('.annDate').hide();
	}	
	$("#personalTrainerId").val(data.ptNameList);
	$("#tricep").val(data.tricep);
	$("#membersNameAutocomplete").val(data.firstName+" "+data.middleName+" "+data.lastName);
	$("#image").append('<img src="<%=request.getContextPath()%>/MemberImages/'+data.memberId+'.jpg"  width="80px" hieght="90px" id="imageMember" title="Change Image" alt="Image Not Added" />');
};


/* Edited by raju to here */
	//Autocompleter Foe Personal Trainer By Names
	$("#personalTrainerNameAutocompleteNotification").keyup(function(){			
		autoCompletePT("personalTrainerNameAutocompleteNotification","displayNotificationPersonalTrainerId",onPersonalTrainerIdChange);
	});
	
	$("#displayNotificationPersonalTrainerId").change(function(){
		
		onPersonalTrainerIdChange();
	});	
	
	//Save Personal Trainer In Time
	/* $("#in").click(function(){
		var now = new Date($.now());
		
		//var inTime = now.getHours()+":"+now.getMinutes();
		var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
		+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());			
		var time12HR = getTimeIn12Hour(time24HR);
		$("#inTime").val(time12HR);
		$("#inTime").show();
		$("#in").hide();
		var personalTrainerId = $("#personalTrainerId").val();
		$.getJSON('savePTInTime', {inTime : time24HR, personalTrainerId : personalTrainerId}).done(function(data){
			$("#attendanceId").val(data.attendanceId);
			$("#txtmessage").text("").hide();
		});
		
	}); */
	
	//Save Personal Trainer Out Time
	$("#out").click(function(){
		
	
		if($("#inTime").val() != "00:00"){
			
		
			$("#txtmessage").text("").hide();
			var now = new Date($.now());
			//var outTime = now.getHours()+":"+now.getMinutes();
			var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
			+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());				
			var time12HR = getTimeIn12Hour(time24HR);
			$("#outTime").val(time12HR);
			$("#outTime").show();
			$("#out").hide();
			var attendanceId = $("#attendanceId").val();
			$.getJSON('savePTOutTime',{outTime : time24HR , attendanceId : attendanceId}).done(function(data){});
		}
		else{
			$("#message").text("Please click on In Time First...").show();
		}
	});
	
	$("#displayNotificationPersonalTrainerId").focus();
	$("#displayNotificationMemberId").focus();
	
});//End of Document Ready

setInterval(function(){ $("#displayNotificationMemberId").focus(); }, 3000);

$(document).on('ready readyAgain', function() {			
	
	
	//====================== For BirthDay ==================================    
		$("#scanMessage").hide();
	
	    $('#hiddenFromDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'				
	      ,onSelect: function(dateText, inst) {
	          $('#fromBD').text(dateText);$('#toBD').text(dateText);
	      },onClose : function(date){
				$("#hiddenToDate").datepicker( "option", "minDate", date );	
				 loadBDList(true);
			}});
	  	
	  	
	  	$('#hiddenToDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate:  0
	      ,onSelect: function(dateText, inst) {
	          $('#toBD').text(dateText);
	      },onClose : function(date){
				///;	
	    	  loadBDList(true);
			}});
	  	
	  	$("#hiddenToDate").prop( "option", $('#hiddenFromDate').val() );	
	  	$('#fromBD').click(function(){
	        $('#hiddenFromDate').datepicker('show');		        
	     });
	  	
	  	$('#toBD').click(function(){
	        $('#hiddenToDate').datepicker('show');		        
	      });	
	  //====================== For BirthDay ==================================    
	//====================== For Anniversary ==================================    
	    $('#hiddenFromAnDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'				
	      ,onSelect: function(dateText, inst) {
	          $('#fromAnD').text(dateText);$('#toAnD').text(dateText);
	      },onClose : function(date){
				$("#hiddenToAnDate").datepicker( "option", "minDate", date );	
				 loadAnList(true);
			}});
	  	
	  	
	  	$('#hiddenToAnDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate:  0
	      ,onSelect: function(dateText, inst) {
	          $('#toAnD').text(dateText);
	      },onClose : function(date){
				///;	
	    	  loadAnList(true);
			}});
	  	
	  	$("#hiddenToAnDate").prop( "option", $('#hiddenFromAnDate').val() );	
	  	$('#fromAnD').click(function(){
	        $('#hiddenFromAnDate').datepicker('show');		        
	     });
	  	
	  	$('#toAnD').click(function(){
	        $('#hiddenToAnDate').datepicker('show');		        
	      });	
	  //====================== For Anniversary ================================== 	  
		//====================== For Renew Package By date ==================================    
	    $('#hiddenFromReNewDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy'				
	      ,onSelect: function(dateText, inst) {
	          $('#fromReNewD').text(dateText);$('#toReNewD').text(dateText);
	      },onClose : function(date){
				$("#hiddenToReNewDate").datepicker( "option", "minDate", date );	
				loadReNewPackageList(true);
			}});
	  	
	  	
	  	$('#hiddenToReNewDate').datepicker({
	    	changeMonth: true,
			changeYear: true,
			dateFormat: 'dd/mm/yy',
			minDate:  0
	      ,onSelect: function(dateText, inst) {
	          $('#toReNewD').text(dateText);
	      },onClose : function(date){
				///;	
	    	  loadReNewPackageList(true);
			}});
	  	
	  	$("#hiddenToReNewDate").prop( "option", $('#hiddenFromReNewDate').val() );	
	  	$('#fromReNewD').click(function(){
	        $('#hiddenFromReNewDate').datepicker('show');		        
	     });
	  	
	  	$('#toReNewD').click(function(){
	        $('#hiddenToReNewDate').datepicker('show');		        
	      });	
	  	
	  //======================  For Renew Package ==================================    
		  
		  
	//Auto Complete for Search By Member Name		
	//autoComplete("membersNameAutocompleteNotification","displayNotificationMemberId",onMemberIdChange1);		
	 //Auto Complete for Search By number
/* 		autoCompleteSearchMember("contactNoNotification","displayNotificationMemberId",onMemberIdChange1);	
*/		 
	$("#membersNameAutocompleteNotification").keyup(function(){			
		alert('inside membersNameAutocompleteNotification......');
		//autoCompleteBothMembers("membersNameAutocompleteNotification","displayNotificationMemberId",onMemberIdChange1);
	    // homepageAutoComplete("membersNameAutocompleteNotification","displayNotificationMemberId",onMemberIdChange1);
	});
	
	// fetch member details
/* 	$("#displayNotificationMemberId").change(function(){
		alert('inside displayNotificationMemberId');
		onMemberIdChange1();						//Fetch Members Details On Change of Member Id
	}); */
	
	//Save In time
	/* $("#in").click(function(){
		var now = new Date($.now());
		
		var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
		+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());
		
		//if(now.getHours()>10) 
		var time12HR = getTimeIn12Hour(time24HR);
		
		$("#inTime").val(time12HR);
		$("#inTime").show();
		$("#in").hide();
		var memberId = $("#memberId").val();
		$.getJSON('saveInTime',{inTime : time24HR , memberId : memberId}).done(function(data){
			$("#attendanceId").val(data.attendanceId);
			$("#txtmessage").text("").hide();
		});
	}); */
	
	//Save Out Time
	$("#out").click(function(){
		
	
		if($("#inTime").val()!="00:00"){
			$("#txtmessage").text("").hide();
			var now = new Date($.now());
		
			//var outTime = now.getHours()+":"+now.getMinutes();
			var time24HR = ((now.getHours() >= 10) ? now.getHours() : "0"+now.getHours())
			+":"+((now.getMinutes() >= 10) ? now.getMinutes() : "0"+now.getMinutes());
			
			var time12HR = getTimeIn12Hour(time24HR);				
			$("#outTime").val(time12HR);
			$("#outTime").show();
			$("#out").hide();
			var attendanceId = $("#attendanceId").val();
			$.getJSON('saveOutTime',{outTime : time24HR , attendanceId : attendanceId}).done(function(data){});
		}
		else{
			$("#message").text("Please click on In Time First...").show();
		}
	});
	
	//fingerprint Detail/////
	//setInterval(function() {
	//	alert('hi');
  // method to be executed;

	$("#testFing").click(function(){
		$("#scanMessage").hide();
			var memberId = $("#memberId").val();
			//alert('memberId: '+memberId);
			var cId=null;				
		/* 	$.getJSON('matchFingerPrint',{memberId : memberId}).done(function(data){
				
				//alert('member verified...');
				$("#currentId").val(memberId);
				$("#scanMessage").text("Member Verified").show();
				//alert('currentId from folder:'+data[0].currentId);
			}); */
						
			//$("#scanMessage").text("Member Verified").show();
			
			/*	$.each(data.records, function(i, f) {
    		    var id =  f.currentId ;
    		    alert(id);
           		});*/ 
				
			//alert("2: " +memberId);
	});////// end of finger print Detail
	
	//}, 5000);
	
	$("#displayNotificationMemberId").focus();
	
	
}); //End Of Document ready   


</script type="text/javascript">

<script>


var bindCallbackMethods=function(){
	 $(document).bind("ajaxSend", function(){
		 $("#mainContainer").attr("onclick","return false;");
			$("#wait").css("display", "block");
		}).bind("ajaxComplete", function(){
			$("#wait").css("display", "none");$("#mainContainer").prop("onclick",null);
		}); 
};

var unbindCallbackMethods=function(){
	 $(document).unbind('ajaxComplete').unbind('ajaxSend');  //for chrome
};
bindCallbackMethods();
 	
 	/* $(document).bind("ajaxSend", function(){
	 $("#mainContainer").attr("onclick","return false;");
		$("#wait").css("display", "block");
	}).bind("ajaxComplete", function(){
		$("#wait").css("display", "none");$("#mainContainer").prop("onclick",null);
	}); */

/*  $(document).ajaxStart(function()   { 	
	 $("#mainContainer").attr("onclick","return false;");
	$("#wait").css("display", "block");
	//$("#mainContainer").attr("onclick","return false;");
	
	}); */ 
//$(document).ajaxComplete(function(){ $("#wait").css("display", "none");  });
</script>
<script type="text/javascript">

$("#displayNotificationMemberId").keydown(function(event){
	if(event.which==13){
		//alert('inside keypress');
		event.preventDefault();
		
		$("#in").click();
		//abc();
		 
		$("#displayNotificationMemberId").focus();
	}
	
	
});







var today = new Date();

var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!

var yyyy = today.getFullYear();
if(dd<10){
		 dd='0'+dd
} 
if(mm<10){
		 mm='0'+mm
} 
today = yyyy+"-"+mm+"-"+dd;

var oneday=1000*60*60*24;
var left=false;
var notificationStatus="hide";
	$("#document").ready(function(){		
		 
		setNotificationLists(notificationStatus); 
		$("#toggle").click(function() {			  
			//notificationStatus=(notificationStatus=="hide")?"show":"hide"; 
			setNotificationLists(notificationStatus); 
		});
		<%--//speak('Hello World! I am very happy. Thank you.',{ pitch: 100,wordgap:15 }); //TTS Method
		//speak('hello Tinaa!', { pitch: 100,wordgap:15 }); //TTS Method --%>
	
    		var setStatusColor=function(status){
    			if(status.substring(0,6)=="online")
    				$("#essl1").css("color","rgb(0, 160, 0)");
    			else
    				$("#essl1").css("color","rgb(255, 0, 0)");
    		};
    		 /*  $.getJSON('fetchAllNotificationList',{})			//Json To Fetch Data
 			.done(function(data)
 			{
 			}); */
 			$("#membersNameAutocomplete").keyup(function(){			
 				autoComplete("membersNameAutocomplete","displayMemberId",onMemberIdChange);
 			});
 			$.ajax({url:'fetchAllNotificationList',		//Json To Fetch Data
	    		success:function(data)
			{						
	    			var notificationLists=$("#notificationLists");
					notificationLists.empty();
					var timeAttendence='<%=application.getAttribute("timeAttendence")%>';	
					if(timeAttendence=="true"){
						var status='<%=application.getAttribute("esslDBStatus")%>';						
						$('<div class="notification_header" id="13" onclick="showNotification(this);">Essl status :<span class="required" id="essl1">'+status+'</span> </div>').appendTo(notificationLists);
						setStatusColor(status);
					}	
					$('<div class="notification_header" id="13"><a href="searchMemberDetailsByValues"> Search Member</a></div>').appendTo(notificationLists);
					$('<div class="notification_header" id="1" onclick="showNotification(this);"><span class="required" id="s1">'+data.pendingFeesList.length+'</span> Pending Fees</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="32" onclick="showNotification(this);"><span class="required" id="s32">'+data.pendingFeesRegularFollowUpList.length+'</span> Pending Follow Up</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="11" onclick="showNotification(this);"><span class="required" id="s11">'+data.cancelPendingFeesList.length+'</span> Pending Fees By <br/>Cancel Mem </div>').appendTo(notificationLists);
					$('<div class="notification_header" id="2" onclick="showNotification(this);"><span class="required" id="s2">'+data.reNewList.length+'</span> By Package EndDate</div>').appendTo(notificationLists); /* Re-Join */
					$('<div class="notification_header" id="3" onclick="showNotification(this);"><span class="required" id="s3">'+data.birthDayList.length+'</span> Today\'s BirthDay </div>').appendTo(notificationLists);
					$('<div class="notification_header" id="4" onclick="showNotification(this);"><span class="required" id="s4">'+data.anniversaryDayList.length+'</span> Today\'s Anniversary </div>').appendTo(notificationLists);
					$('<div class="notification_header" id="5" onclick="showNotification(this);"><span class="required" id="s5">'+data.attendanceList.length+'</span> Absent Mem List</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="6" onclick="showNotification(this);"><span class="required" id="s6">'+data.appointmentList.length+'</span> Today\'s Appointment</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="31" onclick="showNotification(this);"><span class="required" id="s31">'+data.regularFollowUpList.length+'</span> Regular Follow Up</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="7" onclick="showNotification(this);"><span class="required" id="s7">'+data.enquirytList.length+'</span> Enquiry Follow Up</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="8" onclick="showNotification(this);"><span class="required" id="s8">'+data.inactiveMemberList.length+'</span> Inactive Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="9" onclick="showNotification(this);"><span class="required" id="s9">'+data.activeMemberList.length+'</span> Active Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="20" onclick="showNotification(this);"><span class="required" id="s20">'+data.cancelMemberList.length+'</span> Canceled Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="30" onclick="showNotification(this);"><span class="required" id="s30">'+data.enquiredMemberList.length+'</span> Enquired Members</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="10" onclick="showNotification(this);">Member Daily <br /> Attendance</div>').appendTo(notificationLists);
					$('<div class="notification_header" id="12" onclick="showNotification(this);">Personal Trainer <br/> Daily Attendance</div>').appendTo(notificationLists);

					
					//if(timeAttendence=="true")
					$('<div class="notification_header" id="14" onclick="showNotification(this);">Today Overview</div>').appendTo(notificationLists);
					var isTextSMSModuleGiven='<%=(Boolean)application.getAttribute("isTextSMSModuleGiven")%>';		
					if(isTextSMSModuleGiven=="true"){
						$('<div class="notification_header" id="15" onclick="return false;" style="display:none;">SMS Pack:<span class="required" style="color:rgb(0, 160, 0)"  id="smspack">Active</span> </div>').appendTo(notificationLists);

					}else{	
						$('<div class="notification_header" id="15" onclick="contactToActivate();return false;" style="display:none;">SMS Pack:<span class="required" id="smspack">De-Active</span> </div>').appendTo(notificationLists);

					}
					//=================================	
			
			},
			complete:function(xhr,status){
				//$(document).ajaxComplete(function(){ $("#wait").css("display", "none");$("#mainContainer").prop("onclick",null);});
				var timeAttendence='<%=application.getAttribute("timeAttendence")%>';	
				if(timeAttendence=="true"){
						var auto = setInterval(function ()
						     	{ 				
									/* $.getJSON('refreshEsslStatus',{})			//Json To Refresh Data
									.done(function(data)
									{	$("#essl1").text(data.esslStatus); 
										setStatusColor(data.esslStatus);
									});  */	
									
									$.ajax({url:'refreshEsslStatus',global:false,			//Json To Refresh Data
										success:function(data)
										{	$("#essl1").text(data.esslStatus); 
											setStatusColor(data.esslStatus);
										}}); 
									todayOverView();
									
						     	}, 1000 * 2 ); // refresh every 2 sec
				} else{				
					var auto = setInterval(function (){ todayOverView();}, 1500 ); // refresh every 1.5 sec
				}
				var auto = setInterval(function ()
			    {    	
					    	$.ajax({url:'refreshAllNotificationList',global:false,			//Json To Refresh Data
					    		success:function(data)
							{						
								$("#s1").text(data.pendingFeesList.length);
								$("#s11").text(data.cancelPendingFeesList.length);
								$("#s2").text(data.reNewList.length);
								$("#s3").text(data.birthDayList.length);
								$("#s4").text(data.anniversaryDayList.length);
								$("#s5").text(data.attendanceList.length);
								$("#s6").text(data.appointmentList.length);
								$("#s7").text(data.enquirytList.length);
								$("#s8").text(data.inactiveMemberList.length);
								$("#s9").text(data.activeMemberList.length);
								$("#s20").text(data.cancelMemberList.length);

							}}); 		
			     }, 1000 * 60 * 2); // refresh every 2 minute
				
			}}); 
		
			
		
		//Change Pendinding Fees End Date to user format
		$("[id^='dueDate']").show(function(){
			$(this).text("Due Date: "+convertToUserDate($(this).text()));
		});
		//Change Fees End Date to user format
		$("[id^='endDate']").show(function(){
			$(this).text("End Date: "+convertToUserDate($(this).text()));
		});
		//Change Attendance Date to user format 
		/* $("[id^='attendanceDate']").show(function(){
			$(this).text("Last Attended: "+convertToUserDate($(this).text()));
		}); */
		
		//Change appointmentDate Date to user format 
		$("[id^='appointmentDate']").show(function(){
			$(this).text("Appointment Date: "+convertToUserDate($(this).text()));
		});
		//Change Birthday Date to user format
		$("[id^='birthDay']").show(function(){
			$(this).text("BirthDay: "+convertToUserDate($(this).text()));
		});  
		//Change AnniversaryDay Date to user format
		$("[id^='anniversaryDay']").show(function(){
			$(this).text("AnniversaryDay: "+convertToUserDate($(this).text()));
		});  
		//Change Reply Date to user format
		$("[id^='replyDate']").show(function(){
			$(this).text("Reply Date: "+convertToUserDate($(this).text()));
		});

		//Check unchake on click
		$(".member").click(function(){
			var check = "#check"+$(this).attr('id');
			if($(check).attr('checked')=='checked'){
				 $(check).removeAttr("checked");
				 $(this).attr("class","member");
			 }else{
				 $(check).attr("checked",'checked');
				 $(this).attr("class","checkedMember");
			 }
		});
		
		//Check unchake on click
		$(".renewBefore").click(function(){			
			var check = "#check"+$(this).attr('id');
			if($(check).attr('checked')=='checked'){
				 $(check).removeAttr("checked");
				 $(this).attr("class","renewBefore");
			 }else{
				 $(check).attr("checked",'checked');
				 $(this).attr("class","checkedMember");
			 }
		});
		//Check unchake on click
		$(".renewAfter").click(function(){
			var check = "#check"+$(this).attr('id');
			if($(check).attr('checked')=='checked'){
				 $(check).removeAttr("checked");
				 $(this).attr("class","renewAfter");
			 }else{
				 $(check).attr("checked",'checked');
				 $(this).attr("class","checkedMember");
			 }
		});			
	});
	function contactToActivate(){
			alertMsg("Please! contact to activate SMSPack. Thank You.");
	}
	function setNotificationLists(notificationStatus){			
		  if(notificationStatus=="hide"){				  
		  		$("#toggle").css("background-image","url('<%=request.getContextPath() %>/images/rightToggle.jpg')");		  		
		  }	
		  else{				  
			  $("#toggle").css("background-image","url('<%=request.getContextPath() %>/images/leftToggle.jpg')");
		  }  
		  $("#notificationLists" ).animate({width: notificationStatus},500);
		}
		var fromNotificationClick=false;
		function showNotification(id){
			var divClass = $(id).attr('class');			
			if(divClass == "notification_header"){
				/* var areaId = "#notification_area_"+$(".click_notification_header").attr('id'); */		
				var areaId = "#notification_area_"+$(".notification_header").attr('id');
				$(areaId).hide();
				//$(".click_notification_header").attr('class',"notification_header");
				$(".notification_area").hide();
				//$("#allNotification").hide();				
				$("#notification_area_"+$(id).attr('id')).show('slow');
				//$(this).attr('class','click_notification_header');
				$(".notification_header").css('color','');
				$(id).css('color','blue');
				$("#bodyContainer").hide();
				$(".labelClass").empty();
				$(".areaClass").empty();				
				var id =$(id).attr('id');		
				
				switch(parseInt(id)){
				 case 1:										
					 loadPendingFeesList();
				     break;
				 case 2:
					 loadReNewList();
				        break;
				 case 3:
					 loadBirthDayList();
				        break;
				        
				 case 4:
					 loadAnniversaryDayList();				        
					 break;	 
					 
				 case 5:
					 loadAttendanceList();
				        break;
				 case 6:
					 loadAppointmentList();
				        break;
				 case 7:
					 loadEnquirytList();
				        break;
				 case 8:
					 loadInactiveMemberList();
					 break;
				 case 9:
					 activeMemberList();
					 break;
				 case 10:
					 $("#displayNotificationMemberId").val("");					
					 loadDailyAttendance();
					 NotificationClearForm();
					 //alert("case 10");
					 onMemberIdChange1();
					 break;
				 case 11:										
					 loadCancelPendingFeesList();
				     break;
				 case 12:
					 $("#displayNotificationPersonalTrainerId").val("");
					 loadDailyPTAttendance();
					 PTNotificationClearForm();
					 break; 
				 case 13:								
					 esslSettingForm();					 
					 break;
				 case 14:								
					// todayOverView();
					fromNotificationClick=true;
					 break;
				 case 20:
					 loadCancelMembersList();
					 break;
				 case 30:
					 showEnquiredMembers();
					 break;
				 case 31:
					 showRegularFollowUps();
					 break;
				 case 32:
					 //showEnquiryCanceledMembers();
					 showRegularPendingFollowUps();
					 break;
				default:
				}
				
			}
			 $(".pending").css("color","linear-gradient(rgb(250, 200, 200), rgb(250, 100, 100))");
			 $(".totalFees").css("color","#990099");
		}
		 function closeAction(id){
			$(".notification_header").css('color','');
			$(".notification_area").hide();
			$("#bodyContainer").show();		
		}

</script>
</html>