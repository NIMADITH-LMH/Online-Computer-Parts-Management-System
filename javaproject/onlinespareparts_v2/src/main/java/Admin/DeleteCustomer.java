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
 * Servlet implementation class DeleteCustomer
 */
public class DeleteCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCustomer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle direct GET requests for user deletion (from admin dashboard links)
        String username = request.getParameter("username");
        String action = request.getParameter("action");
        
        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is missing.");
            request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
            return;
        }
        
        String userType = (action != null && action.equals("deleteSeller")) ? "seller" : "user";
        
        deleteUser(username, userType, request, response);
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String action = request.getParameter("action");
        String userType = (action != null && action.equals("deleteSeller")) ? "seller" : "user";
        String returnUrl = request.getParameter("returnUrl");
        
        if (username == null || username.isEmpty()) {
            request.setAttribute("error", "Username is missing.");
            request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
            return;
        }
        
        deleteUser(username, userType, request, response);
    }
    
    // Helper method for user deletion logic
    private void deleteUser(String username, String userType, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String returnUrl = request.getParameter("returnUrl");
        
        try (Connection con = ConnectionFactory.getConnection()) {
            // Import java.sql.ResultSet at the top of the file
            java.sql.ResultSet rs = null;
            
            // First check if the user exists with the specified type
            String checkQuery = "SELECT * FROM user WHERE username = ? AND type = ?";
            try (PreparedStatement checkStmt = con.prepareStatement(checkQuery)) {
                checkStmt.setString(1, username);
                checkStmt.setString(2, userType);
                
                rs = checkStmt.executeQuery();
                if (!rs.next()) {
                    // User not found or type doesn't match
                    request.setAttribute("error", "User not found with username: " + username + " and type: " + userType);
                    
                    // Determine where to redirect based on returnUrl parameter
                    if ("dashboard".equals(returnUrl)) {
                        response.sendRedirect("selectUser");
                    } else {
                        request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
                    }
                    return;
                }
            } finally {
                if (rs != null) {
                    rs.close();
                }
            }

            // Check for related records in other tables
            // For simplicity, we're just deleting the user
            // In a production system, you'd want to handle foreign key constraints
            
            // Delete user
            String deleteQuery = "DELETE FROM user WHERE username = ? AND type = ?";
            try (PreparedStatement ps = con.prepareStatement(deleteQuery)) {
                ps.setString(1, username);
                ps.setString(2, userType);
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    // Record deleted successfully
                    String successMsg = (userType.equals("seller")) ? 
                        "Seller with username " + username + " was deleted successfully." : 
                        "Customer with username " + username + " was deleted successfully.";
                    
                    if ("dashboard".equals(returnUrl)) {
                        request.getSession().setAttribute("message", successMsg);
                        response.sendRedirect("selectUser");
                    } else {
                        request.setAttribute("message", successMsg);
                        request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
                    }
                } else {
                    // Delete failed
                    request.setAttribute("error", "Failed to delete user. Please try again.");
                    
                    if ("dashboard".equals(returnUrl)) {
                        response.sendRedirect("selectUser");
                    } else {
                        request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            
            if ("dashboard".equals(returnUrl)) {
                response.sendRedirect("selectUser");
            } else {
                request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e1) {
            e1.printStackTrace();
            request.setAttribute("error", "Database connection error: " + e1.getMessage());
            
            if ("dashboard".equals(returnUrl)) {
                response.sendRedirect("selectUser");
            } else {
                request.getRequestDispatcher("/deleteCustomersorSellers.jsp").forward(request, response);
            }
        }
	}

}
