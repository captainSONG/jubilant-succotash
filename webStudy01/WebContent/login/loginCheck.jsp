<%@page import="kr.or.ddit.utils.CookieUtil.TextType"%>
<%@page import="kr.or.ddit.member.service.AuthenticateServiceImpl.ServiceResult"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="kr.or.ddit.member.service.AuthenticateServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IAuthenticateService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	/* boolean authenticate(String mem_id, String mem_pass) throws SQLException{
		boolean result = false;		
		StringBuffer sql = new StringBuffer();
		sql.append(" select mem_name ");		
		sql.append(" from member ");
		sql.append(" where mem_id = ? and mem_pass = ? ");
		
		try(
			Connection conn = ConnectionFactory.getConnection();
			//Statement stmt = conn.createStatement();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
		){
			pstmt.setString(1, mem_id);
			pstmt.setString(2, mem_pass);
			
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				result = true;
			}
		}
	
		return result; */
		/* 
		직접한 코딩
		boolean chk = false;
		ResultSet rs = null;
		Connection conn =null;
		Statement stmt =null;
		
		try{
			conn = ConnectionFactory.getConnection();
			stmt = conn.createStatement();
			StringBuffer sql = new StringBuffer();
			sql.append(" select mem_name ");		
			sql.append(" from member ");
			sql.append(" where mem_id = '"+mem_id+"' and mem_pass = '"+ mem_pass +"' ");
			rs = stmt.executeQuery(sql.toString());
			
			if(rs != null){
				chk = true;
			}
			
		} catch(Exception e){
			e.printStackTrace();
		} finally{
			if(rs != null){ try{
					rs.close();
				} catch(Exception e){
					e.printStackTrace();
				}
			}
			if(conn != null) {try{
					conn.close();
				} catch(Exception e){
					e.printStackTrace();
				}
			}
			if(stmt != null) {try{
					stmt.close();
				} catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		return chk; 
	}
		*/
%>
1. 파라미터 확보
2. 검증(필수 데이터)
3. 불통
	이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달 할 수 있는 방식.)
4. 통과
	4-1. 인증(아이디 == 비번)
		4-2. 인증성공 : 웰컴 페이지로 이동(원본 요청을 제거하고 이동)
		4-3. 인증실패 : 이동(loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달 할 수 있는 방식.)
<%
	request.setCharacterEncoding("UTF-8");	
	String mem_id = request.getParameter("mem_id");
	String mem_pass = request.getParameter("mem_pass");
	String idChecked = request.getParameter("idChecked");
	String goPage = null;
	boolean redirect = false;
	
	
	
	if(mem_id == null || mem_id.trim().length() == 0 ||
			mem_pass == null || mem_pass.trim().length() ==0){
		goPage = "/login/loginForm.jsp";
		redirect = true;
		session.setAttribute("message", "아이디 비번 누락");
	}else{
		IAuthenticateService service = new AuthenticateServiceImpl();
		Object result = service.authenticate(new MemberVO(mem_id, mem_pass));
		if(result instanceof MemberVO){
			goPage = "/";
			redirect = true;
			session.setAttribute("authMember", result);
			int maxAge = 0;
			if("idSaved".equals(idChecked)){
				maxAge = 60*60*24*7;
			}
			Cookie idCookie = CookieUtil.createCookie("idCookie", mem_id, request.getContextPath(), TextType.PATH, maxAge);			
			response.addCookie(idCookie);
		} else if(result == ServiceResult.PKNOTFOUND){
			goPage = "/login/loginForm.jsp";
			redirect = true;
			session.setAttribute("message", "존재하지 않는 회원");
		} else{
			goPage = "/login/loginForm.jsp";
			redirect = true;
			session.setAttribute("message", "비번 오류 인증 실패");			
		}
	}
	
	if(redirect){
		response.sendRedirect(request.getContextPath()+goPage);
	} else{
		RequestDispatcher rd = request.getRequestDispatcher(goPage);
		rd.forward(request, response);
	}
		
	/* 
	직접한 코딩
	String id = request.getParameter("mem_id");
	String pass = request.getParameter("mem_pass");
	
	String savePass = "aaa"; 
	
	if(pass.trim().length() == 0 || pass == null || !id.matches("^[a-zA-Z0-9]*$")
			|| id.trim().length()==0 || id == null){
		RequestDispatcher rd = request.getRequestDispatcher("/login/loginForm.jsp");
		rd.forward(request, response);
		return;
	}
	
	if(pass.equals(savePass)){
		response.sendRedirect(request.getContextPath()+"/index.jsp");		
	} else{
		RequestDispatcher rd = request.getRequestDispatcher("/login/loginForm.jsp");
		rd.forward(request, response);
	}
	 */
%>
