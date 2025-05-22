<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="orderproduct.Ordertojava" %>

<%@ page import="orderproduct.card" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
        input[type="text"], input[type="date"], select {
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
            <form action="CardUpdate" method="post">
                <h3>Card Details</h3>
                <div>
                    <label for="username">Username</label>
                    <input type="text" value="<%= product.getUsername() %>" disabled>
					<input type="text" name="username" value="<%= product.getUsername() %>" hidden="hidden">
                    
                </div>
                <div>
                    <label for="address">Card Owner Name</label>
                   
                    <input type="text" name="cname" value="<%= product.getCname() %>" >
                </div>
                <div>
                    <label for="totalAmount">CVV</label>
                    
                    <input type="text" name="cvv" value=" <%= product.getCvv() %>" pattern="[0-9]{3}" title="Eneter 3 digits number only">
                </div>
                <div>
                    <label for="totalAmount">Card Expire Month</label>
                 
                    <input type="text" name="expmonth" value=" <%= product.getExpmonth() %>" >
                </div>
                 <div>
                    <label for="totalAmount">Card Expire Year</label>
                 
                    <input type="text" name="expyear" value=" <%= product.getExpyear() %>" >
                </div>
                 <div>
                    <label for="totalAmount">Card Number</label>
                    
                    <input type="text" name="cnumber" value=" <%= product.getCardnumber() %>" pattern="[0-9]{16}" title="Eneter 16 digits number only" >
                </div>

                
                

                <div class="form-section">
                    <button type="submit" class="checkout-btn">Update</button>
                    
                </div>
            </form>
        </div>

        <%
                }
            } else {
        %>
        <div class="empty-cart">No card Details 	.</div>
        <% } %>
    </div>

</body>
</html>