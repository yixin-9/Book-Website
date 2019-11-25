import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Remove
 */
@WebServlet("/Remove")
public class Remove extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Remove() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		if(session.getAttribute("loggedIn")!=null) {
			int userID = (int)session.getAttribute("userID");
			String isbn = request.getParameter("isbn_");
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				conn = DriverManager.getConnection("jdbc:mysql://google/");
				ps = conn.prepareStatement("DELETE FROM Favorite WHERE userID=? AND isbn=?");
				ps.setInt(1, userID);
				ps.setString(2, isbn);
				ps.executeUpdate();
				
			} catch (SQLException sqle) {
				System.out.println("sqle: " + sqle.getMessage());
			} finally {
				try {
					if (rs!= null) {
						rs.close();
					}
					if (ps!= null) {
						ps.close();
					}
					if (conn!= null) {
						conn.close();
					}
				} catch (SQLException sqle) {
					System.out.println("sqle closing stuff: " + sqle.getMessage());
				}
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
