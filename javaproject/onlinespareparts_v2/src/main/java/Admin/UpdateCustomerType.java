package Admin;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class UpdateCustomerType
 */
public class UpdateCustomerType extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCustomerType() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
        String newType = request.getParameter("type");
        String returnUrl = request.getParameter("returnUrl");
        
        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is missing.");
            handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
            return;
        }
        
        if (newType == null || (!newType.equals("user") && !newType.equals("seller"))) {
            request.setAttribute("error", "Invalid user type specified.");
            handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
            return;
        }
        
        // Expected current type is opposite of what we're changing to
        String expectedCurrentType = newType.equals("user") ? "seller" : "user";
        
        try (Connection con = ConnectionFactory.getConnection()) {
            // First check if the user exists with the expected current type
            String checkQuery = "SELECT * FROM user WHERE username = ?";
            try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
                checkStmt.setString(1, username);
                
                // Import java.sql.ResultSet at the top of the file
                java.sql.ResultSet rs = null;
                try {
                    rs = checkStmt.executeQuery();
                    if (!rs.next()) {
                        // User not found
                        request.setAttribute("error", "User not found with username: " + username);
                        handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
                        return;
                    }
                    
                    String currentType = rs.getString("type");
                    if (currentType.equals(newType)) {
                        // User already has the requested type
                        String message = "User " + username + " is already a " + (newType.equals("user") ? "customer" : "seller") + ".";
                        request.setAttribute("message", message);
                        handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
                        return;
                    }
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                }
            }
            
            // Update the user type
            String updateQuery = "UPDATE user SET type=? WHERE username=?";
            try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
                ps.setString(1, newType);
                ps.setString(2, username);
               
                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated > 0) {
                    // Success
                    String successMsg = "";
                    if (newType.equals("seller")) {
                        successMsg = "Customer " + username + " was successfully converted to a seller.";
                    } else {
                        successMsg = "Seller " + username + " was successfully converted to a customer.";
                    }
                    request.setAttribute("message", successMsg);
                    handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
                } else {
                    // Update failed
                    request.setAttribute("error", "Failed to update user type. Please try again.");
                    handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
            request.setAttribute("error", "Database connection error: " + e1.getMessage());
            handleRedirect(request, response, returnUrl, "/convertCustomersorSellers.jsp");
        }
	}
	
	/**
     * Helper method to handle redirects based on returnUrl parameter
     */
    private void handleRedirect(HttpServletRequest request, HttpServletResponse response, String returnUrl, String defaultPath) 
            throws ServletException, IOException {
        if ("dashboard".equals(returnUrl)) {
            // Store messages in session for redirect
            if (request.getAttribute("message") != null) {
                request.getSession().setAttribute("message", request.getAttribute("message"));
            }
            if (request.getAttribute("error") != null) {
                request.getSession().setAttribute("error", request.getAttribute("error"));
            }
            response.sendRedirect("selectUser");
        } else {
            request.getRequestDispatcher(defaultPath).forward(request, response);
        }
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Pass all post requests to doGet method for consistent handling
		doGet(request, response);
	}

}
