<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<script>
	$(function() {
		var imgArea = $("#imgArea");
		var pattern = '<img src="imgService?imageSel=%v" />';
		$("[name='imageSel']").on("change", function() {
			var filename = $(this).val();
			imgArea.append(pattern.replace("%v", filename));
		});
	});

</script>
	<form name="imgForm" action="imgService" method="GET">
		<select name="imageSel">
			   	<%= request.getAttribute("optionsAttr") %>
		</select>
	<!-- <input type="submit" value="전송"/>-->
	</form>
	
	<div id="imgArea">
		<%= request.getAttribute("imgTags") %>
	</div>
	
<!-- 	<script type="text/javascript">
		var imgArea = document.getElementById("imgArea");
		function changeHandler(event){
			//document.imgForm.submit();	
			var filename = event.target.value;
			var pattern = '<img src="imgService?imageSel=%v" />';
			imgArea.innerHTML = pattern.replace("%v", filename);
		}
	</script> -->
