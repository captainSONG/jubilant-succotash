<%@page import="kr.or.ddit.web.modulize.ServiceType"%>
<%@page import="java.util.Objects"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String mem = (String)session.getAttribute("authMember");
	String cmdParam = request.getParameter("command");
	int statusCode = 0;
	String includePage = null;
	if(StringUtils.isNotBlank(cmdParam)){
		try{
			ServiceType sType = ServiceType.valueOf(cmdParam.toUpperCase());
			includePage = sType.getServicePage();
		}catch(IllegalArgumentException e){
			statusCode = HttpServletResponse.SC_NOT_FOUND;
		}
	}
	if(statusCode != 0){
		response.sendError(statusCode);
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<link href="<%= request.getContextPath()%>/css/main.css" rel="stylesheet">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body>
<div id="top">
	<jsp:include page="/includee/header.jsp"></jsp:include>
</div>
<div id="left">
	<jsp:include page="/includee/left.jsp"></jsp:include>
</div>
<div id="body">
<%
	if(StringUtils.isNotBlank(includePage)){
		pageContext.include(includePage);
	}else{
		%>
		<h4> 웰 컴 페이지</h4>
		<pre>
			처음부터 웰컴 페이지로 접속하거나,
			로그인에 성공해서 웰컴 페이지로 접속하는 경우의 수가 있음.
			
			<%
				if(StringUtils.isNotBlank(mem)){
					%>
						<%=mem %>님 로그인 상태, <a href="<%=request.getContextPath() %>/login/logout.jsp">로그아웃</a>				
					<%
				}else{
					%>
						<a href="<%=request.getContextPath() %>/login/loginForm.jsp">로그인하러 가기</a>
					<%
				}		
			%>
		</pre>
		<%
	}
%>	

</div>
<div id="footer">
	<jsp:include page="/includee/footer.jsp"></jsp:include>
</div>
</body>
</html>