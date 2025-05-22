<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="header.css">
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0PX;
        }
        
        .wrapper-main {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #333;
        }

        .form {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            text-align: left;
            padding: 10px;
        }

        th h2 {
            margin: 0;
            font-size: 1.1em;
            color: #555;
        }

        input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            color: #333;
        }

        input[disabled] {
            background-color: #e9ecef;
        }

        @media (max-width: 600px) {
            .wrapper-main {
                padding: 10px;
            }

            input[type="text"] {
                width: 100%;
            }
        }
        .up {
        	color:black;
        	background-color:green;
        	padding:10px;
        	border-radius:5px;
        }
        .dl{
        	color:black;
        	background-color:red;
        	padding:10px;
        	border-radius:5px;
        }
    </style>
</head>
<body class="bodyy">
<%@ include file="header.jsp" %>
<div class="wrapper-main">
    
    <%
        // Retrieve user attributes from the request
        String username = (String) request.getAttribute("username");
        String name = (String) request.getAttribute("name");
        String address = (String) request.getAttribute("address");
        String dob = (String) request.getAttribute("dob");
        String gender = (String) request.getAttribute("gender");
        String email = (String) request.getAttribute("email");
        String phone = (String) request.getAttribute("phone");

        // Check if username is null to avoid NullPointerException
        
    %>    <div class="form">
        <div style="text-align: center;">
            <h1>Hello, <%= username %></h1>
            
            <table>
                <tr>
                    <th><h2>Full Name:</h2></th>
                    <th><input type="text" value="<%= name != null ? name : "Not provided" %>" disabled></th>
                </tr>
                <tr>
                    <th><h2>User Name:</h2></th>
                    <th><input type="text" value="<%= username %>" disabled></th>
                </tr>
                <tr>
                    <th><h2>Address:</h2></th>
                    <th><input type="text" value="<%= address != null ? address : "Not provided" %>" disabled></th>
                </tr>
                <tr>
                    <th><h2>Date Of Birth:</h2></th>
                    <th><input type="text" value="<%= dob != null ? dob : "Not provided" %>" disabled></th>
                </tr>
                <tr>
                    <th><h2>Gender:</h2></th>
                    <th><input type="text" value="<%= gender != null ? gender : "Not provided" %>" disabled></th>
                </tr>
                <tr>
                    <th><h2>Email:</h2></th>
                    <th><input type="text" value="<%= email != null ? email : "Not provided" %>" disabled></th>
                </tr>
                <tr>
                    <th><h2>Tel-Phone Number:</h2></th>
                    <th><input type="text" value="<%= phone != null ? phone : "Not provided" %>" disabled></th>
                </tr>
                <tr>
                	<th><a href="beforeupdateuser?profile=<%= username %>"class="up">Update</a>
                	</th>
                	<th><a href="deleteuser?profile=<%= username %>"class="dl">Delete</a>                	</th>
                	
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
