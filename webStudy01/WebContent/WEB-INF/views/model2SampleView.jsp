<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WEB-INF/views/model2SampleView.jsp</title>
</head>
<body>
<pre>
	모델 2 구조를 이용중,
	컨트롤러를 거친 이후에 응답이 생성되는 영역. - view layer
	컨트롤러가 전달해준 모델 : <%= request.getAttribute("model") %>
</pre>	
</body>
</html>