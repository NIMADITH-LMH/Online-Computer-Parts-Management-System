	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="homeServlat.productDetails.Product" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Details</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #2c3e50;
            margin: 30px 0;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .product-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
        }
        .product-image {
            height: 200px;
            background-color: #f9f9f9;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .placeholder-image {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #e0e0e0, #f5f5f5);
            color: #777;
            font-size: 1.2rem;
        }
        .product-details {
            padding: 15px;
        }
        .product-name {
            font-size: 1.2rem;
            font-weight: bold;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        .product-type {
            color: #7f8c8d;
            font-size: 0.9rem;
            margin-bottom: 5px;
        }
        .product-price {
            font-weight: bold;
            color: #e74c3c;
            margin: 10px 0;
            font-size: 1.1rem;
        }
        .product-description {
            color: #34495e;
            margin: 10px 0;
            font-size: 0.9rem;
        }
        .product-quantity {
            color: #27ae60;
            font-size: 0.9rem;
        }
        .shop-button {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
            transition: background-color 0.3s;
        }
        .shop-button:hover {
            background-color: #2980b9;
        }
        .no-products {
            text-align: center;
            padding: 50px;
            color: #7f8c8d;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <h2>Product Details</h2>
        
        <%
            @SuppressWarnings("unchecked")
            ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("productList");
            if (products != null && !products.isEmpty()) {
        %>
        <div class="product-grid">
            <% for (Product product : products) { %>
            <div class="product-card">
                <div class="product-image">
                    <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>                        <img src="${pageContext.request.contextPath}/image/<%= product.getImage() %>" 
                            onerror="this.parentNode.innerHTML='<div class=&quot;placeholder-image&quot;>Image Not Available</div>'"
                            alt="<%= product.getName() %>">
                    <% } else { %>
                        <div class="placeholder-image">No Image Available</div>
                    <% } %>
                </div>
                <div class="product-details">
                    <div class="product-name"><%= product.getName() %></div>
                    <div class="product-type"><%= product.getType() %></div>
                    <div class="product-price">Rs. <%= product.getPrice() %></div>
                    <div class="product-description"><%= product.getDescription() != null ? product.getDescription() : "No description available" %></div>
                    <div class="product-quantity">In Stock: <%= product.getQuantity() %></div>
                    <a href="cart?id=<%= product.getId() %>">
                        <button class="shop-button">Shop Now</button>
                    </a>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
            <div class="no-products">No products available for this category.</div>
        <% } %>
    </div>
</body>
</html>
