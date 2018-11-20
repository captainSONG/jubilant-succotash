<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>08/08inner/cookieView.jsp</title>
</head>
<body>
<h4>하위 경로에서 쿠키 확인</h4>
<table>
	<thead>
		<tr>
			<td>쿠키명</td>
			<td>쿠키값</td>
		</tr>
	</thead>
	<tbody>
		<%
			Cookie[] cookies = request.getCookies();
			if(cookies != null){
				for(Cookie tmp : cookies){
					out.println(String.format("<tr><td>%s</td><td>%s</td></tr>", tmp.getName(), URLDecoder.decode(tmp.getValue(), "UTF-8")));
				}				
			}
		%>
	</tbody>
</table>
</body>
</html>