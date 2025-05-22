<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Online Spare Parts Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .header {
            background-color: #2c3e50;
            padding: 15px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        nav ul {
            display: flex;
            justify-content: center;
            list-style: none;
            margin: 0;
            padding: 0;
        }
        
        nav li {
            margin: 0 15px;
        }
        
        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        
        nav a:hover {
            background-color: rgba(255,255,255,0.1);
        }
        
        h1 {
            text-align: center;
            color: #2c3e50;
            margin: 30px 0;
            font-weight: 700;
        }
        
        .container {
            display: flex;
            max-width: 800px;
            margin: 20px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .image {
            flex: 1;
            background-color: #2c3e50;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .logo5 {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
        }
        
        .login {
            flex: 1;
            padding: 40px;
        }
        
        .form {
            margin-bottom: 20px;
        }
        
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        
        input[type="submit"] {
            width: 100%;
            background-color: #e74c3c;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            margin-top: 10px;
            transition: background-color 0.3s;
        }
        
        input[type="submit"]:hover {
            background-color: #c0392b;
        }
        
        .register {
            display: inline-block;
            margin-top: 15px;
            color: #2c3e50;
            text-decoration: none;
            font-weight: 500;
        }
        
        .register:hover {
            text-decoration: underline;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 10px;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 14px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <div class="header">
        <nav>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="#">Contact</a></li>
            </ul>
        </nav>
    </div>
    
    <h1>Welcome to Online Spare Parts Store</h1>
    
    <div class="container">
        <div class="image">
    <img src="${pageContext.request.contextPath}/onlinespareparts_v2/img/logo.jpg" class="logo5" alt="Logo">
        </div>
        <div class="login">
            <div class="form">
                <form action="loginuser" method="post">
                    <input type="text" id="username" name="username" placeholder="Username" required><br>
                    <input type="password" id="password" name="password" placeholder="Password" required><br>
                    
                    <input type="submit" value="Login"><br>
                    
                    <p>Don't have an account? <a href="register.jsp" class="register">Create Account</a></p>
                </form>
            </div>
            <div class="error-message">
                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; <%= Calendar.getInstance().get(Calendar.YEAR) %> Online Spare Parts Store. All rights reserved.</p>
    </footer>
</body>
</html>
