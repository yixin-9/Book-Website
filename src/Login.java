import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean invalid = false;
		HttpSession session = request.getSession(true);
		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			if(!invalid) {
				
				// connect to database
				conn = DriverManager.getConnection("jdbc:mysql://google/");
				ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
				ps.setString(1, username);
				rs = ps.executeQuery();
				
				if(rs.next() == false) {
					session.setAttribute("username_error_Login", "This user does not exist.");
					invalid = true;
					System.out.println("User does not exist.");
					
				}else {
					String passwordInput = rs.getString("password");
					if(passwordInput.equals(password)) {
						// login successful
						ps = conn.prepareStatement("SELECT userID FROM User WHERE username=?");
						ps.setString(1, username);
						rs = ps.executeQuery();
						int userID=-1;
						while(rs.next()) {
							userID = rs.getInt("userID");
						}
						
						boolean loggedIn = true;
						if(userID==-1) {
							System.out.println("Error: Failed to get userID");
						}else {
							session.setAttribute("userID", userID);
						}
						session.setAttribute("loggedIn", loggedIn);
						session.setAttribute("loggedInUser", username);
						RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/HomePage.jsp");
						dispatch.forward(request, response);
						
					}else {
						session.setAttribute("password_error_Login", "Incorrect password.");
						invalid = true;
					}
				}
				
				RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/login.jsp");
				dispatch.forward(request, response);
				
			}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		finally {
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
				System.out.println(sqle.getMessage());
			}
		}
	}

}
