<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/implicitObject</title>
</head>
<body>
<h4> 기본 객체 (내장 객체)</h4>
<pre>
	**pageContext(PageContext) : JSP 페이지와 관련된 모든 정보를 가진 객체
	request(HttpServletRequest) : 요청과 클라이언트 정보를 캡슐화한 객체
	response(HttpServletResponse) : 응답과 관련된 모든 정보를 캡슐화한 객체
	out(JSPWriter) : 출력버퍼에 데이터를 기록하거나 버퍼를 제어하기위해 사용되는 출력 스트림
	session(HttpSession) : 한 세션 내에서 발생하는 모든 정보를 캡슐화한 객체
	application(ServletContext) : 컨텍스트(어플리케이션)와 서버에 대한 정보를 가진 객체
	<%=application.hashCode() %>
	config(ServletConfig) : 서블릿 등록과 관련된 정보를 가진 객체
	page(Object)(==>this) : 현재 JSP 페이지에 대한 레퍼런스
	exception(Throwable) : 발생한 예외에 대한 정보를 가진 객체
			: 예외(에러)가 발생한 경우, 에러를 처리하는 페이지에서 사용됨.
			(page 지시자의 isErrorPage로 활성화 함.)
	<%=exception %>	
</pre>

</body>
</html>