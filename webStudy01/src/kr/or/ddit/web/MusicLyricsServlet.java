package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MusicLyricsServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		ServletContext context = req.getServletContext();
		File folder = new File("/d:contents");
		String[] fileNames = folder.list(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
				String mime = context.getMimeType(name);
				return mime.startsWith("text/");
			}
		});
		
		StringBuffer options = new StringBuffer();
		String pattern = "<option>%s</option>\n";
		for (String name : fileNames) {
			options.append(String.format(pattern, name));
		}
		
		InputStream is = this.getClass().getResourceAsStream("songForm.html");
		InputStreamReader isr = new InputStreamReader(is, "UTF-8");
		BufferedReader br = new BufferedReader(isr);
		String temp = null;
		StringBuffer html = new StringBuffer();
		while ((temp= br.readLine()) != null) {
			html.append(temp+"\n");
		}
		
		int start = html.indexOf("@option");
		int end = start+"@option".length();
		html.replace(start, end, options.toString());
		
		PrintWriter out = resp.getWriter();
		out.println(html);
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		String textName = req.getParameter("text");
		if(textName == null || textName.trim().length()==0) {
			resp.sendError(400);
			return;
		}
		
		File folder = new File("d:/contents");
		File textFile = new File(folder, textName);
		if(!textFile.exists()) {
			resp.sendError(404);
			return;
		}
		
        FileInputStream fi = null;
        InputStreamReader in = null;

        fi = new FileInputStream(textFile);
        in = new InputStreamReader(fi, "EUC-KR");
        BufferedReader br  = new BufferedReader(in);

        String ch = null;
        StringBuffer sb = new StringBuffer();
        sb.append("<html>");
        sb.append("<body>");
        while ((ch = br.readLine()) != null) {
        	sb.append(ch+"<br>");
        }
        sb.append("</body>");
        sb.append("</html>");
        fi.close();
		
        PrintWriter out = resp.getWriter();
        out.println(sb.toString());
        out.close();
	}
}
