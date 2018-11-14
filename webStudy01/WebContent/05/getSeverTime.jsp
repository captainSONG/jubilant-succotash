<%@page import="java.util.Objects"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>    
<%! 
	String marshalling(Map<String, Object> originalData){
		StringBuffer result = new StringBuffer();
		result.append("{");
		String jsonPattern = "\"%s\" :\" %s\",";
		for(Entry<String, Object> entry :originalData.entrySet()){
			String propName = entry.getKey();
			String propValue = Objects.toString(entry.getValue(),"");
			result.append(String.format(jsonPattern, propName, propValue));
		}
		int lastIndex = result.lastIndexOf(",");
		result.deleteCharAt(lastIndex);
		result.append("}");
		return result.toString();
	}
%>
<%--
    매 1초마다 현재 서버의 시간을 JSON 형태로 전송
	응답으로 전송될 JSON 객체 내에서 
	현재 서버의 시각을 의미하는 serverTime 라는 프로퍼티 있음
--%>
<%
	response.setHeader("Refresh", "1");
    Date now = new Date();
    Map<String, Object> javaObject = new LinkedHashMap<>();
    javaObject.put("serverTime", now);
	String json = marshalling(javaObject);
	out.print(json);
%>

	