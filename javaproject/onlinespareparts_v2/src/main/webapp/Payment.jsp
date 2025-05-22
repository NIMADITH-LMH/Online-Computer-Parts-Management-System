<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="orderproduct.order" %>
<%@ page import="orderproduct.Ordertojava" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Shopping Cart</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
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
        table {
            width: 100%;
        }
        th, td {
            padding: 10px 15px;
            text-align: left;
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
            background-color: #f5f5f5;
        }
        .payment-section {
            margin-top: 30px;
            font-size: 20px;
        }
        .checkout-btn {
            background-color: #28a745;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s ease;
        }
        .checkout-btn:hover {
            background-color: #218838;
        }
        .form-section {
            margin-top: 20px;
        }
        .form-section h3 {
            font-size: 20px;
            margin-bottom: 15px;
            color: #333;
        }
        .empty-cart {
            text-align: center;
            font-size: 22px;
            color: #888;
            margin: 50px 0;
        }
        .form-section .half-width {
            width: 48%;
            display: inline-block;
        }
        .form-section .half-width:nth-child(odd) {
            margin-right: 4%;
        }
    </style>
</head>
<%@ include file="header.jsp" %>
<body>
    <div class="container">
        <h1>Payment Information</h1>
        
        <%	
            String address;
            String username;
            double totalAmount = 0;
            
            ArrayList<Ordertojava> products = (ArrayList<Ordertojava>) request.getAttribute("array");
            if (products != null && !products.isEmpty()) {
                for (Ordertojava product : products) {
                    totalAmount += product.getTotalAmount();
                    address = product.getAddress();
                    username = product.getUsername();
        %>
        
        <div class="form-section">
            <form action="payment" method="post">
                <h3>Order Details</h3>
                <div>
                    <label for="username">Username</label>
                    <input type="text" value="<%= Username %>" disabled>
					<input type="text" name="username" value="<%= Username %>" hidden="hidden">
                    
                </div>
                <div>
                    <label for="address">Address</label>
                    <input type="text"  value="<%= address %>" disabled>
                    <input type="text" name="address" value="<%= address %>" hidden="hidden">
                </div>
                <div>
                    <label for="totalAmount">Total Amount</label>
                    <input type="text"  value=" <%= totalAmount %>" disabled>
                    <input type="text" name="totalAmount" value=" <%= totalAmount %>" hidden="hidden">
                </div>

                <h3>Payment Details</h3>
                <div>
                    <label for="cardNumber">Card Number</label>
                    <input type="text" name="cardNumber" placeholder="Enter your card number" required pattern="[0-9]{16}" title="Eneter 16 digits number only">
                </div>
                <div>
                    <label for="cname">Cardholder Name</label>
                    <input type="text" name="cname" placeholder="Cardholder's full name" required>
                </div>
                <div class="half-width">
                    <label for="cvv">CVV</label>
                    <input type="text" name="cvv" placeholder="3-digit CVV" required pattern="[0-9]{3}" >
                </div>
                <div class="half-width">
                    <label for="expiry">Expiry Date</label>
                    <select name="month" required>
                        <option value="January">January(01)</option>
                        <option value="February">February(02)</option>
                        <option value="March">March(03)</option>
                        <option value="April">April(04)</option>
                        <option value="May">May(05)</option>
                        <option value="June">June(06)</option>
                        <option value="July">July(07)</option>
                        <option value="August">August(08)</option>
                        <option value="September">September(09)</option>
                        <option value="October">October(10)</option>
                        <option value="November">November(11)</option>
                        <option value="December">December(12)</option>
                    </select> 
                    <select name="year" required>
                        <option value="2024">2024</option>
                        <option value="2025">2025</option>
                        <option value="2026">2026</option>
                        <option value="2027">2027</option>
                        <option value="2028">2028</option>
                    </select>
                    <input type="radio" value="store" name="store">Do you need to store the Card details<br>
                </div>

                <div class="form-section">
                    <button type="submit" class="checkout-btn">Complete Payment</button>
                </div>
            </form>
        </div>

        <%
                }
            } else {
        %>
        <div class="empty-cart">Your Payment is empty.</div>
        <% } %>
    </div>
</body>
</html>


