package kr.or.ddit.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ImagesFormServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html;charset=UTF-8");
		ServletContext context = req.getServletContext();
		File folder = (File)getServletContext().getAttribute("contentFolder");
		String[] filenames = folder.list(new FilenameFilter() {
			
			@Override
			public boolean accept(File dir, String name) {
				String mime = context.getMimeType(name);
				return mime.startsWith("image/");
			}
		});
		
		StringBuffer options = new StringBuffer();
		String pattern = "<option>%s</option>\n";
		for (String name : filenames) {
			options.append(String.format(pattern, name));
		}
		
		// action 속성의 값은 context/imagesService, method="get"
		
		InputStream is = this.getClass().getResourceAsStream("imgForm.html");
		InputStreamReader isr = new InputStreamReader(is, "UTF-8");
		BufferedReader reader = new BufferedReader(isr);
		String temp = null;
		StringBuffer html = new StringBuffer();
		while ((temp = reader.readLine()) != null) {
			html.append(temp+"\n");
		}
		
		/*for (int i = 0; i < filenames.length; i++) {
			options.append(String.format("<option>%s</option>", filenames[i]));
		}*/
		
		int start = html.indexOf("@options");
		int end = start + "@options".length();
		html.replace(start, end, options.toString());
		
		PrintWriter out = resp.getWriter();
		out.println(html);
		out.close();
	}
}
