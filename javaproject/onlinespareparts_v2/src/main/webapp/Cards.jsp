<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="orderproduct.Ordertojava" %>
<%@ page import="orderproduct.card" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Information</title>
<style>
    :root {
        --primary-color: #28a745;
        --primary-color-dark: #218838;
        --danger-color: #dc3545;
        --danger-color-dark: #c82333;
        --text-color: #333;
        --border-color: #e0e0e0;
        --background-color: #f5f5f5;
    }

    body {
        font-family: 'Arial', sans-serif;
        background-color: var(--background-color);
        margin: 0;
        padding: 0;
    }

    .container {
        width: 90%;
        margin: 50px auto;
        padding: 20px;
        max-width: 800px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h1 {
        font-size: 28px;
        margin-bottom: 20px;
        color: var(--text-color);
        text-align: center;
    }

    .form-section {
        margin-top: 20px;
    }

    .form-section h3 {
        font-size: 20px;
        margin-bottom: 15px;
        color: var(--text-color);
    }

    input[type="text"], input[type="number"], select {
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }

    input[type="text"]:disabled, input[type="number"]:disabled {
        background-color: var(--background-color);
    }

    .checkout-btn, .delete-btn {
        color: white;
        padding: 15px;
        border: none;
        border-radius: 5px;
        font-size: 18px;
        cursor: pointer;
        width: 100%;
        transition: background-color 0.3s ease;
        margin-top: 15px;
    }

    .checkout-btn {
        background-color: var(--primary-color);
    }

    .checkout-btn:hover {
        background-color: var(--primary-color-dark);
    }

    .delete-btn {
        background-color: var(--danger-color);
    }

    .delete-btn:hover {
        background-color: var(--danger-color-dark);
    }

    .empty-cart {
        text-align: center;
        font-size: 22px;
        color: #888;
        margin: 50px 0;
    }

</style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1>Payment Information</h1>
    <%	
        ArrayList<Ordertojava> products = (ArrayList<Ordertojava>) request.getAttribute("cards");
        if (products != null && !products.isEmpty()) {
            for (Ordertojava product : products) {
    %>

    <div class="form-section">
        <form action="BeforeCardUpdate" method="post">
            <h3>Card Details</h3>
            <div>
                <label for="username">Username</label>
                <input type="text" value="<%= product.getUsername() %>" disabled>
                <input type="text" name="username" value="<%= product.getUsername() %>" hidden="hidden">
            </div>
            <div>
                <label for="address">Card Owner Name</label>
                <input type="text" value="<%= product.getCname() %>" disabled>
                <input type="text" name="cname" value="<%= product.getCname() %>" hidden="hidden">
            </div>
            <div>
                <label for="cvv">CVV</label>
                <input type="text" value="<%= product.getCvv() %>" disabled>
                <input type="text" name="cvv" value="<%= product.getCvv() %>" hidden="hidden">
            </div>
            <div>
                <label for="expdate">Card Expire month</label>
                <input type="text" value="<%= product.getExpmonth() %>" disabled>
                <input type="text" name="expdate" value="<%= product.getExpmonth() %>" hidden="hidden">
            </div>
            <div>
                <label for="expdate">Card Expire month</label>
                <input type="text" value="<%= product.getExpyear () %>" disabled>
                <input type="text" name="expdate" value="<%= product.getExpyear() %>" hidden="hidden">
            </div>
            <div>
                <label for="cnumber">Card Number</label>
                <input type="text" value="<%= product.getCardnumber() %>" disabled>
                <input type="text" name="cnumber" value="<%= product.getCardnumber() %>" hidden="hidden">
            </div>

            <div class="form-section">
                <button type="submit" class="checkout-btn">Update</button>
            </div>

            <div class="form-section">
                <a href="DeletePayment?id=<%= product.getUsername() %>" 
                    class="delete-btn"
                    onclick="return confirm('Are you sure you want to delete this card?');">Delete</a>
            </div>
        </form>
    </div>

    <%
            }
        } else {
    %>
    <div class="empty-cart">No card details available.</div>
    <% } %>
</div>

</body>
</html>
