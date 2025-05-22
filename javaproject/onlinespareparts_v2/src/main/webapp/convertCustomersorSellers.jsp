<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Convert Customers or Sellers - Computer Spare Parts Management System</title>
	
	    <style>        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .header {
            background-color: #2c3e50;
            color: #fff;
            padding: 15px 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .header h1 {
            margin: 0;
            font-weight: 500;
        }

        .nav {
            background-color: #34495e;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .nav a:hover {
            background-color: #3498db;
            color: white;
        }

        .container {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        h2 {
            color: #2c3e50;
            font-weight: 500;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }

        .form-container {
            background-color: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            width: 400px;
            transition: transform 0.3s ease;
        }
        
        .form-container:hover {
            transform: translateY(-5px);
        }

        .form-container h3 {
            color: #2c3e50;
            margin-top: 0;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        .form-container p {
            color: #7f8c8d;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: inherit;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        
        .form-container input[type="text"]:focus,
        .form-container input[type="email"]:focus,
        .form-container input[type="password"]:focus {
            border-color: #3498db;
            outline: none;
        }

        .form-container input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 12px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .form-container input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .admin-forms {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            gap: 20px;
        }

        .admin-forms .form-container {
            flex: 0 0 calc(50% - 20px);
            min-width: 300px;
            margin: 10px 0;
        }

        .footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px;
            position: absolute;
            width: 100%;
            bottom: -300;
        }

        @media (max-width: 768px) {
            .admin-forms {
                flex-direction: column;
            }
            .form-container {
                width: 100%;
            }
        }
    </style>
</head>
<body>
	<%@ include file="header.jsp" %>
    
    <div class="container">
        <h2>Manage Users - Convert User Types</h2>
        
        <!-- Display success or error messages -->
        <% if (request.getAttribute("message") != null) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 15px; border-radius: 4px; border: 1px solid #c3e6cb;">
                <%= request.getAttribute("message") %>
            </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
            <div style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 15px; border-radius: 4px; border: 1px solid #f5c6cb;">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <!-- Display URL parameters as well -->
        <% if (request.getParameter("success") != null) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 10px; margin-bottom: 15px; border-radius: 4px; border: 1px solid #c3e6cb;">
                <%= request.getParameter("success") %>
            </div>
        <% } %>
        
        <% if (request.getParameter("error") != null) { %>
            <div style="background-color: #f8d7da; color: #721c24; padding: 10px; margin-bottom: 15px; border-radius: 4px; border: 1px solid #f5c6cb;">
                <%= request.getParameter("error") %>
            </div>
        <% } %>
        
        <div class="admin-forms">
          <!-- Convert Customer to Seller Form -->
            <div class="form-container">
                <h3>Convert Customer to Seller</h3>
                <p>Upgrade a customer account to a seller account with selling privileges.</p>
                <form action="UpdateCustomerType" method="get">
                    <label for="customerToSellerId">Customer Username:</label>
                    <input type="text" id="customerToSellerId" name="username" required placeholder="Enter username" />
                    <input type="hidden" name="type" value="seller">
                    <input type="submit" value="Convert to Seller" />
                </form>
            </div>

            <!-- Convert Seller to Customer Form -->
            <div class="form-container">
                <h3>Convert Seller to Customer</h3>
                <p>Convert a seller account to a regular customer account.</p>
                <form action="UpdateCustomerType" method="get">
                    <label for="sellerToCustomerId">Seller Username:</label>
                    <input type="text" id="sellerToCustomerId" name="username" required placeholder="Enter username" />
                    <input type="hidden" name="type" value="user">
                    <input type="submit" value="Convert to Customer" />
                </form>
            </div>
        </div>
    </div>
    
     <div class="footer">
        <p>&copy; 2024 Computer Spare Parts Management System</p>
    </div>
    
</body>
</html>