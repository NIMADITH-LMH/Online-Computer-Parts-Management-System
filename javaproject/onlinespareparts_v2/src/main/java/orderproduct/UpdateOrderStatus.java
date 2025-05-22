package orderproduct;

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
 * Servlet implementation class UpdateOrderStatus
 */
public class UpdateOrderStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateOrderStatus() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String status = request.getParameter("status");
        String username = request.getParameter("username");
        
        try (Connection connection = ConnectionFactory.getConnection()) {
            // First, check if the status column exists, if not, we need to add it
            // This would be handled during database setup, but we're being safe
            
            // Update the order status
            String updateQuery = "UPDATE orders SET status = ? WHERE productid = ? AND username = ?";
            try (PreparedStatement statement = connection.prepareStatement(updateQuery)) {
                statement.setString(1, status);
                statement.setInt(2, productId);
                statement.setString(3, username);
                
                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("failed");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
