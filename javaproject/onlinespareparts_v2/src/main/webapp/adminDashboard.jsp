<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Admin.selectUser.user" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: 50px auto;
            padding: 30px;
            max-width: 1200px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 36px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f8f9fa;
            color: #333;
        }
        .empty-cart {
            text-align: center;
            font-size: 22px;
            color: #888;
            margin: 50px 0;
        }
        .checkout-btn {
            background-color: #28a745;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .checkout-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<%@ include file="header.jsp" %>
<body>
    <div class="container">
        <h1>User Data</h1>
        <%
            ArrayList<user> users = (ArrayList<user>) request.getAttribute("userList");
            if (users != null && !users.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Name</th>
                    <th>Address</th>
                    <th>DOB</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Type</th>
                </tr>
            </thead>
            <tbody>
            <%
                for (user User : users) {
            %>
                <tr>
                    <td><%= User.getUsername() %></td>
                    <td><%= User.getName() %></td>
                    <td><%= User.getAddress() %></td>
                    <td><%= User.getDob() %></td>
                    <td><%= User.getGender() %></td>
                    <td><%= User.getEmail() %></td>
                    <td><%= User.getPhone() %></td>
                    <td><%= User.getType() %></td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <div class="checkout-section">
            <a href="card?id=<%= users.get(0).getUsername() %>" class="checkout-btn">Card Details</a>
        </div>

        <%
            } else {
        %>
        <div class="empty-cart">No users available.</div>
        <%
            }
        %>
    </div>
</body>
</html>
