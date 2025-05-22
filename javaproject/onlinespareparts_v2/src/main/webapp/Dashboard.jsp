<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.ArrayList" %>
<%@ page import="Seller.Dashboard.Product" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        a.add-product {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a.add-product:hover {
            background-color: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table th, table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        table th {
            background-color: #f8f9fa;
        }
        img {
            max-width: 100px;
            border-radius: 8px;
        }
        .actions a {
            display: inline-block;
            padding: 8px 12px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 5px;
        }
        .actions a.delete {
            background-color: #dc3545;
        }
        .actions a:hover {
            opacity: 0.8;
        }
        .no-products {
            text-align: center;
            color: #888;
            font-style: italic;
        }
    </style>
</head>
<body>
 <%@ include file="header.jsp" %>
    <div class="container">
       

        <h1>Seller Dashboard</h1>
        <a href="addproduct.jsp?id=<%= Username %>" class="add-product">+ Add Product</a>

        <table>
            <tr>
                <th>Image</th>
                <th>Details</th>
                <th>Actions</th>
            </tr>
            <%
                ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("productList");
                if (products != null && !products.isEmpty()) {
                    for (Product product : products) {
            %>
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}'/onlinespareparts_v2/img/logo.jpg'<%= product.getImage() %>" 
                         alt="Image of <%= product.getPname() %>">
                </td>
                <td>
                    <strong>Name:</strong> <%= product.getPname() %><br>
                    <strong>Type:</strong> <%= product.getProducttype() %><br>
                    <strong>Price:</strong> Rs.<%= product.getPrice() %><br>
                    <strong>Quantity:</strong> <%= product.getQuantity() %><br>
                    <strong>Description:</strong> <%= product.getDecription() %><br>
                </td>
                <td class="actions">
                    <a href="BeforeUpdateProduct?id=<%= product.getIdproduct() %>">Update</a>
                    <a href="DeleteProduct?id=<%= product.getIdproduct() %>" class="delete">Delete</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="3" class="no-products">No product details available.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>
</body>
</html>
