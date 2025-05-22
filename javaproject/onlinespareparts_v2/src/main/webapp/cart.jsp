<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
    // Retrieve product attributes from the request
    int idproduct = (Integer) request.getAttribute("idproduct");
    String name = (String) request.getAttribute("name");
    double price = (Double) request.getAttribute("price");
    String description = (String) request.getAttribute("description");
    String image = (String) request.getAttribute("image");
%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= name %> - Product Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            margin: auto;
            padding: 20px;
            max-width: 1200px;
        }
        .product-container {
            display: flex;
            flex-wrap: wrap;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            overflow: hidden;
        }
        .product-image {
            flex: 1 1 50%;
            padding: 20px;
            box-sizing: border-box;
        }
        .product-image img {
            width: 100%;
            height: auto;
            border-radius: 8px;
        }
        .product-info {
            flex: 1 1 50%;
            padding: 20px;
            box-sizing: border-box;
        }
        h1 {
            font-size: 28px;
            margin-bottom: 10px;
        }
        .price {
            color: #ff4d4f;
            font-size: 24px;
            margin-bottom: 10px;
        }
        .description {
            font-size: 16px;
            margin: 20px 0;
        }
        .quantity-section {
            margin-bottom: 20px;
        }
        input[type="number"] {
            width: 50px;
            padding: 5px;
            font-size: 16px;
            margin-left: 10px;
        }
        .total-amount {
            font-size: 20px;
            font-weight: bold;
            margin-top: 10px;
        }
        .add-to-cart-btn {
            background-color: #ff6a00;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        .add-to-cart-btn:hover {
            background-color: #ff5400;
        }
    </style>
</head>
<body>
	<%@ include file="header.jsp" %>

    <div class="container">
        <div class="product-container">
            <div class="product-image">
                <img src="${pageContext.request.contextPath}/image/<%= image %>" alt="<%= name %>">
            </div>
            <div class="product-info">
                <h1><%= name %></h1>
                <div class="price-section">
                    <span class="price">LKR <%= price %></span>
                </div>
                <p class="description"><strong>Features:</strong> <%= description %></p>

                <div class="quantity-section">
                    <strong>Quantity:</strong>
                    <input type="number" id="quantity" value="1" min="1" max="10" onchange="updateTotalAmount()">
                </div>

                <div class="total-amount">
                    <strong>Total Amount: Rs. </strong><span id="totalAmount"><%= price %></span>
                </div>

                <form action="AddToCartServlat" method="post">
                    <input type="hidden" name="productId" value="<%= idproduct %>">
                    <input type="hidden" name="productName" value="<%= name %>">
                    <input type="hidden" name="description" value="<%= description %>">
  					<input type="hidden" name="image" value="<%= image %>">
                    <input type="hidden" name="username" value="<%= Username %>">
                    <input type="hidden" name="quantity" id="formQuantity" value="1">
                    <input type="hidden" name="totalAmount" id="formTotalAmount" value="<%= price %>">
                    <button type="submit" class="add-to-cart-btn" onclick="updateFormValues()">Add to Cart</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        const price = <%= price %>; // Product price from the backend

        // Function to update the total amount based on quantity
        function updateTotalAmount() {
            const quantity = document.getElementById('quantity').value;
            const totalAmount = price * quantity;
            document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
        }

        // Update the form values before submitting
        function updateFormValues() {
            const quantity = document.getElementById('quantity').value;
            const totalAmount = price * quantity;

            document.getElementById('formQuantity').value = quantity;
            document.getElementById('formTotalAmount').value = totalAmount.toFixed(2);
        }
    </script>
</body>
</html>
