package userServlat;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
// Removed DriverManager import
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import JDBCConnection.ConnectionFactory;
/**
 * Servlet implementation class beforeupdateuser
 */
public class beforeupdateuser extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public beforeupdateuser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String username = request.getParameter("profile");

		// Check for null or empty username
		if (username == null || username.isEmpty()) {
			request.setAttribute("error", "Username is missing.");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
			return;
		}

		
		

		// Connect to the database and execute the query
		String selectQuery = "SELECT username, name, address, dob, gender, email, phone, password FROM user WHERE username = ?;";
		try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(selectQuery)) {
			
		
				ps.setString(1, username);
				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						// Retrieve user details
						String Username = rs.getString("username");
						String name = rs.getString("name");
						String address = rs.getString("address");
						String dob = rs.getString("dob");
						String gender = rs.getString("gender");
						String email = rs.getString("email");
						String phone = rs.getString("phone");

						// Set attributes and forward to profile page
						request.setAttribute("username", Username);
						request.setAttribute("name", name);
						request.setAttribute("address", address);
						request.setAttribute("dob", dob);
						request.setAttribute("gender", gender);
						request.setAttribute("email", email);
						request.setAttribute("phone", phone);

						request.getRequestDispatcher("/updateprofile.jsp").forward(request, response);
					} else {
						// User not found
						request.setAttribute("error", "Username not found. Please try again!");
						request.getRequestDispatcher("/home.jsp").forward(request, response);
					}
				}
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} 
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
