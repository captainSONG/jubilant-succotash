<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	function goIndex(command){
		var form = document.leftForm;
		form.command.value = command;
		form.submit();
	}
</script>
<ul>
	<li><a href="javascript:goIndex('gugudan');">구구단</a></li>
	<li><a href="javascript:goIndex('lyrics');">가사파일</a></li>
	<li><a href="javascript:goIndex('calendar');">달력</a></li>
	<li><a href="javascript:goIndex('image');">이미지뷰어</a></li>
</ul>
<form name="leftForm" action="<%=request.getContextPath() %>/" method="post">
	<input name="command" value="" type="hidden"/>
</form>