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
        }
        .image-placeholder {
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
            <div class="slide"><img src="slid1.jpg" alt="Hero Image 1"></div>
            <div class="slide"><img src="slid2.jpg" alt="Hero Image 2"></div>
            <div class="slide"><img src="slid3.jpg" alt="Hero Image 3"></div>
        </div>
    </div>

    <div class="intro">
        <h2>Welcome to Our Online Spare Parts Store!</h2>
        <p>Your one-stop shop for all spare parts needs. We offer a wide range of products to suit your needs and ensure quality and affordability. Explore our latest products and enjoy exclusive deals!</p>
        <p>Looking for something specific? Use our search feature or browse our categories!</p>
        <button class="button" onclick="location.href='categories.jsp'">Browse Categories</button>
    </div>    <% 
    if ("admin".equals(session.getAttribute("type"))) { 
        // If admin and no order stats yet, redirect to get them
        if (request.getAttribute("orderStats") == null) {
            String redirectURL = "OrderStats";
            response.sendRedirect(redirectURL);
            return;
        }
        
        // Properly declare and initialize the orderStats variable
        Map<String, Integer> orderStats = (Map<String, Integer>) request.getAttribute("orderStats");
    %><div class="admin-dashboard">
        <h2>Admin Dashboard</h2>
        
        <div style="margin-bottom: 20px; text-align: right;">
            <a href="OrderStats?targetPage=adminDashboard" style="display: inline-block; padding: 8px 15px; background-color: #3498db; color: white; text-decoration: none; border-radius: 4px; font-weight: bold;">
                Open Full Admin Dashboard
            </a>
        </div>
        
        <!-- Admin Overview Stats -->
        <div style="display: flex; justify-content: space-between; margin-bottom: 20px; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 200px; background-color: #3498db; color: white; padding: 15px; border-radius: 8px; margin: 0 10px 10px 0; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                <div style="font-size: 24px; font-weight: bold;">
                    <%= orderStats != null && orderStats.containsKey("Total") ? orderStats.get("Total") : 0 %>
                </div>
                <div style="font-size: 16px;">Total Orders</div>
            </div>
            <div style="flex: 1; min-width: 200px; background-color: #2ecc71; color: white; padding: 15px; border-radius: 8px; margin: 0 10px 10px 0; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                <div style="font-size: 24px; font-weight: bold;">
                    <%= orderStats != null && orderStats.containsKey("Delivered") ? orderStats.get("Delivered") : 0 %>
                </div>
                <div style="font-size: 16px;">Completed Orders</div>
            </div>
            <div style="flex: 1; min-width: 200px; background-color: #e74c3c; color: white; padding: 15px; border-radius: 8px; margin: 0 10px 10px 0; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                <div style="font-size: 24px; font-weight: bold;">
                    <%= orderStats != null && orderStats.containsKey("Pending") ? orderStats.get("Pending") : 0 %>
                </div>
                <div style="font-size: 16px;">Pending Orders</div>
            </div>
            <div style="flex: 1; min-width: 200px; background-color: #f39c12; color: white; padding: 15px; border-radius: 8px; margin: 0 0 10px 0; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                <div style="font-size: 24px; font-weight: bold;">
                    <%= orderStats != null && orderStats.containsKey("Processing") ? orderStats.get("Processing") : 0 %>
                </div>
                <div style="font-size: 16px;">Processing Orders</div>
            </div>
        </div>
        
        <div class="admin-widgets">
            <!-- Users Widget -->
            <div class="admin-widget" style="background: linear-gradient(to bottom right, #ffffff, #f5f5f5);">
                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                    <div style="background-color: #3498db; width: 40px; height: 40px; border-radius: 10px; display: flex; justify-content: center; align-items: center; margin-right: 10px;">
                        <span style="color: white; font-size: 20px;">👤</span>
                    </div>
                    <h3 style="margin: 0; color: #2c3e50;">Users Management</h3>
                </div>
                <p>Add, update, or remove users from the system</p>
                <div class="admin-actions">
                    <a href="addCustomersorSellers.jsp" class="admin-action" style="background-color: #3498db;">
                        <span style="margin-right: 5px;">➕</span> Add User
                    </a>
                    <a href="deleteCustomersorSellers.jsp" class="admin-action" style="background-color: #e74c3c;">
                        <span style="margin-right: 5px;">❌</span> Delete User
                    </a>
                    <a href="convertCustomersorSellers.jsp" class="admin-action" style="background-color: #f39c12;">
                        <span style="margin-right: 5px;">🔄</span> Convert User
                    </a>
                    <a href="selectUser" class="admin-action" style="background-color: #2ecc71;">
                        <span style="margin-right: 5px;">👁️</span> View All Users
                    </a>
                </div>
            </div>
            
            <!-- Products Widget -->
            <div class="admin-widget" style="background: linear-gradient(to bottom right, #ffffff, #f5f5f5);">
                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                    <div style="background-color: #9b59b6; width: 40px; height: 40px; border-radius: 10px; display: flex; justify-content: center; align-items: center; margin-right: 10px;">
                        <span style="color: white; font-size: 20px;">🛒</span>
                    </div>
                    <h3 style="margin: 0; color: #2c3e50;">Products Management</h3>
                </div>
                <p>Add new products or manage existing inventory</p>
                <div class="admin-actions">
                    <a href="addproduct.jsp" class="admin-action" style="background-color: #9b59b6;">
                        <span style="margin-right: 5px;">➕</span> Add Product
                    </a>
                    <a href="productAll.jsp" class="admin-action" style="background-color: #8e44ad;">
                        <span style="margin-right: 5px;">🔍</span> View All Products
                    </a>
                </div>
            </div>
            
            <!-- Orders Widget -->
            <div class="admin-widget" style="background: linear-gradient(to bottom right, #ffffff, #f5f5f5);">
                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                    <div style="background-color: #27ae60; width: 40px; height: 40px; border-radius: 10px; display: flex; justify-content: center; align-items: center; margin-right: 10px;">
                        <span style="color: white; font-size: 20px;">📦</span>
                    </div>
                    <h3 style="margin: 0; color: #2c3e50;">Orders Management</h3>
                </div>
                <p>Track and manage customer orders</p>
                
                <% 
                Map<String, Integer> orderStats = (Map<String, Integer>) request.getAttribute("orderStats");
                if (orderStats != null) {
                %>
                <div style="margin-bottom: 15px; padding: 10px; background-color: #f9f9f9; border-radius: 8px; border-left: 4px solid #27ae60;">
                    <h4 style="margin-top: 0; color: #2c3e50; font-size: 16px;">Order Status Summary</h4>
                    <div style="display: flex; flex-wrap: wrap; gap: 8px;">
                        <% if (orderStats.containsKey("Pending")) { %>
                        <div style="padding: 5px 10px; background-color: #6c757d; color: white; border-radius: 15px; font-size: 13px; display: flex; align-items: center;">
                            <span style="display: inline-block; width: 8px; height: 8px; background-color: white; border-radius: 50%; margin-right: 5px;"></span>
                            Pending: <%= orderStats.get("Pending") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Processing")) { %>
                        <div style="padding: 5px 10px; background-color: #ffc107; color: #212529; border-radius: 15px; font-size: 13px; display: flex; align-items: center;">
                            <span style="display: inline-block; width: 8px; height: 8px; background-color: #212529; border-radius: 50%; margin-right: 5px;"></span>
                            Processing: <%= orderStats.get("Processing") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Shipped")) { %>
                        <div style="padding: 5px 10px; background-color: #17a2b8; color: white; border-radius: 15px; font-size: 13px; display: flex; align-items: center;">
                            <span style="display: inline-block; width: 8px; height: 8px; background-color: white; border-radius: 50%; margin-right: 5px;"></span>
                            Shipped: <%= orderStats.get("Shipped") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Delivered")) { %>
                        <div style="padding: 5px 10px; background-color: #28a745; color: white; border-radius: 15px; font-size: 13px; display: flex; align-items: center;">
                            <span style="display: inline-block; width: 8px; height: 8px; background-color: white; border-radius: 50%; margin-right: 5px;"></span>
                            Delivered: <%= orderStats.get("Delivered") %>
                        </div>
                        <% } %>
                        
                        <% if (orderStats.containsKey("Cancelled")) { %>
                        <div style="padding: 5px 10px; background-color: #dc3545; color: white; border-radius: 15px; font-size: 13px; display: flex; align-items: center;">
                            <span style="display: inline-block; width: 8px; height: 8px; background-color: white; border-radius: 50%; margin-right: 5px;"></span>
                            Cancelled: <%= orderStats.get("Cancelled") %>
                        </div>
                        <% } %>
                    </div>
                </div>
                <% } %>
                
                <div class="admin-actions">
                    <a href="ordersdetails?username=admin" class="admin-action" style="background-color: #27ae60;">
                        <span style="margin-right: 5px;">🔍</span> View All Orders
                    </a>
                    <a href="javascript:void(0)" onclick="window.location.href='OrdersProduct?username=admin'" class="admin-action" style="background-color: #2ecc71;">
                        <span style="margin-right: 5px;">👤</span> Customer Orders
                    </a>
                    <a href="OrderStats" class="admin-action" style="background-color: #16a085;">
                        <span style="margin-right: 5px;">🔄</span> Refresh Stats
                    </a>
                </div>
            </div>
            
            <!-- Feedback Widget -->
            <div class="admin-widget" style="background: linear-gradient(to bottom right, #ffffff, #f5f5f5);">
                <div style="display: flex; align-items: center; margin-bottom: 10px;">
                    <div style="background-color: #e67e22; width: 40px; height: 40px; border-radius: 10px; display: flex; justify-content: center; align-items: center; margin-right: 10px;">
                        <span style="color: white; font-size: 20px;">💬</span>
                    </div>
                    <h3 style="margin: 0; color: #2c3e50;">Customer Feedback</h3>
                </div>
                <p>Review customer suggestions and feedback</p>
                <div class="admin-actions">
                    <a href="suggestion.jsp" class="admin-action" style="background-color: #e67e22;">
                        <span style="margin-right: 5px;">📝</span> View Suggestions
                    </a>
                </div>
            </div>
        </div>
    </div>
    <% } %>

    <div class="container">
        <%
            @SuppressWarnings("unchecked")
            ArrayList<ProductData> products = (ArrayList<ProductData>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (ProductData product : products) {
        %>
            <div class="card">
                <% if (product.getImage() != null && !product.getImage().isEmpty()) { %>
                    <img src="${pageContext.request.contextPath}/image/<%= product.getImage() %>" 
                         onerror="this.outerHTML='<div class=\"image-placeholder\">Image Not Available</div>'"
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
