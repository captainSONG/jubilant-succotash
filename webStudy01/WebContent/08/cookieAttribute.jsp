<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>08/cookieAttribute.jsp</title>
</head>
<body>
<h4> 쿠키의 속성들</h4>
<pre>
	1. path : 브라우저의 쿠키 저장소에 저장된 쿠키가 다시 서버로 재전송 될지 여부를 결정.
			쿠키에 설정된 path 속성의 값을 확인하여,
			해당 경로의 하위 경로로 발생하는 요청에만 쿠키가 재전송
			생략한 경우, 쿠키의 생성 경로를 기본값으로 사용함.
			
	2. domain/host : 저장된 쿠키의 재전송 여부를 결정할 때 사용.
			생략한 경우, 쿠키가 생성된 도메인(호스트)가 사용됨.
			특정사이트가 보유하고 있는 모든 호스트에 전송될 쿠키를 생성할때 사용
			도메인의 레벨 구조에 따라 ".naver.com"방식으로 설정함.
			
	3. maxAge : 만료 시간, 생략하면, 기본값으로 세션의 만료시간이 적용됨.
				-1 : 브라우저의 종료 시점에 삭제.
				0 : 기존의 쿠키가 있을 경우, 해당 쿠키를 삭제할때 사용.
					(maxAge를 제외한 나머지 설정이 모두 동일한 경우.)
				
	4. secure : 보안 채널(http)을 통해서만 전송될 쿠키를 설정.
	
	5. name/value(required) : RFC2396 규약에 따라 URL Encoding 방식이 적용됨.
	<%
		String allPathCookieValue = URLEncoder.encode("모든경로에서 사용 가능","UTF-8");
		Cookie allPathCookie = new Cookie("allPathCookie", allPathCookieValue);
		allPathCookie.setPath(request.getContextPath());
		response.addCookie(allPathCookie);
		
		String otherPathCookieValue = URLEncoder.encode("09의 하위에서 사용 가능","UTF-8");
		Cookie otherPathCookie = new Cookie("otherPathCookie", otherPathCookieValue);
		otherPathCookie.setPath(request.getContextPath()+"/09");
		response.addCookie(otherPathCookie);
		
		/* Cookie otherDomainCookie = new Cookie("otherDomainCookie", "Other Domain Cookie");
		otherDomainCookie.setDomain(".sck.com");
		otherDomainCookie.setPath("/");
		response.addCookie(otherDomainCookie); */
		
		Cookie longLiveCookie = new Cookie("longLiveCookie", "Long Live Cookie");
		longLiveCookie.setMaxAge(0);
		longLiveCookie.setPath("/");
		longLiveCookie.setSecure(true);
		response.addCookie(longLiveCookie);
		
	%>
	<a href="cookieView.jsp">쿠키 확인하기(동일 경로에서)</a>
	<a href="08inner/cookieView.jsp">쿠키 확인하기(하위 경로에서)</a>
	<a href="<%=request.getContextPath() %>/09/cookieView.jsp">쿠키 확인하기(다른 경로에서)</a>
	
</pre>
</body>
</html>