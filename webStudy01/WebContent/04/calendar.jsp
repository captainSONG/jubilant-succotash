<%@page import="java.util.Locale"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="static java.util.Calendar.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
	.sunday{
		background-color: red;
	}
	.saturday{
		background-color: blue;
	}
	table{
		width: 100%;
		height: 500px;
		border-collapse: collapse;
	}
	td,th{
		border: 1px solid black;
	}
</style>
<script type="text/javascript">
	function eventHandler(year, month) {
		var form = document.calForm;
		if((year && month) || month==0 ){
			form.year.value = year;			
			form.month.value = month;
		}		
		form.submit();
		return false;
	}
</script>

<%
	//name과 매칭되는 요청의 파라미터값들을 받는다.
	String yearStr = request.getParameter("year");
	String monthStr = request.getParameter("month");
	String language = request.getParameter("language");
	
	//현재 요청의 지역 정보를 저장한다.
	Locale clientLocale = request.getLocale();
	//if문을 타지 않을경우 기본값을 요청값으로 저장한다.
	if(language != null && language.trim().length()>0){
		clientLocale = Locale.forLanguageTag(language);
	}
	//달의 이름, 요일의 이름, 타임 존 데이터 등, 지역 대응이 가능한 일자 / 시각 포맷 데이터를 캡슐화하기위한 public 클래스
	DateFormatSymbols symbols = new DateFormatSymbols(clientLocale);	
	
	//달력 객체를 사용하기위해 선언
	Calendar cal = Calendar.getInstance();
	if(yearStr != null && yearStr.matches("\\d{4}") && monthStr != null && monthStr.matches("1[0-1]|\\d")){
		cal.set(YEAR, Integer.parseInt(yearStr));
		cal.set(MONTH, Integer.parseInt(monthStr));
	}
	
	int currentYear = cal.get(YEAR);
	int currentMonth = cal.get(MONTH);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	int firstDayOfWeek = cal.get(DAY_OF_WEEK);
	int offset = firstDayOfWeek-1;
	int lastDate = cal.getActualMaximum(DAY_OF_MONTH);
	
	cal.add(MONTH, -1);
	
	int beforeYear = cal.get(YEAR);
	int beforeMonth = cal.get(MONTH);
	
	cal.add(MONTH, 2);
	int nextYear = cal.get(YEAR);
	int nextMonth = cal.get(MONTH);
	Locale[] locales = Locale.getAvailableLocales();	
%>
<form name="calForm" action="" method="post">
<input type="hidden" name="command" value="calendar">
	<h4>
		<%-- 전의 달을 가져오기 위해서 전 년도와 전월을 받아 이벤트가 발생 --%>
		<a href="javascript:eventHandler(<%= beforeYear%>,<%= beforeMonth%>)">&lt;-</a>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%-- 년도를 입력받은뒤 입력이 끝나면 이벤트가 발생한다. --%>
		<input type="number" name="year" value="<%= currentYear%>"
			onblur="eventHandler();"
		>년
		<%-- 달을 select에 option태그를 이용해서 만들어주는 부분 option을 선택했을때 이벤트 발생--%>
		<select name="month" onchange="eventHandler()">
			<%
				//달의 줄임말을 배열에 저장
				String[] monthStrings = symbols.getShortMonths();
				for(int idx=0; idx< monthStrings.length; idx++){
					//option을 생성해준다.
					out.println(String.format("<option value='%d' %s>%s</option>",
					//선택한 달과 idx가 일치할 경우 selected 옵션을 주기 위해 사용한다.
							idx, idx==currentMonth?"selected":"" ,monthStrings[idx]));
				}
			%>
		</select>
		<select name="language" onchange="eventHandler()">
			<%
				for(Locale tmp: locales){
					// 선택한 언어로 출력해주기위한 메서드
					out.println(String.format("<option value='%s' %s>%s</option>",			
							//클라이언트의 지역과 locales의 태그와 일치할때 선택한 값을 고정시켜주고 언어를 보여준다.
							tmp.toLanguageTag(), tmp.equals(clientLocale)?"selected":"",
									tmp.getDisplayLanguage(clientLocale)));
				}
			%>
		</select>		
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a onclick="eventHandler(<%= nextYear%>,<%= nextMonth%>)">-&gt;</a>
	</h4>
</form>
<table>
<thead>
	<tr>
		<%
			//요일의 줄임말을 String배열에 담아준다.
			String[] dateStrings = symbols.getShortWeekdays();
			//일요일은 1이고 토요일은 7이므로 1부터7까지 요일을 작성해준다.
			for(int idx = Calendar.SUNDAY; idx<= Calendar.SATURDAY; idx++){
				out.println(String.format("<th>%s</th>", dateStrings[idx]));
			}
		%>
	</tr>
</thead>
<tbody>

<%
	//토,일에 색을 주기 위해서 class 이름을 만들어주는 부분 
	int dayCount=1;
	for(int row=1;row<7;row++){
		%>
		<tr>
		<%
		for(int col=1; col<8; col++){
			int dateChar = dayCount++ - offset;
			if(dateChar < 1 || dateChar > lastDate){
				out.println("<td>&nbsp;</td>");
			}else{
				String clzValue = "normal";
				if(col==1){
					clzValue = "sunday";
				} else if(col==7){
					clzValue = "saturday";
				}
					out.println(String.format("<td class='%s'>%d</td>", clzValue, dateChar));											
			}
		}		
		%>
		</tr>
		<%
	}
%>
</tbody>
</table>
