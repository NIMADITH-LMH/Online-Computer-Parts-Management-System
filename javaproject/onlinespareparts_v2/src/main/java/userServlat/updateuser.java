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
 * Servlet implementation class updateuser
 */
public class updateuser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updateuser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		String username = request.getParameter("username");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Check for null or empty username
        if ("Guest".equals(username)) {
            request.setAttribute("error", "Username is missing.");
            request.getRequestDispatcher("/home.jsp").forward(request, response);
            return;
        }

       
        String updateQuery = "UPDATE user SET name=?, address=?, dob=?, gender=?, email=?, phone=? WHERE username=?;";
    
        try (Connection con = ConnectionFactory.getConnection();PreparedStatement ps = con.prepareStatement(updateQuery)) {
          
            
                ps.setString(1, name);
                ps.setString(2, address);
                ps.setString(3, dob);
                ps.setString(4, gender);
                ps.setString(5, email);
                ps.setString(6, phone);
                ps.setString(7, username);

                int rowsUpdated = ps.executeUpdate(); // Use executeUpdate for an update query
                if (rowsUpdated > 0) {
                    // Update successful
                	request.setAttribute("username",username);
                    request.setAttribute("name", name);
                    request.setAttribute("address", address);
                    request.setAttribute("dob", dob);
                    request.setAttribute("gender", gender);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.getRequestDispatcher("/profile.jsp").forward(request, response);
                } else {
                    // User not found
                    
                    
                    request.getRequestDispatcher("/home.jsp").forward(request, response);
                }
            } catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (ClassNotFoundException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
        } 
		
        

}
