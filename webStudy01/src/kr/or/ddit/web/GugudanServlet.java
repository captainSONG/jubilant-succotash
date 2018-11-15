package kr.or.ddit.web;
import java.io.*;
import javax.servlet.http.*;
import javax.servlet.*;
import java.util.*;
import javax.servlet.annotation.*;


@WebServlet(value ="/gugudan.do")
public class GugudanServlet extends HttpServlet{	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 2~9단까지의 구구단을 table 태그를 이용하여 출력.
		// 단, 한행에 한단씩
		// 테스트시에 /gugudan.do 요청을 사용.
		// web.xml을 사용하지 말것.
		
		String minDanStr = req.getParameter("minDan");
		String maxDanStr = req.getParameter("maxDan");
		
		int minDan = 2;
		int maxDan = 9;
		if(minDanStr != null && minDanStr.matches("\\d")) {
			minDan = Integer.parseInt(minDanStr);			
		}
		if(maxDanStr != null && maxDanStr.matches("[0-9]")) {
			maxDan = Integer.parseInt(maxDanStr);			
		}
		
		resp.setContentType("text/html;charset=UTF-8");
		InputStream in = this.getClass().getResourceAsStream("gugudan.205"); //byte stream
		InputStreamReader isr = new InputStreamReader(in, "UTF-8"); // byte -> Character 스트림 타입 변형 해준다
		BufferedReader br = new BufferedReader(isr); // Character stream
		StringBuffer html = new StringBuffer();
		String temp = null;
		while( (temp = br.readLine()) != null){
			html.append(temp);
		}
		
		StringBuffer sb = new StringBuffer();
		
		for(int dan= minDan; dan < maxDan+1; dan++){
			sb.append("<tr>");
			for(int num=1; num<10; num++){
				sb.append(String.format("<td>%d * %d = %d</td>",dan,num,dan*num));
			}
			sb.append("</tr>");
		}
		
		int start = html.indexOf("@gugudan");
		int end = start + "@gugudan".length();
		String replacetext = sb.toString();
		
		html.replace(start, end, replacetext);
		
		PrintWriter out = resp.getWriter();
		out.println(html.toString());
		//out.close();
	}

}
