<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
	BigDecimal factorial(int opreand){
		if(opreand < 0){
			throw new IllegalArgumentException("음수는 팩토리얼 연산 불가");
		}else if(opreand <=1){
			return new BigDecimal(opreand);
		} else{
			return new BigDecimal(opreand).multiply(factorial(opreand-1));				
		}
	} 
%>
<%
	String opStr = request.getParameter("operand");
	boolean flag = false;
	if(opStr== null || opStr.matches("\\d{2}|100")){
		flag = true;
	}	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>02/factorial.jsp</title>
</head>
<body>
<form>
	Factorial operand : <input type="number" min="1" max="100" name="operand" value="<%=opStr %>" />
	<button type="submit">전송</button>
</form>
<%
	if(flag){
		int opreand = Integer.parseInt(opStr);		
%>
		<div> <%= factorial(opreand) %> </div>
<%
	}
%>

</body>
</html>