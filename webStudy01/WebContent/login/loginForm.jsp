<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String failedId = request.getParameter("mem_id");
	String message = (String)session.getAttribute("message");

	/* 
	내가 만든 코딩
	String id_value = request.getParameter("mem_id");
	if(id_value == null){
		id_value = "";
	}
	 */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/loginForm.jsp</title>
<script type="text/javascript">
	<%
		if(StringUtils.isNotBlank(message)){
			%>
			alert("<%= message%>");
			<%	
			session.removeAttribute("message");
		}		
	%>

</script>
</head>
<body>

	<form action="<%=request.getContextPath() %>/login/loginCheck.jsp" method="post">
		<ul>
			<li>
				아이디 : <input type="text" name="mem_id" value="<%= Objects.toString(failedId, "")%>">
								
				<%-- 내가 만든코딩// 아이디 : <input type="text" name="mem_id" value="<%= id_value %>"> --%>				
			</li>
			<li>
				비밀번호 : <input type="password" name="mem_pass">
				<input type="submit" value="로그인">
			</li>			
		</ul>
	</form>
</body>
</html>