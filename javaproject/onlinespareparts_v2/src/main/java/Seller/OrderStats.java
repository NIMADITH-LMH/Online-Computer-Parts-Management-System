package Seller;

import jakarta.servlet.ServletException;
// Removed WebServlet import
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import JDBCConnection.ConnectionFactory;

/**
 * Servlet implementation class OrderStats
 */
public class OrderStats extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrderStats() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the referrer URL to avoid redirect loops
        String referer = request.getHeader("referer");
        boolean isFromHome = referer != null && referer.contains("home.jsp");
        
        Map<String, Integer> orderStats = new HashMap<>();
        int totalOrders = 0;
        
        try (Connection connection = ConnectionFactory.getConnection()) {
            // First check if status column exists
            boolean statusExists = false;
            try {
                String checkColumnQuery = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'status'";
                PreparedStatement checkColumnStmt = connection.prepareStatement(checkColumnQuery);
                ResultSet columnResult = checkColumnStmt.executeQuery();
                statusExists = columnResult.next();
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            if (statusExists) {
                // Get count of orders by status
                String query = "SELECT COALESCE(status, 'Pending') as order_status, COUNT(*) as count FROM orders GROUP BY status";
                try (PreparedStatement stmt = connection.prepareStatement(query)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        String status = rs.getString("order_status");
                        int count = rs.getInt("count");
                        orderStats.put(status, count);
                        totalOrders += count;
                    }
                }
            } else {
                // Get total order count if status column doesn't exist
                String query = "SELECT COUNT(*) as count FROM orders";
                try (PreparedStatement stmt = connection.prepareStatement(query)) {
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        totalOrders = rs.getInt("count");
                        orderStats.put("Pending", totalOrders); // Assume all are pending
                    }
                }
            }            // Add total to stats
            orderStats.put("Total", totalOrders);
            
            // Send stats to JSP
            request.setAttribute("orderStats", orderStats);
            
            // Check if we should go to home page or if we're coming from it already
            if (isFromHome) {
                // We're already coming from home, so let's go to a safe destination
                request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
            } else {
                // Forward to home.jsp as default
                request.getRequestDispatcher("/homeservlat").forward(request, response);  
            }
            } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
