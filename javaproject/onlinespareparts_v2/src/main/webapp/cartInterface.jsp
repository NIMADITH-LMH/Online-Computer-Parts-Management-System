<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="orderproduct.AddToCartServlat"%>
<%@ page import="orderproduct.AddtocartJava"%>
<%@ page import="java.util.HashSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 85%;
            margin: 50px auto;
            padding: 30px;
            max-width: 1200px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        h1 {
            font-size: 32px;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }
        .cart-header {
            display: flex;
            justify-content: space-between;
            padding-bottom: 15px;
            margin-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
            color: #555;
            font-weight: bold;
        }
        .product-container {
            display: flex;
            align-items: center;
            padding: 20px 0;
            border-bottom: 1px solid #e0e0e0;
        }
        .product-container:last-child {
            border-bottom: none;
        }
        .checkbox {
            flex: 0 0 5%;
        }
        .product-image {
            flex: 0 0 15%;
        }
        .product-image img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }
        .product-info {
            flex: 0 0 50%;
            padding-left: 20px;
        }
        .product-info h2 {
            margin: 0;
            font-size: 20px;
            color: #333;
        }
        .price-section {
            flex: 0 0 15%;
            color: #ff4d4f;
            font-size: 20px;
            font-weight: bold;
            text-align: right;
        }
        .actions {
            flex: 0 0 10%;
            text-align: right;
        }
        .actions a {
            display: inline-block;
            padding: 8px 15px;
            background-color: #dc3545;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }
        .actions a:hover {
            background-color: #c82333;
        }
        .footer {
            text-align: right;
            margin-top: 20px;
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
            font-size: 20px;
            color: #888;
            margin: 40px 0;
        }
    </style>
</head>
<%@ include file="header.jsp" %>
<body>
    <div class="container">
        <h1>Shopping Cart</h1>
        <form action="order" method="post">            <div class="cart-header">
                <span>Select</span>
                <span class="actions-wrapper">
                    <a href="OrdersProduct?username=<%=Username %>" class="delete-btn">Order Products</a>
                </span>
            </div>            
            <%
                @SuppressWarnings("unchecked")
                HashSet<AddtocartJava> products = (HashSet<AddtocartJava>) request.getAttribute("cart");
                int count = 0;
                if (products != null && !products.isEmpty()) {
                    for (AddtocartJava product : products) {
                        count++;
            %>
            <div class="product-container">
                <div class="checkbox">
                    <input type="checkbox" name="selectedProducts" value="<%= product.getID() %>" class="product-checkbox" data-price="<%= product.getTotalAmount() %>" onclick="calculateTotal()">
                </div>
                <div class="product-image">
                    <img src="${pageContext.request.contextPath}/image/<%= product.getImage() %>" alt="<%= product.getImage() %>">
                </div>
                <div class="product-info">
                    <h2><%= product.getDescription() %></h2>
                </div>
                <div class="price-section">
                    LKR <span class="product-price"><%= product.getTotalAmount() %></span>
                </div>
                <div class="actions">
                    <a href="DeleteCartServlat?id=<%= product.getID() %>&username=<%= Username %>" class="delete-btn">Remove</a>
                </div>
                <input type="hidden" name="idproduct" value="<%= product.getId() %>">
                <input type="hidden" name="cartid" value="<%= product.getID() %>">
                <input type="hidden" name="total" value="<%= product.getTotalAmount() %>">
                <input type="hidden" name="quantity" value="<%= product.getQuantity() %>">
                <input type="hidden" name="username" value="<%= Username %>">
                <input type="hidden" name="image" value="<%=product.getImage() %>" hidden="hidden">
                
            </div>
            <%
                    }
            %>
            <div class="footer">
                <p>Total Amount Rs.<b id="amount">0</b></p>
                
                
               
                <button type="submit" class="checkout-btn" disabled id="checkoutButton">Place Order</button>
            </div>
            <%
                } else {
            %>
            <div class="empty-cart">Your cart is empty.</div>
            <%
                }
            %>
        </form>
    </div>

    <script>
    function calculateTotal() {
        var checkboxes = document.querySelectorAll('.product-checkbox');
        var total = 0;
        var selectedCount = 0;
        
        checkboxes.forEach(function(checkbox) {
            if (checkbox.checked) {
                total += parseFloat(checkbox.getAttribute('data-price'));
                selectedCount++;
            }
        });
        
        document.getElementById('amount').innerText = total.toFixed(2);
        document.getElementById('checkoutButton').disabled = selectedCount === 0;
    }
    </script>
</body>
</html>
