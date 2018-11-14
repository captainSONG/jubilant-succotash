package kr.or.ddit.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.web.calculate.Operator;

public class CalculateServlet extends HttpServlet {
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		ServletContext application = getServletContext();
		String contentFolder = application.getInitParameter("contentFolder");
		File folder = new File(contentFolder);
		application.setAttribute("contentFolder", folder);
		System.out.println(getClass().getSimpleName()+"초기화");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파라미터 확보 (입력태그의 name 속성값으로 이름 결정)
		String leftOpStr = req.getParameter("leftOp");
		String rightOpStr = req.getParameter("rightOp");
		String operatorStr = req.getParameter("operator");
		
		// 검증
		int leftOp, rightOp;
		boolean valid = true;
		if(leftOpStr==null || !leftOpStr.matches("\\d+") || rightOpStr==null || !rightOpStr.matches("\\d{1,6}")) {
			valid = false;
		}
		
		Operator operator = null;
		try {
			operator = Operator.valueOf(operatorStr.toUpperCase());			
		} catch (Exception e) {
			valid = false;
		}		
		
		if(!valid) {
			// 통과못해서 400 에러 발생
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
		}
		
		// 통과
		// 연산자에 따라 연산 수행
		// 일반 텍스트의 형태로 연산 결과를 제공.
		// 연산결과 : 2 * 3 = 6
		
		leftOp = Integer.parseInt(leftOpStr);
		rightOp = Integer.parseInt(rightOpStr);
		String pattern= "%d %s %d = %d";
		
		String result = String.format(pattern, leftOp, operator.getsign(), rightOp, operator.operate(leftOp, rightOp));
		
		//request의 header의 값에 따라 필요한 mime 타입을 설정해주는 부분이다.
		String accept = req.getHeader("Accept");
		String mime = null;
		if(accept.contains("plain")) {
			mime = "text/plain;charset=UTF-8";
		} else if(accept.contains("json")) {
			mime = "application/json;charset=UTF-8";
			result = "{\"result\":\""+result+"\"}";
		} else {
			mime = "text/html;charset=UTF-8";
			result = "<p>"+result+"</p>";
		}
		
		resp.setContentType(mime);
		PrintWriter out = resp.getWriter();
		out.println(result);
		out.close();
		/*
		직접 한 코딩
		if(!leftOpStr.matches("\\d{1,6}")||!rightOpStr.matches("[0-9]{1,6}")||operator.isEmpty()) {
			resp.sendError(400);
			return;
		}
		
		int leftNum = Integer.parseInt(leftOpStr);
		int rightNum = Integer.parseInt(rightOpStr);		
		double result = 0.0;
		switch (operator) {
		case "add":
			 result = leftNum + rightNum;
			break;
		case "minus":
			result = (double)leftNum - rightNum;
			break;
		case "multiply":
			result = (double)leftNum * rightNum;
			break;
		case "divide":
			result = (double)leftNum / rightNum;
			break;

		default:
			break;
		}
		
		PrintWriter out =resp.getWriter();
		out.println(String.format("%d %s %d = %.2f", leftNum,operator,rightNum,result));
		out.close();
		*/
	}	
}
