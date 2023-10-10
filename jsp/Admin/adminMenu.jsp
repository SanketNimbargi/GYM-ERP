<script type="text/javascript">
	function activeMenu(id){
		//$(this).closest('ul').attr('id')	
		var id = $(id).parent().attr('id');			
		var activeId= $('.active').attr('id');
		$('#'+activeId).attr('class','');
		$('#'+id).attr('class','active'); 
	 }
</script>
<div id="menu" style="margin:0; flaot:left; clear:both; "> 
<ul id="tabmenu">		
			<li id="1"><a href="adminHome">Home</a>
			<li id="2"><a href="createUser">Register New User</a>
			<li id="3">
			<a href="javascript:void(0);" onclick="activeMenu(this);">BackUp and Restore</a>			
			<!-- <a>BackUp and Restore</a> -->
				<ul>
					<li><a href="backup">BackUp</a></li>
					<li><a href="restore">Restore</a></li>
				</ul>
			</li>
			<li><a href="logOut">LogOut</a><ul><li></li></ul></li>
		
		
	</ul>
</div>