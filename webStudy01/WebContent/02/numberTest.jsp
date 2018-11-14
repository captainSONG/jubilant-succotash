<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table {
	border: 1px solid red;
}
</style>
</head>
<body>
<%
String minStr = request.getParameter("minDan");
String maxStr = request.getParameter("maxDan");
if(minStr==null || !minStr.matches("\\d")
		|| maxStr==null || !maxStr.matches("\\d")){
	response.sendError(400);
	return;
}
%>
<form action="<%=request.getContextPath() %>/02/numberTest.jsp">
	최소단: <input type="number" name="minDan" value="<%=minStr %>"/>
	최대단: <input type="number" name="maxDan" value="<%=maxStr %>"/>
	<input type="submit" value="구구단"/>
</form>
<table>
	<%
	int minDan = Integer.parseInt(minStr);
	int maxDan = Integer.parseInt(maxStr);
	
	String pattern = "%d * %d = %d\t";
	for(int dan=minDan;dan<maxDan+1;dan++){			
	%>
		<tr>
		<%
		for(int mul=1; mul<10; mul++){				
		%>
			<td><%=String.format(pattern, dan, mul, dan*mul) %></td>
		<%
		}
		%>				
		</tr>
	<%
	}
	%>
</table>
<ul>
	<%
	for(int number = 1; number<51; number++){
	%>
		<li><%=number%></li>
	<%
	}
	%>			
</ul>
</body>
</html>