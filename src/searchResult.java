import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class searchResult
 */
@WebServlet("/searchResult")
public class searchResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchbook = request.getParameter("searchbook");
		
		
		String error ="";
		String next="/SearchResult.jsp";
		
		if(searchbook=="") {
			error+= "Please enter a book.";
			next="/HomePage.jsp";
		}
//		if(searchbook!=found) {
//			error+= "Book not found.";
//			next="/HomePage.jsp";
//		}
		
		request.setAttribute("error", error);
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
		
		try {
			dispatch.forward(request, response);
		}catch(IOException e) {
			e.printStackTrace();
		}catch(ServletException e) {
			e.printStackTrace();
		}
	}
}
