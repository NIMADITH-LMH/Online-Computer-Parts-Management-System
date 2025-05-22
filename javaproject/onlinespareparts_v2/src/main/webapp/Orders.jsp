<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%@ page import="orderproduct.OrdersProduct.Orderrs" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
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
        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            margin-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
            color: #555;
            font-weight: bold;
            font-size: 18px;
        }
        .product-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .product-container:last-child {
            border-bottom: none;
        }
        .product-image img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }
        .product-info {
            flex: 1;
            padding-left: 20px;
            color: #333;
        }
        .product-info h2 {
            margin: 0;
            font-size: 22px;
            font-weight: 600;
        }        .price-section {
            font-size: 22px;
            font-weight: bold;
            color: #ff4d4f;
        }
        .status-section {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: bold;
            color: #2c7be5;
            text-transform: capitalize;
        }
        .actions {
            text-align: right;
        }
        .actions a {
            padding: 10px 15px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .actions a:hover {
            background-color: #c82333;
        }
        .checkout-section {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 20px;
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
        }
        .checkout-btn:hover {
            background-color: #218838;
        }
        .empty-cart {
            text-align: center;
            font-size: 22px;
            color: #888;
            margin: 50px 0;
        }
        .order-summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .order-summary h3 {
            margin-top: 0;
            font-size: 24px;
            font-weight: 600;
        }
        .order-summary p {
            margin: 10px 0;
            font-size: 18px;
        }
        .order-summary p span {
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<%@ include file="header.jsp" %>
<body>
    <div class="container">
        <h1>Order Products</h1>
        <form action="order" method="post">            <div class="cart-header">
                <span>Product</span>
                <span>Price</span>
                <span>Status</span>
                <span>Action</span>
            </div>
            
            <%
                ArrayList<Orderrs> products = (ArrayList<Orderrs>) request.getAttribute("productList");
                if (products != null && !products.isEmpty()) {
                    for (Orderrs product : products) {
            %>
            <div class="product-container">                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/image/<%= product.getImage() %>" 
                         onerror="this.onerror=''; this.src='${pageContext.request.contextPath}/image/76245.PNG';" 
                         alt="<%= product.getPname() %>">
                </div>
                <div class="product-info">
                    <h2><%= product.getPname() %></h2>
                </div>                <div class="price-section">
                    LKR <span><%= product.getPrice() %></span>
                </div>
                <div class="status-section">
                    <%= product.getStatus() != null ? product.getStatus() : "Pending" %>
                </div>
                <div class="actions">
                    <a href="DeleteOrders?id=<%= product.getProductid() %>&username=<%= Username %>&quantity=<%=product.getQuantity() %>" class="delete-btn">Remove</a>
                </div>
            </div>
            <%			
                    }
            %>
            
            <div class="order-summary">
                <h3>Order Summary</h3>
                <p>Total Products: <span><%= products.size() %></span></p>
               
            </div>
            
            <div class="checkout-section">
                
                <a href="card?id=<%=  Username%>" class="checkout-btn">Card details</a>
            </div>

            <%
                } else {
            %>
            <div class="empty-cart">Your cart is empty.</div>
            <div class="checkout-section">
                
                <a href="card?id=<%=  Username%>" class="checkout-btn">Card details</a>
            </div>
            <%
                }
            %>
        </form>
    </div>
</body>
</html>
