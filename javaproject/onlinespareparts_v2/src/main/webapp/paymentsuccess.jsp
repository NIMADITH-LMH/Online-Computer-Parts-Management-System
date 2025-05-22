<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Success</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f8ff;
        margin: 0;
        padding: 0;
    }
    .container {
        text-align: center;
        margin-top: 50px;
    }
    .success-icon {
        font-size: 100px;
        color: #28a745;
    }
    h1 {
        color: #333;
        font-size: 36px;
        margin: 20px 0;
    }
    .card, .backhome {
        display: inline-block;
        margin: 20px;
        padding: 15px 30px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 18px;
        transition: background-color 0.3s ease;
    }
    .card:hover, .backhome:hover {
        background-color: #0056b3;
    }
</style>
</head>
<%@ include file="header.jsp" %>
<body>
    <div class="container">
        <!-- Success Icon -->
        <div class="success-icon">✔</div>
        
        <!-- Success Message -->
        <h1>Payment Made Successfully!</h1>
        
        <!-- Options -->
        <a class="card" href="OrdersProduct?username=<%= Username%>">View order Details</a>
        <a class="backhome" href="home.jsp">Back to Home</a>
    </div>
</body>
</html>
