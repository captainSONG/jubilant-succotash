<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public Map<String,String[]> singerMap = new LinkedHashMap<>();

	{
		singerMap.put("B001", new String[]{"RM", "/WEB-INF/bts/rm.jsp"});
		singerMap.put("B002", new String[]{"제이홉", "/WEB-INF/bts/j_hop.jsp"});
		singerMap.put("B003", new String[]{"지민", "/WEB-INF/bts/jimin.jsp"});
		singerMap.put("B004", new String[]{"진", "/WEB-INF/bts/jin.jsp"});
		singerMap.put("B005", new String[]{"슈가", "/WEB-INF/bts/suga.jsp"});
		singerMap.put("B006", new String[]{"뷔", "/WEB-INF/bts/v.jsp"});
		singerMap.put("B007", new String[]{"정국", "/WEB-INF/bts/jungguk.jsp"});
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/btsForm.jsp</title>
<script type="text/javascript">
	function goBTS() {		
		document.btsForm.submit();		
	}
</script>
</head>
<body>
<form name="btsForm" action="<%=request.getContextPath() %>/05/getBTS.jsp" onchange="goBTS()">
	<select name="member">
		<option value="">멤버 선택</option>
		<%
			String pattern = "<option value='%s'>%s</option>";
			for(Entry<String, String[]> tmp : singerMap.entrySet()){
				String value = tmp.getKey();
				String[] name = tmp.getValue();
				out.println(String.format(pattern, value, name[0]));
			}			
		%>
	</select>
</form>
</body>
</html>