<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/pageContextDesc.jsp</title>
</head>
<body>
<h4> PageContext</h4>
<pre>
	하나의 JSP 페이지에 대한 모든 정보를 가진 객체
	: 모든 기본 객체 중 가장 먼저 생성되고,
	나머지 기본객체를 획득할 수 있는 메소드가 제공.
	1) 기본객체 획득
		<%= pageContext.getRequest() == request %>
		<%= pageContext.getServletContext() == application %>
		<%= pageContext.getSession() == session %>
	2) 속성데이터 접근
	3) 에러데이터 획득 : 에러를 처리할 페이지에서 사용하는 기능.
	<%
		ErrorData ed = pageContext.getErrorData();
		out.println(ed.getStatusCode());
	%>
	4) 페이지 이동 : Request dispatch 방식의 이동.
	<%
		//pageContext.include("/05/destination.jsp");
		RequestDispatcher rd = request.getRequestDispatcher("/05/destination.jsp");
		rd.include(request, response);		
	%>
	
			 
</pre>
</body>
</html>