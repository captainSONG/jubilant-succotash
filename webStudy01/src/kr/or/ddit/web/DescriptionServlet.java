package kr.or.ddit.web;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *  Servlet
 *  : 자바 기반의 확장 CGI방식을 이용한 웹 프로그래밍 기술 스펙이면서 동시에 API.
 *  
 *  서블릿 개발 단계
 *  1. HttpServlet을 상속받아 구현
 *  2. 컴파일 -> 웹 어플리케이션의 classpath에 배포(/WEB-INF/classes)
 *  3. 등록
 *    1) web.xml을 이용한 명시적 등록
 *    2) @WebServlet 을 이용한 등록(since 3.0)
 *  4. 웹상의 요청과의 매핑 정보를 완성
 *    1) web.xml을 이용한 명시적 등록
 *    2) @WebServlet 을 이용한 등록(since 3.0)
 *  5. 서버(WAS, ServletContainer) 재구동
 *  
 *  W.A.S(Web Application Server, ServletContainer, WebContainer, JSPContainer)
 *  : 서블릿 스펙에 따라 개발된 웹 어플리케이션을 운영할 주체(관리자).
 *  : 서블릿의 생명주기를 관리하는 역할
 *    (서블릿의 생명주기 내에서 특정 이벤트가 발생시 해당 콜백 메소드를 호출)
 *  : 싱글턴 서블릿 운영, 요청이 쓰레드로 처리되며 해당 쓰레드는 풀링 정책에 따라 관리됨  
 *  서블릿의 생명주기와 관련된 콜백 메소드의 종류
 *    init : 서블릿의 객체가 생성된 직후에 호출되는 메소드
 *    service : 요청이 발생할때마다 반복 호출
 *    			요청의 HTTP method에 따라 doXXX 계열 메소드를 호출.
 *    doGet 등의 doXXX 계열 메소드
 *    		: 요청이 발생할때마다 반복 호출
 *    		  Http method에 따라 service에 의해 호출됨.
 *    destroy : 서블릿의 객체가 소멸되기 직전에 호출되는 메소드
 *    
 *  WAS의 서블릿을 이용한 요청 처리 단계
 *  1) 서블릿 매핑 정보를 통해 현재 요청을 처리할 서블릿을 검색.
 *  2) 해당 서블릿의 객체 생성 여부를 판단
 *  3) 현재 요청이 최초의 요청이라면(객체 생성 전), 해당 서블릿의 객체를 생성 - init 호출
 *  	singleton 정책에 따라 이미 생성된 객체에 대해 skip.
 *  4) Thread pooling 정책에 따라 쓰레드 할당 -> service 호출
 *  
 *  	
 *   
 *
 */
public class DescriptionServlet extends HttpServlet{
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		System.out.println(this.getClass().getName()+"객체 초기화");
		System.out.println(config.getInitParameter("testParam"));
		System.out.println(getServletContext().hashCode());
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(getServletConfig().getInitParameter("testParam"));
		System.out.println("service 호출");
		super.service(req, resp);
		System.out.println("service 종료");
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("doGet 호출");
	}
	
	@Override
	public void destroy() {
		super.destroy();
		System.out.println(this.getClass().getName()+"객체 소멸");
	}
	
}
