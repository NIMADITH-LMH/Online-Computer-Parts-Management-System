<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<%@ page import="JDBCConnection.ConnectionFactory" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Management Debug</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            line-height: 1.6;
        }
        h1 {
            color: #333;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }
        .section {
            margin: 20px 0;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        h2 {
            color: #444;
            margin-top: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .success {
            color: green;
            font-weight: bold;
        }
        .error {
            color: red;
            font-weight: bold;
        }
        .info {
            color: blue;
        }
        .debug-info {
            background-color: #f8f9fa;
            padding: 10px;
            border-left: 4px solid #007bff;
            margin: 10px 0;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <h1>Order Management Debug</h1>

    <div class="section">
        <h2>Session Information</h2>
        <table>
            <tr>
                <th>Attribute</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>username</td>
                <td><%= session.getAttribute("username") %></td>
            </tr>
            <tr>
                <td>type</td>
                <td><%= session.getAttribute("type") %></td>
            </tr>
            <tr>
                <td>Session ID</td>
                <td><%= session.getId() %></td>
            </tr>
            <tr>
                <td>Creation Time</td>
                <td><%= new java.util.Date(session.getCreationTime()) %></td>
            </tr>
            <tr>
                <td>Last Accessed</td>
                <td><%= new java.util.Date(session.getLastAccessedTime()) %></td>
            </tr>
        </table>
    </div>
    
    <div class="section">
        <h2>Database Check - Orders Table</h2>
        <% 
        try {
            Connection connection = ConnectionFactory.getConnection();
            
            // Check if status column exists
            boolean statusExists = false;
            try {
                String checkColumnQuery = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'status'";
                PreparedStatement checkColumnStmt = connection.prepareStatement(checkColumnQuery);
                ResultSet columnResult = checkColumnStmt.executeQuery();
                statusExists = columnResult.next();
            } catch (Exception e) {
                out.println("<p class='error'>Error checking status column: " + e.getMessage() + "</p>");
            }
            
            if (statusExists) {
                out.println("<p class='success'>Status column exists in orders table.</p>");
            } else {
                out.println("<p class='error'>Status column does NOT exist in orders table!</p>");
                out.println("<p>You may need to run the add_status_column.sql script</p>");
            }
            
            // Count orders
            String countQuery = "SELECT COUNT(*) AS count FROM orders";
            PreparedStatement countStmt = connection.prepareStatement(countQuery);
            ResultSet countResult = countStmt.executeQuery();
            if (countResult.next()) {
                int count = countResult.getInt("count");
                out.println("<p>Total orders in database: <strong>" + count + "</strong></p>");
            }
            
            // Sample of orders
            out.println("<h3>Sample Orders (up to 10)</h3>");
            String query;
            if (statusExists) {
                query = "SELECT productid, pname, username, status FROM orders ORDER BY productid DESC LIMIT 10";
            } else {
                query = "SELECT productid, pname, username FROM orders ORDER BY productid DESC LIMIT 10";
            }
            
            PreparedStatement stmt = connection.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            
            out.println("<table>");
            out.println("<tr><th>Product ID</th><th>Product Name</th><th>Username</th>");
            if (statusExists) out.println("<th>Status</th>");
            out.println("</tr>");
            
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("productid") + "</td>");
                out.println("<td>" + rs.getString("pname") + "</td>");
                out.println("<td>" + rs.getString("username") + "</td>");
                if (statusExists) {
                    String status = rs.getString("status");
                    out.println("<td>" + (status != null ? status : "Pending") + "</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
            
            connection.close();
        } catch (Exception e) {
            out.println("<p class='error'>Error connecting to database: " + e.getMessage() + "</p>");
            e.printStackTrace(new java.io.PrintWriter(out));
        }
        %>
    </div>
      <div class="section">
        <h2>Servlet Information</h2>
        <p><a href="<%= request.getContextPath() %>/OrdersDetails?username=<%= session.getAttribute("username") %>">Test OrdersDetails Servlet (with username parameter)</a></p>
        <p><a href="<%= request.getContextPath() %>/OrdersDetails">Test OrdersDetails Servlet (no parameters)</a></p>
        <p><a href="<%= request.getContextPath() %>/OrdersDetails?username=<%= session.getAttribute("username") %>">Test ordersdetails URL (with username)</a></p>
        <h3>Current Request</h3>
        <div class="debug-info">
            Request URL: <%= request.getRequestURL() %>?<%= request.getQueryString() != null ? request.getQueryString() : "" %><br>
            Context Path: <%= request.getContextPath() %><br>
            Servlet Path: <%= request.getServletPath() %>
        </div>
    </div>
    
    <div class="section">
        <h2>Back to Main Pages</h2>
        <p><a href="<%= request.getContextPath() %>/homeservlat">Go to Home Page</a></p>
        <p><a href="<%= request.getContextPath() %>/adminDashboard.jsp">Go to Admin Dashboard</a></p>
    </div>
</body>
</html>
