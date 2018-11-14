<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/destination.jsp</title>
</head>
<body>
<h4> 페이지 이동 후 최종 도착지</h4>
<pre>
	페이지 이동 후 브라우저의 주소 확인 하기.
	
	<%= pageContext.getAttribute("pageContextAttr") %>
	<%= request.getAttribute("requestAttr") %>
	<%= session.getAttribute("sessionAttr") %>
	<%= application.getAttribute("applicationAttr") %>
</pre>
</body>
</html>