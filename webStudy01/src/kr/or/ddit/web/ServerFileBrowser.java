package kr.or.ddit.web;

import java.io.File;
import java.io.IOException;
import java.util.Objects;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/fileBrowser.do")
public class ServerFileBrowser extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String getFilePath = req.getParameter("filePath");
		ServletContext sc = getServletContext();
		
		String url = Objects.toString(getFilePath, sc.getRealPath(""));
		File fileUrl = new File(url);
		
		//상위경로를 만듬
		String parentUrl = null;
		System.out.println("url = "+sc.getRealPath(""));
		if(url.equals(sc.getRealPath(""))) {
			parentUrl = "root";
		}else {
			int end = url.lastIndexOf("\\");
			parentUrl = url.substring(0, end);
		}
		
		req.setAttribute("parentUrl", parentUrl);
		
		File[] fileList = fileUrl.listFiles();
		req.setAttribute("fileList", fileList);
		
		String view = "/WEB-INF/views/fileBrowser.jsp";
		RequestDispatcher rd = req.getRequestDispatcher(view);
		rd.forward(req, resp);
		
	}
}
