<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="contextPath" content="${pageContext.request.contextPath}">    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/image-styles.css" rel="stylesheet">
    <script>
        window.contextPath = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/js/image-helper.js"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            background-color: #f4f4f4; /* Light background color */
        }
        
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            background-color: #2c3e50; /* Modern dark blue background */
            color: white; /* White text color */
            border-bottom: 2px solid #ddd;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .header .image img {
            margin-right: 10px;
            border-radius: 50%;
            border: 2px solid #fff;
        }

        .header .name h1 {
            font-size: 24px;
            margin: 0;
            font-weight: 700; /* Bold font */
            color: #ecf0f1; /* Light text color */
        }

        .header .shoppingCart {
            margin-right: 20px; /* Space between cart and status */
        }

        .header .shoppingCart a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            background-color: #e74c3c; /* Cart button color */
            padding: 8px 15px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .header .shoppingCart a:hover {
            background-color: #c0392b; /* Darker on hover */
        }

        .header .shoppingCart a img {
            margin-right: 8px;
        }

        .header .status {
            display: flex;
            align-items: center;
        }

        .header .status a {
            color: white;
            text-decoration: none;
            margin-left: 10px; /* Space between links */
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .header .status a:hover {
            background-color: rgba(255,255,255,0.1);
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #34495e; /* Darker blue for navigation */
            width: 100%;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        li {
            float: left;
        }

        li a, .dropbtn {
            display: inline-block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
            transition: background-color 0.3s; /* Smooth transition for hover */
        }

        li a:hover, .dropdown:hover .dropbtn {
            background-color: #2c3e50; /* Darker on hover */
        }

        li.dropdown {
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #34495e;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 0 0 4px 4px;
        }

        .dropdown-content a {
            color: white;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

        .dropdown-content a:hover {
            background-color: #2c3e50; /* Darker on hover */
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }
    </style>
</head>
<body>
<% 
String Username = (String) request.getSession().getAttribute("username");
%>    
    <div class="header">        
        <div class="image">
            <img src="${pageContext.request.contextPath}'/onlinespareparts_v2/img/logo.jpg' width="40px" height="40px" alt="Logo" onerror="this.src='${pageContext.request.contextPath}/image/76245.PNG'; this.onerror='';">
        </div>
        <div class="name">
            <h1>Online Spare Parts Store</h1>
        </div>
        <% 
        // Only show shopping cart for regular users (not admin or seller)
        String type = (String)request.getSession().getAttribute("type");
        if(!"admin".equals(type) && !"seller".equals(type)) { 
        %>
        <div class="shoppingCart">
            <a href="selectServlat?id=<%= Username%>"><img src="shoppingcart.png" width="24px" height="24px" alt="Cart"> Cart</a>
        </div>
        <% } %>
        <div class="status">
            <%
            
        
                if (Username != null) {
            %>
            <a href="profileuser?profile=<%= Username %>">Hello, <%= Username %>!</a>
            / <a href="logoutuser"> Logout</a>
            <% } else { %>
                <a href="login.jsp">Login</a> / <a href="register.jsp"> Register</a>
            <% } %>
        </div>    </div>
	<% 
	if("user".equals(type)){ %>
	<ul>
        <li><a href="homeservlat">Home</a></li>
        <li><a href="#news">About Us</a></li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Monitors &amp; Displays</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Monitor">Monitor</a>
                <a href="productDetails?id=Projector">Projector</a>
            </div>
        </li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Computing Components</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Processor">Processor</a>
                <a href="productDetails?id=Motherboard">Motherboard</a>
                <a href="productDetails?id=Memory">Memory </a>
                <a href="productDetails?id=Graphic Card">Graphic Card </a>
                <a href="productDetails?id=Power Supply">Power Supply </a>
            </div>
        </li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Storage Solutions</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Casing">Casing</a>
                <a href="productDetails?id=Cooler">Cooler</a>
            </div>
        </li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Input Devices</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Mouse">Mouse</a>
                <a href="productDetails?id=Keyboard">Keyboard</a>
                <a href="productDetails?id=Drawing Pad">Drawing Pad</a>
                <a href="productDetails?id=Webcam">Webcam</a>
            </div>
        </li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Output Devices</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Printers">Printer</a>
                <a href="productDetails?id=Scanner">Scanner</a>
                <a href="productDetails?id=Speaker">Speaker</a>
            </div>
        </li>
    </ul>
    <%}else if("seller".equals(type)){ %>
    <ul>
        <li><a href="homeservlat">Home</a></li>
        <li><a href="#news">About Us</a></li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Products</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Monitor">Monitor</a>
                <a href="productDetails?id=Projector">Projector</a>
                <a href="productDetails?id=Processor">Processor</a>
                <a href="productDetails?id=Motherboard">Motherboard</a>
                <a href="productDetails?id=Memory">Memory </a>
                <a href="productDetails?id=Graphic Card">Graphic Card </a>
                <a href="productDetails?id=Power Supply">Power Supply </a>
                <a href="productDetails?id=Casing">Casing</a>
                <a href="productDetails?id=Cooler">Cooler</a>
                <a href="productDetails?id=Mouse">Mouse</a>
                <a href="productDetails?id=Keyboard">Keyboard</a>
                <a href="productDetails?id=Drawing Pad">Drawing Pad</a>
                <a href="productDetails?id=Webcam">Webcam</a>
                <a href="productDetails?id=Printers">Printer</a>
                <a href="productDetails?id=Scanner">Scanner</a>
                <a href="productDetails?id=Speaker">Speaker</a>
            </div>        </li>
        <li><a href="OrdersDetails?username=<%=Username %>">Orders Status</a></li>
        <li class="dropdown">
            <a href="Dashboard?id=<%= Username %>" class="dropbtn">DashBoard</a>
            <div class="dropdown-content">
                
            </div>
        </li>
        <li class="dropdown">
            <a href="OrderedDetails?id=<%= Username %>" class="dropbtn">Orders</a>
            <div class="dropdown-content">
                
            </div>
        </li>
        
    </ul>
    <%}else if("admin".equals(type)){ %>
    <ul>
        <li><a href="homeservlat">Home</a></li>
        <li><a href="#news">About Us</a></li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Manage Users</a>
            <div class="dropdown-content">
                <a href="addCustomersorSellers.jsp">Add User</a>
                <a href="AdminServlet?action=listUsers&view=delete">Delete User</a>
                <a href="AdminServlet?action=listUsers&view=convert">Convert User</a>
            </div>
        </li>
        <li class="dropdown">
            <a href="javascript:void(0)" class="dropbtn">Products</a>
            <div class="dropdown-content">
                <a href="productDetails?id=Monitor">Monitor</a>
                <a href="productDetails?id=Projector">Projector</a>
                <a href="productDetails?id=Processor">Processor</a>
                <a href="productDetails?id=Motherboard">Motherboard</a>
                <a href="productDetails?id=Memory">Memory </a>
                <a href="productDetails?id=Graphic Card">Graphic Card </a>
                <a href="productDetails?id=Power Supply">Power Supply </a>
                <a href="productDetails?id=Casing">Casing</a>
                <a href="productDetails?id=Cooler">Cooler</a>
                <a href="productDetails?id=Mouse">Mouse</a>
                <a href="productDetails?id=Keyboard">Keyboard</a>
                <a href="productDetails?id=Drawing Pad">Drawing Pad</a>
                <a href="productDetails?id=Webcam">Webcam</a>
                <a href="productDetails?id=Printers">Printer</a>
                <a href="productDetails?id=Scanner">Scanner</a>
                <a href="productDetails?id=Speaker">Speaker</a>            </div>
        </li>
        <li><a href="OrdersDetails?username=<%=Username %>">Orders Status</a></li>
    </ul>
    <%} %>
    
</body>
</html>
