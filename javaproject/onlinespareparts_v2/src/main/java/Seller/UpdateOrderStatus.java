package Seller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
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
@WebServlet("/UpdateOrderStatus")
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
        String productId = request.getParameter("id");
        String username = request.getParameter("username");
        String status = request.getParameter("status");
        
        // Validate parameters
        if (productId == null || username == null || status == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Missing parameters");
            return;
        }
        
        // Validate status value (optional)
        status = status.toLowerCase();
        if (!status.equals("pending") && !status.equals("processing") && !status.equals("shipped") 
            && !status.equals("delivered") && !status.equals("cancelled")) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid status value");
            return;
        }
        
        try (Connection connection = ConnectionFactory.getConnection()) {
            // First check if the status column exists
            boolean statusColumnExists = false;
            try {
                String checkColumnQuery = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'status'";
                PreparedStatement checkColumnStmt = connection.prepareStatement(checkColumnQuery);
                statusColumnExists = checkColumnStmt.executeQuery().next();
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            if (!statusColumnExists) {
                // Add the status column if it doesn't exist
                try {
                    String addColumnQuery = "ALTER TABLE orders ADD COLUMN status VARCHAR(50) DEFAULT 'Pending'";
                    PreparedStatement addColumnStmt = connection.prepareStatement(addColumnQuery);
                    addColumnStmt.execute();
                } catch (Exception e) {
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("Could not add status column");
                    return;
                }
            }
            
            // Now update the order status
            String updateQuery = "UPDATE orders SET status = ? WHERE productid = ? AND username = ?";
            PreparedStatement stmt = connection.prepareStatement(updateQuery);
            stmt.setString(1, status);
            stmt.setInt(2, Integer.parseInt(productId));
            stmt.setString(3, username);
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Status updated successfully");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("Order not found");
            }
            
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid product ID format");
            e.printStackTrace();
        } catch (ClassNotFoundException | SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Database error");
            e.printStackTrace();
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
