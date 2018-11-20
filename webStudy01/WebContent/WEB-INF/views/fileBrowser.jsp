<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	File[] fileList = (File[])request.getAttribute("fileList");
	ServletContext sc = getServletContext();
	
	//상위디렉토리 받음  
	System.out.println("jsp : "+request.getAttribute("parentUrl"));
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){
		$(".go").dblclick(function() {
			var value = $(this).attr("value");
			//alert(value);
			$("input[name=filePath]").val(value);
			$("#send").submit();
		})
		$("#file").dblclick(function() {
			alert("파일입니다.");
		})
		
	});
</script>  

<script type="text/javascript">
	function go(value) {
		alert(encodeURI(value));		
		//var bform = document.bform;
		//bform.filePath.value= value;
		//bform.submit();
		
	}
</script>
</head>
<body>

<form id="send" name="bform" action="<%=request.getContextPath() %>/fileBrowser.do">
	<input name="filePath" type="hidden" value="">
</form>
	<input type="file" >
	
	<ul>
		<%
			if(!request.getAttribute("parentUrl").equals("root")){
				%>
				<li class="go" value="<%=request.getAttribute("parentUrl")%>">위로..</li>				
				<%
			}
		%>
		<%
		for(File f : fileList) {			
			if(f.isFile()) {
			%>
				<%-- <li ondblclick="javascript:go('<%=f.getPath()%>');" value="">파일명 : <%=f.getName() %></li> --%>
				<li id="file" value="<%=f.getPath()%>">파일명 : <%=f.getName() %></li>
			<%
			}else {
			%>
				<%-- <li ondblclick="javascript:go('<%=f.getPath()%>');" value="">폴더명 : <%=f.getName() %></li> --%>
				<li class="go" value="<%=f.getPath()%>">폴더명 : <%=f.getName() %></li>
			<%			
			}
		}
		%>	
	</ul>
	
</body>
</html>