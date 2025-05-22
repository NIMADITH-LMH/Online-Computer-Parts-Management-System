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
import java.sql.Statement;
import JDBCConnection.ConnectionFactory;
/**
 * Servlet implementation class registeruser
 */
public class registeruser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public registeruser() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String username = request.getParameter("username");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");
        String password = request.getParameter("password");
        String cpassword = request.getParameter("cpassword");

        if (!password.equals(cpassword)) {
            request.setAttribute("Error", "Passwords do not match!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

       
        String selectQuery="SELECT count(username) as numberof from user where username='username';";
        try (Connection con = ConnectionFactory.getConnection();Statement stat=con.createStatement();
	        	ResultSet rs=stat.executeQuery(selectQuery);) {
        	
        	
	        	
        	while(rs.next()) {
        		if(rs.getInt("numberof")>=1) {
        			request.setAttribute("error", "Registration failed, please try again.");
        		    request.getRequestDispatcher("/register.jsp").forward(request, response);
        		}
        		else {
        			   String insertQuery = "INSERT INTO user(username, name, address, dob, gender, email, phone, password) VALUES(?, ?, ?, ?, ?, ?, ?, ?);";
        	            try (PreparedStatement preparedStatement = con.prepareStatement(insertQuery)) {
        	                preparedStatement.setString(1, username);
        	                preparedStatement.setString(2, name);
        	                preparedStatement.setString(3, address);
        	                preparedStatement.setString(4, dob);
        	                preparedStatement.setString(5, gender);
        	                preparedStatement.setString(6, email);
        	                preparedStatement.setString(7, telephone);
        	                preparedStatement.setString(8, password);

        	                int rowsAffected = preparedStatement.executeUpdate();
        	                if (rowsAffected > 0) {
        	                    request.getSession().setAttribute("firstname", name);
        	                    request.getRequestDispatcher("/login.jsp").forward(request, response);
        	                }
        	                else {
        	                    request.setAttribute("error", "Registration failed, please try again.");
        	                    request.getRequestDispatcher("/register.jsp").forward(request, response);
        	                }
        	            }
        		}
        	}
         
        }catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

}
