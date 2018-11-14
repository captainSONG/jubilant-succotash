package kr.or.ddit.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import kr.or.ddit.vo.AlbasengVO;

@WebServlet(value = "/albamon", loadOnStartup = 1)
public class SimpleFormProcessServlet extends HttpServlet {
	public Map<String, String> gradeMap;
	public Map<String, String> licenseMap;
	
	{
		gradeMap = new HashMap<>();
		licenseMap = new LinkedHashMap<>();
		
		gradeMap.put("G001", "고졸");
		gradeMap.put("G002", "대졸");
		gradeMap.put("G003", "석사");
		gradeMap.put("G004", "박사");
		
		licenseMap.put("L001", "정보처리산업기사");
		licenseMap.put("L002", "정보처리기사");
		licenseMap.put("L003", "정보보안산업기사");
		licenseMap.put("L004", "정보보안기사");
		licenseMap.put("L005", "SQLD");
		licenseMap.put("L006", "SQLP");
	}
	
	public static Map<String, AlbasengVO> albasengs = new LinkedHashMap<>();
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		getServletContext().setAttribute("gradeMap", gradeMap);
		getServletContext().setAttribute("licenseMap", licenseMap);
		getServletContext().setAttribute("albasengs", albasengs);
		
		System.out.println(getClass().getSimpleName()+"초기화");
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		String name = req.getParameter("name");
		String ageStr = req.getParameter("age");
		String tel = req.getParameter("tel");
		String address = req.getParameter("address");
		String gender = req.getParameter("gender");
		String grade = req.getParameter("grade");
		String career = req.getParameter("career");
		String[] license = req.getParameterValues("license");
		
		System.out.printf("%s : %s /n", "name", name);
		System.out.printf("%s : %s /n", "license", Arrays.toString(license));
		*/
				
		/*
		req.setCharacterEncoding("UTF-8");
		Enumeration<String> names = req.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			String[] values = req.getParameterValues(name);
			System.out.printf("%s : %s\n",name, Arrays.toString(values));
		}
		
		Map<String, String[]> parameterMap = req.getParameterMap();		
		for (Entry<String, String[]> entry : parameterMap.entrySet()) {
			String name = entry.getKey();
			String[] value = entry.getValue();
			System.out.printf("%s : %s\n",name, Arrays.toString(value));
		}
		
		PrintWriter out = resp.getWriter();		
		out.println();					
		out.close();
		*/
		
		/*
		VO 객체 생성. 파라미터 할당		
		VO를 대상으로 검증
		(이름, 전화번호, 주소 필수데이터 검증)
		
		1) 통과
		code 생성 ("alba_001")
		map.put(code, vo);
		이동(/05/albaList.jsp, 요청 처리 완료 후 이동) redirect
		
		2) 불통
		이동(/01/simpleForm.jsp, 기존 입력 데이터를 전달한채 이동) dispatch
		*/
		//alba_%03d, albasengs.size()+1
		
		
		req.setCharacterEncoding("UTF-8");
		String name =  req.getParameter("name");
		String age =  req.getParameter("age");
		String tel =  req.getParameter("tel");
		String addr =  req.getParameter("address");
		String gender =  req.getParameter("gender");
		String grade =  req.getParameter("grade");
		String career =  req.getParameter("career");
		String[] license = req.getParameterValues("license");
		AlbasengVO vo = new AlbasengVO();
		vo.setName(name);
		if(age!=null && age.matches("\\d{1,2}")) {
			vo.setAge(new Integer(age));
		} 
		vo.setAddress(addr);
		vo.setTel(tel);
		vo.setGender(gender);
		vo.setGrade(grade);
		vo.setLicense(license);
		vo.setCareer(career);
		boolean valid = true;
		Map<String, String> errors = new LinkedHashMap<>();
		req.setAttribute("errors", errors);
		if(StringUtils.isBlank(vo.getName())) {
			valid = false;
			errors.put("name", "이름 누락");
		}
		if(StringUtils.isBlank(vo.getTel())) {
			valid = false;
			errors.put("tel", "전화번호 누락");
		}
		if(StringUtils.isBlank(vo.getAddress())) {
			valid = false;
			errors.put("address", "주소 누락");
		}
		boolean redirect = false;
		String goPage = null;
		if(valid) {
			vo.setCode(String.format("alba_%03d", albasengs.size()+1));
			albasengs.put(vo.getCode(), vo);
			goPage = "/05/albaList.jsp";
			redirect = true;
		}else {
			goPage = "/01/simpleForm.jsp";
			req.setAttribute("albaVO", vo);
		}
		if(redirect) {
			resp.sendRedirect(req.getContextPath() + goPage);
		}else {
			RequestDispatcher rd = req.getRequestDispatcher(goPage);
			rd.forward(req, resp);
		}
		
		/*
		내가 한 코딩
		int statusCode = 0;
		
		req.setCharacterEncoding("UTF-8");
		
		String name = req.getParameter("name");
		String ageStr = req.getParameter("age");
		
		String address = req.getParameter("address");
		String tel = req.getParameter("tel");
		String gender = req.getParameter("gender");
		String grade = req.getParameter("grade");
		String[] license = req.getParameterValues("license");
		String career = req.getParameter("career");
		
		if(!name.matches("/^[가-힣]{2,4}$/")||name==null || name.trim().length()==0 || address==null || address.trim().length()==0
				|| tel.matches("/^\\d{3}-\\d{3,4}-\\d{4}$/") || tel == null || tel.trim().length() ==0) {
			RequestDispatcher rd =req.getRequestDispatcher("/01/simpleForm.jsp");
			rd.forward(req, resp);
			return;
		}

		AlbasengVO abv = new AlbasengVO();
		String code = String.format("alba_%03d", albasengs.size()+1);
		int age = Integer.parseInt(ageStr);
		abv.setCode(code);
		abv.setName(name);
		abv.setAge(age);
		abv.setAddress(address);
		abv.setTel(tel);
		abv.setGender(gender);
		abv.setGrade(grade);
		abv.setLicense(license);
		abv.setCareer(career);
		
		albasengs.put(code, abv);
		
		resp.sendRedirect(req.getContextPath()+"/05/albaList.jsp");
		*/
	}
}
