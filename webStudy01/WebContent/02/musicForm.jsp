<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	File folder = (File)application.getAttribute("contentFolder");
	String[] names = folder.list((dir, name) -> {		
		return application.getMimeType(name).startsWith("text");});
%>


  <script type="text/javascript">
  	$(function() {
		var songForm = $("#songForm");	
		var resultArea = $("#resultArea");
		$("[name='music']").on("change", function() {
			var song = $(this).val();
			var url = songForm.attr("action");
			var method = songForm.attr("method");
			$.ajax({
				url : url,
				method : method,
				data : {
					song:song
				},
				dataType : "html",
				success : function(resp) {
					resultArea.html(resp);
				},
				error : function(resp) {
					console.log(resp.responseText);
				}
			});
		})
	});
  </script>

<form id="songForm" action="<%=request.getContextPath() %>/song" method="post">
	<select name="music">
		<option value="">가사 선택</option>
		<%
			for(String name : names){
				out.println(String.format(
						"<option>%s</option>", name));
			}
		%>
	</select>

</form>
<div id="resultArea"></div>
