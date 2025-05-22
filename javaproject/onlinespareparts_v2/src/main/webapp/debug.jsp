<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Basic Debug Page</title>
</head>
<body>
    <h1>Debug Page</h1>
    
    <p>This is a simple debug page to test servlet functionality.</p>
    
    <h2>Test Links:</h2>
    <ul>
        <li><a href="<%= request.getContextPath() %>/OrdersDetails?username=<%= session.getAttribute("username") %>">Test OrdersDetails Servlet</a></li>
        <li><a href="<%= request.getContextPath() %>/OrderDetails?username=<%= session.getAttribute("username") %>">Test OrderDetails Servlet</a></li>
        <li><a href="<%= request.getContextPath() %>/ordersdetails?username=<%= session.getAttribute("username") %>">Test lowercase ordersdetails</a></li>
    </ul>
    
    <h2>Session Info:</h2>
    <p>Username: <%= session.getAttribute("username") %></p>
    <p>User Type: <%= session.getAttribute("type") %></p>
    
    <p><a href="<%= request.getContextPath() %>/homeservlat">Return to Home</a></p>
</body>
</html>
