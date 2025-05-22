<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Direct Access Test - Online Spare Parts Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            color: #333;
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        
        h2 {
            color: #e74c3c;
            margin-top: 30px;
            font-size: 1.3em;
        }
        
        p {
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        ul {
            list-style-type: none;
            padding: 0;
        }
        
        li {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }
        
        li:before {
            content: "→";
            color: #3498db;
            font-weight: bold;
            margin-right: 10px;
        }
        
        a {
            color: #3498db;
            text-decoration: none;
            transition: color 0.3s;
            font-weight: 500;
        }
        
        a:hover {
            color: #2980b9;
            text-decoration: underline;
        }
        
        .status-box {
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 20px;
            margin-top: 20px;
        }
        
        .status-item {
            display: flex;
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }
        
        .status-label {
            font-weight: bold;
            width: 150px;
            color: #2c3e50;
        }
        
        .status-value {
            flex: 1;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        .back-link:hover {
            background-color: #3498db;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <h1>Direct Access Test Page</h1>
    <p>This is a test page to diagnose access issues with the Online Spare Parts Store application.</p>
    
    <h2>Try these links:</h2>
    <ul>
        <li><a href="index.jsp">Go to index.jsp</a></li>
        <li><a href="home.jsp">Go to home.jsp directly</a></li>
        <li><a href="homeservlat">Go to homeservlat</a></li>
        <li><a href="login.jsp">Go to login.jsp</a></li>
    </ul>
    
    <h2>Application Status:</h2>
    <div class="status-box">
        <div class="status-item">
            <div class="status-label">Context Path:</div>
            <div class="status-value"><%= request.getContextPath() %></div>
        </div>
        <div class="status-item">
            <div class="status-label">Servlet Path:</div>
            <div class="status-value"><%= request.getServletPath() %></div>
        </div>
        <div class="status-item">
            <div class="status-label">Request URI:</div>
            <div class="status-value"><%= request.getRequestURI() %></div>
        </div>
        <div class="status-item">
            <div class="status-label">Server Info:</div>
            <div class="status-value"><%= application.getServerInfo() %></div>
        </div>
    </div>
    
    <a href="index.jsp" class="back-link">Return to Homepage</a>
</body>
</html> 