<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #333;
            color: #fff;
            padding: 15px 20px;
            text-align: center;
        }

        .header h1 {
            margin: 0;
        }

        .nav {
            background-color: #444;
            overflow: hidden;
        }

        .nav a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }

        .nav a:hover {
            background-color: #ddd;
            color: black;
        }

        .container {
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            width: 400px;
        }

        .form-container input[type="text"],
        .form-container input[type="email"],
        .form-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-container input[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
        }

        .form-container input[type="submit"]:hover {
            background-color: #218838;
        }

        .admin-forms {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .admin-forms .form-container {
            flex: 1;
            margin: 10px;
        }

        .footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px;
            position: absolute;
            width: 100%;
            bottom: -1000;
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
    
<title>Delete Customers or sellers - Computer Spare Parts Management System</title>
</head>
<body>

	<%@ include file="header.jsp" %>
	
	  <!-- Delete Customer Form -->
            <div class="form-container">
                <h3>Delete Customer</h3>
                <form action="DeleteCustomer" method="post">
                    <input type="hidden" name="action" value="deleteCustomer" />
                    <label for="customerId">Customer UserName:</label>
                    <input type="text" id="customerusername" name="username" required />
                    <input type="submit" value="Delete Customer" />
                </form>
            </div>

            <!-- Delete Seller Form -->
            <div class="form-container">
                <h3>Delete Seller</h3>
                <form action="DeleteCustomer" method="post">
                    <input type="hidden" name="action" value="deleteSeller" />
                    <label for="username">Seller UserName:</label>
                    <input type="text" id="username" name="username" required />
                    <input type="submit" value="Delete Seller" />
                </form>
            </div>
            
            <div class="footer">
        <p>&copy; 2024 Computer Spare Parts Management System</p>
    </div>
    
</body>
</html>