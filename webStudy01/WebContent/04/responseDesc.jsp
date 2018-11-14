<%@page import="java.util.Calendar"%>
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
	//response.setHeader("Content-Type", "text/html;charset=UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>04/responseDesc.jsp</title>
</head>
<body>
<h4> Http Response</h4>
<pre>
	Http의 response 패키징 방식
	1) Response Line : Response Status Code, Protocol/ver
		Response Status Code(응답 상태 코드)
		- 100 : ing...(처리중일때), HTTP1.1 부터 하위 프로토콜로 websocket이 사용됨(connectful).
			**HTTP : Connectless, Stateless
		- 200 : OK, SUCCESS(정상 처리)
		- 300 : 클라이언트의 추가 액션이 필요한 경우,
			304(Not Modified) 파일 변경된적 없으니 클라이언트의 캐쉬에 있는 정보를 그대로 쓰라는 의미
			302/307(Moved) 리소스의 위치가 바뀌었으니 새로운 곳으로 다시 접속하라는 의미 
		- 400 : Client 쪽 문제로 처리실패
			404(Not Found), 400(Bad Request), 405(Method Not Allowed)
			401(UnAuthorized), 403(Forbidden)
		- 500 : Server 쪽 문제로 처리실패
			500(Internal Server Error)
	2) Response Header : 서버나 응답데이터에 대한 부가정보(metadata)
							body에 대한 정보가 들어있다.
		response header name : header value
		
	3) Response Body(Message Body) : 응답 컨텐츠
	** HttpServletResponse를 통한 응답 제어
		: 서버에서 클라이언트로 전송되는 응답에 대한 모든 데이터를 가진 객체.
		1) 응답데이터를 전송하기 위한 출력 스트림의 확보
			char stream(PrintWriter) getWriter(), 
			byte stream(ServletOutputStream) getOutputStream()
		2) setStatus(status_code) : 200/300 사용
			sendError(status_code) : 400/500 사용, 서버의 에러페이지로 자동 연결
		3) setHeader(header_name, header_value)
		   set[add]IntHeader(header_name, header_value)
		   set[add]DateHeader(header_name, long header_value)
		   
		   응답 헤더를 설정하는 경우.
		  a) MIME 설정 : Content-Type
		  		setHeader, serContentType, page 지시자의 contentType 속성
		  b) Cache 제어 : Cache-control(HTTP/1.1), Pragma(HTTP/1.0), Expires
		  			표준화에 맞출시 전부 다 쓴다.
  		<%
  			//캐시를 저장하지 않도록 설정
  			//response.setHeader("Pragma", "no-cache");
  			//response.setHeader("Cache-control", "no-cache");		  		
  			//response.addHeader("Cache-control", "no-store");
  			//response.setDateHeader("Expires", 1);
  			
  			//캐시를 저장하도록 설정
  			int maxAge = 60*60*24*7;
  			response.setHeader("Pragma", "public;max-age="+maxAge);
  			response.setHeader("Cache-Control", "public;max-age="+maxAge);
  			Calendar today = Calendar.getInstance();
  			today.add(Calendar.SECOND, maxAge);
  			response.setDateHeader("Expires", today.getTimeInMillis());
  		%>
		  c) Auto Request : refresh // 초단위로 설정시 초가 지난뒤 자동 요청이 발생
		  
		  d) Page Move(Flow Control) : Location
		  	request dispatch 방식 (Server Side 위임처리 방식)- forward방식, include방식
		  	redirect 방식 
	
</pre>
</body>
</html>