<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="homeServlat.homeservlat.ProductData" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Spare Parts Store</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #333;
            color: white;
            padding: 15px 0;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        nav {
            display: flex;
            justify-content: center;
            background-color: #444;
            padding: 10px 0;
        }
        nav a {
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            transition: background-color 0.3s;
            border-radius: 5px;
        }
        nav a:hover {
            background-color: #555;
        }
        .carousel {
            position: relative;
            max-width: 100%;
            overflow: hidden;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        .slides {
            display: flex;
            transition: transform 0.5s ease;
        }
        .slide {
            min-width: 100%;
        }
        .slide img {
            width: 100%;
            height: auto;
            border-radius: 10px;
        }
        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }
        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin: 15px;
            width: calc(30% - 30px);
            transition: transform 0.3s, box-shadow 0.3s;
            text-align: center;
            overflow: hidden; /* Added to prevent overflow of content */
            position: relative; /* For pseudo-element effect */
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        }
        .card img {
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: transform 0.3s; /* Smooth image scale effect */
        }
        .card:hover img {
            transform: scale(1.1); /* Image scale effect on hover */
        }        .image-placeholder {
            height: 200px;
            background: linear-gradient(135deg, #e0e0e0, #f5f5f5);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #777;
            font-size: 1.2rem;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        /* Add background color to carousel to prevent empty space */
        .carousel, .slide {
            background-color: #f0f0f0;
            min-height: 300px;
        }
        .card h3 {
            margin: 10px 0;
        }
        .footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 15px 0;
            position: relative;
            bottom: 0;
            width: 100%;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.2);
        }
        .intro {
            text-align: center;
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #218838; /* Darker green on hover */
        }
        /* Admin Dashboard Styles */
        .admin-dashboard {
            margin: 20px auto;
            padding: 20px;
            max-width: 1200px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }
        .admin-dashboard h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3498db;
        }
        .admin-widgets {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: space-between;
        }
        .admin-widget {
            flex: 1;
            min-width: 250px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .admin-widget:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .admin-widget h3 {
            color: #2c3e50;
            margin-top: 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        .admin-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .admin-action {
            padding: 8px 12px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .admin-action:hover {
            background-color: #2980b9;
        }
        .message-icon {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #2f80ed;
            border-radius: 50%;
            padding: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            font-size: 24px;
            color: white;
            text-align: center;
            cursor: pointer;
        }
        .message-icon a {
            color: white;
            text-decoration: none;
        }
        .message-icon:hover {
            background-color: #1a60d1;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
      <div class="carousel">
        <div class="slides" id="slides">
            <div class="slide"><img src="${pageContext.request.contextPath}/onlinespareparts_v2/src/main/webapp/slid1.jpg" alt="Hero Image 1" onerror="this.src='${pageContext.request.contextPath}/onlinespareparts_v2/src/main/webapp/slid1.jpg'; this.onerror='';"></div>
            <div class="slide"><img src="${pageContext.request.contextPath}/onlinespareparts_v2/src/main/webapp/slid2.jpg" alt="Hero Image 2" onerror="this.src='${pageContext.request.contextPath}/onlinespareparts_v2/src/main/webapp/slid2.jpg'; this.onerror='';"></div>
            <div class="slide"><img src="${pageContext.request.contextPath}/onlinespareparts_v2/src/main/webapp/slid3.jpg"alt="Hero Image 2" onerror="this.src='${pageContext.request.contextPath}/onlinespareparts_v2/src/main/webapp/slid2.jpg'; this.onerror='';"></div>
        </div>
    </div>

    <div class="intro">
        <h2>Welcome to Our Online Spare Parts Store!</h2>
        <p>Your one-stop shop for all spare parts needs. We offer a wide range of products to suit your needs and ensure quality and affordability. Explore our latest products and enjoy exclusive deals!</p>
        <p>Looking for something specific? Use our search feature or browse our categories!</p>
        <button class="button" onclick="location.href='categories.jsp'">Browse Categories</button>
    </div>    <% 
    if ("admin".equals(session.getAttribute("type"))) { 
        // Show admin dashboard section, no conditional redirect
        // Order stats might be null initially, but we don't redirect to avoid loops
    %>
    <div class="admin-dashboard">
        <h2>Admin Dashboard</h2>
        <div class="admin-widgets">
            <div class="admin-widget">
                <h3>Users</h3>
                <p>Manage system users</p>
                <div class="admin-actions">
                    <a href="addCustomersorSellers.jsp" class="admin-action">Add User</a>
                    <a href="deleteCustomersorSellers.jsp" class="admin-action">Delete User</a>
                    <a href="convertCustomersorSellers.jsp" class="admin-action">Convert User</a>
                    <a href="selectUser" class="admin-action">View All Users</a>
                </div>
            </div>
            <div class="admin-widget">
                <h3>Products</h3>
                <p>Manage product inventory</p>
                <div class="admin-actions">
                    <a href="addproduct.jsp" class="admin-action">Add Product</a>
                    <a href="productAll.jsp" class="admin-action">View All Products</a>
                </div>
            </div>            <div class="admin-widget">
                <h3>Orders</h3>
                <p>Order management</p>
                
                <% 
                Map<String, Integer> orderStats = (Map<String, Integer>) request.getAttribute("orderStats");
                if (orderStats != null) {
                %>
                <div style="margin-bottom: 15px; padding: 10px; background-color: #f1f1f1; border-radius: 5px;">
                    <h4 style="margin-top: 0; color: #333;">Order Statistics</h4>
                    <div style="display: flex; flex-wrap: wrap; gap: 10px;">
                        <% if (orderStats.containsKey("Pending")) { %>
                        <div style="padding: 5px 10px; background-color: #6c757d; color: white; border-radius: 4px;">
                            Pending: <%= orderStats.get("Pending") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Processing")) { %>
                        <div style="padding: 5px 10px; background-color: #ffc107; color: #212529; border-radius: 4px;">
                            Processing: <%= orderStats.get("Processing") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Shipped")) { %>
                        <div style="padding: 5px 10px; background-color: #17a2b8; color: white; border-radius: 4px;">
                            Shipped: <%= orderStats.get("Shipped") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Delivered")) { %>
                        <div style="padding: 5px 10px; background-color: #28a745; color: white; border-radius: 4px;">
                            Delivered: <%= orderStats.get("Delivered") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Cancelled")) { %>
                        <div style="padding: 5px 10px; background-color: #dc3545; color: white; border-radius: 4px;">
                            Cancelled: <%= orderStats.get("Cancelled") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Total")) { %>
                        <div style="padding: 5px 10px; background-color: #007bff; color: white; border-radius: 4px;">
                            Total: <%= orderStats.get("Total") %>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } else { %>
                <div style="margin-bottom: 15px; padding: 10px; background-color: #f1f1f1; border-radius: 5px;">
                    <h4 style="margin-top: 0; color: #333;">Order Statistics</h4>
                    <p>Statistics not available. Click "Refresh Stats" to load data.</p>
                </div>
                <% } %>
                  <div class="admin-actions">
                    <a href="OrdersDetails?username=admin" class="admin-action">View All Orders</a>
                    <a href="javascript:void(0)" onclick="window.location.href='OrdersProduct?username=admin'" class="admin-action">Customer Orders</a>
                    <a href="OrderStats" class="admin-action">Refresh Stats</a>
                </div>
            </div>
            <div class="admin-widget">
                <h3>Feedback</h3>
                <p>Customer feedback</p>
                <div class="admin-actions">
                    <a href="suggestionDetails?action=listAll" class="admin-action">View Suggestions</a>
                </div>            </div>
        </div>
    </div>
    <% } // End of admin section %>

    <div class="container">
        <%
            @SuppressWarnings("unchecked")
            ArrayList<ProductData> products = (ArrayList<ProductData>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (ProductData product : products) {
        %>
            <div class="card">                <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/image/<%= product.getImage() %>" 
                         onerror="this.onerror=''; this.src='${pageContext.request.contextPath}/image/76245.PNG'; if(this.src.indexOf('/image/76245.PNG') > -1 && this.naturalWidth === 0) { this.outerHTML='<div class=&quot;image-placeholder&quot;>Image Not Available</div>'; }"
                         alt="Product Image">
                <% } else { %>
                    <div class="image-placeholder">No Image Available</div>
                <% } %>
                <h3><%= product.getName() %></h3>
                <p>Price: Rs.<%= product.getPrice() %></p>
                <button class="button" onclick="location.href='shop.jsp?id=<%= product.getId() %>'">Shop Now</button>
            </div>
        <%
                }
            } else {
        %>
            <div class="intro" style="width: 100%;">
                <h3>No Products Available</h3>
                <p>Check back later for our latest products or visit our categories page to browse different sections.</p>
            </div>
        <% } %>
    </div>
    
    <div class="message-icon">
        <a href="suggestion.jsp" title="Submit Suggestion">
            <i class="fas fa-comment-alt"></i> 💬
        </a>
    </div>

    <script>
        // Automatic carousel
        let slideIndex = 0;
        const slides = document.getElementById("slides");
        const slideCount = document.querySelectorAll(".slide").length;
        const slideWidth = 100; // In percentage
        
        function nextSlide() {
            slideIndex = (slideIndex + 1) % slideCount;
            slides.style.transform = `translateX(-${slideIndex * slideWidth}%)`;
        }
        
        // Change slide every 5 seconds
        setInterval(nextSlide, 5000);
    </script>
</body>
</html>
