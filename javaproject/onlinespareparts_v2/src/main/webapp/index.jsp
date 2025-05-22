<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Spare Parts Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        
        .container {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            align-items: center;
            justify-content: center;
            padding: 20px;
            text-align: center;
            background-image: url('bg.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
        }
        
        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }
        
        .content {
            max-width: 800px;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin: 20px;
            position: relative;
            z-index: 2;
        }
        
        h1 {
            font-size: 2.5em;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        p {
            font-size: 1.1em;
            margin-bottom: 30px;
            line-height: 1.6;
            color: #34495e;
        }
        
        .buttons {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        
        .button {
            display: inline-block;
            padding: 15px 30px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: background-color 0.3s, transform 0.2s;
            font-size: 1.1em;
            border: none;
            cursor: pointer;
        }
        
        .button:hover {
            background-color: #3498db;
            transform: translateY(-3px);
        }
        
        .button.register {
            background-color: #e74c3c;
        }
        
        .button.register:hover {
            background-color: #c0392b;
        }
        
        .button.diagnostic {
            background-color: #2ecc71;
        }
        
        .button.diagnostic:hover {
            background-color: #27ae60;
        }
        
        .logo {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 5px solid white;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        
        @media (max-width: 768px) {
            .content {
                padding: 30px;
                margin: 10px;
            }
            h1 {
                font-size: 2em;
            }
            .buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="content">
            <img src="logo.jpg" alt="Logo" class="logo">
            <h1>Welcome to Online Spare Parts Store</h1>
            <p>Your one-stop shop for all computer spare parts and accessories. Find high-quality products at competitive prices with secure shopping and fast delivery options.</p>
            
            <div class="buttons">
                <a href="homeservlat" class="button">View Products</a>
                <a href="login.jsp" class="button">Login</a>
                <a href="register.jsp" class="button register">Register</a>
                <a href="direct.jsp" class="button diagnostic">Diagnostic Page</a>
            </div>
        </div>
    </div>
</body>
</html> 