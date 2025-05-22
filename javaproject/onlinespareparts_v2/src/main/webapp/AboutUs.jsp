<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About Us - Online Computer Parts Store</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        
        .about-container {
            width: 80%;
            margin: 30px auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
            text-align: center;
        }
        
        h2 {
            color: #3498db;
            margin: 25px 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #ecf0f1;
        }
        
        p {
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .mission-vision {
            display: flex;
            justify-content: space-between;
            margin: 30px 0;
        }
        
        .mission, .vision {
            width: 48%;
            padding: 20px;
            background-color: #ecf0f1;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .team-section {
            margin: 30px 0;
        }
        
        .team-member {
            margin-bottom: 15px;
            padding: 15px;
            background-color: #f9f9f9;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .role-specific {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
        }
        
        .contact-us {
            background-color: #ecf0f1;
            padding: 20px;
            margin-top: 30px;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>
        <%@ include file="header.jsp" %>
    
    <div class="about-container">
        <h1>About Our Online Computer Parts Store</h1>
        
        <p>Welcome to our Online Computer Parts Store, your one-stop shop for all computer hardware needs. 
        We specialize in providing high-quality computer components, peripherals, and accessories for enthusiasts, 
        professionals, and casual users alike.</p>
        
        <div class="mission-vision">
            <div class="mission">
                <h2>Our Mission</h2>
                <p>To provide top-quality computer parts at competitive prices with exceptional customer service, 
                helping our customers build, upgrade, and maintain their perfect computing systems.</p>
            </div>
            
            <div class="vision">
                <h2>Our Vision</h2>
                <p>To become the leading online retailer of computer components, known for reliability, 
                technical expertise, and customer satisfaction in the rapidly evolving technology market.</p>
            </div>
        </div>
        
        <h2>Our Story</h2>
        <p>Founded in 2020, our online store began with a simple goal: to make quality computer parts accessible to everyone. 
        What started as a small operation has grown into a comprehensive platform serving thousands of customers nationwide. 
        Our team consists of tech enthusiasts who understand the importance of reliable components in building powerful computing systems.</p>
          <% 
           String userType = (String)session.getAttribute("type");
           if(userType != null) { 
        %>
           
           <!-- Role-specific information -->
           <div class="role-specific">
               <% if("user".equals(userType)) { %>
                   <h2>For Our Valued Customers</h2>
                   <p>As a registered customer, you have access to exclusive benefits:</p>
                   <ul>
                       <li>Track your order status in real-time</li>
                       <li>Receive special discounts and promotional offers</li>
                       <li>Save your favorite items for future purchases</li>
                       <li>Get personalized recommendations based on your preferences</li>
                       <li>Access detailed product specifications and compatibility information</li>
                   </ul>
                   <p>We value your feedback and are committed to continuously improving your shopping experience.</p>
               <% } else if("seller".equals(userType)) { %>
                   <h2>For Our Partner Sellers</h2>
                   <p>As a seller on our platform, you have access to tools that help you manage your products and orders:</p>
                   <ul>
                       <li>Manage your product inventory easily</li>
                       <li>Track orders and update delivery status</li>
                       <li>Access sales analytics and performance data</li>
                       <li>Connect with customers through our messaging system</li>
                       <li>Participate in promotional events to boost visibility</li>
                   </ul>
                   <p>Our success is built on your success. We provide the platform and tools; you provide the expertise and quality products.</p>
               <% } else if("admin".equals(userType)) { %>
                   <h2>Platform Administration</h2>
                   <p>As an administrator, you have comprehensive access to manage the platform:</p>
                   <ul>
                       <li>User management - create, modify, or remove user accounts</li>
                       <li>Product oversight - review and moderate all product listings</li>
                       <li>Order supervision - monitor transactions and resolve disputes</li>
                       <li>System configuration - optimize platform settings for performance</li>
                       <li>Analytics dashboard - access comprehensive business intelligence data</li>
                   </ul>
                   <p>Your role is crucial in maintaining the integrity and performance of the platform.</p>
               <% } %>
           </div>
        <% } %>
        
        <h2>Our Products</h2>
        <p>We offer a wide range of computer components including:</p>
        <ul>
            <li>Processors (CPUs) - The brain of your computer</li>
            <li>Graphics Cards - For stunning visuals in gaming and professional applications</li>
            <li>Memory (RAM) - For smooth multitasking and application performance</li>
            <li>Storage Solutions - SSDs and HDDs for all your data needs</li>
            <li>Motherboards - The foundation of your system</li>
            <li>Power Supplies - Reliable power for your components</li>
            <li>Cases and Cooling - For an optimized and stylish build</li>
            <li>Peripherals - Monitors, keyboards, mice, and more</li>
        </ul>
        
        <h2>Quality Assurance</h2>
        <p>Every product listed on our store undergoes rigorous quality checks. We work directly with manufacturers 
        and authorized distributors to ensure you receive genuine, factory-fresh components with full warranties.</p>
        
        <div class="contact-us">
            <h2>Contact Us</h2>
            <p>Have questions or need assistance? Our support team is here to help!</p>
            <p>Email: support@computerparts.com</p>
            <p>Phone: (123) 456-7890</p>
            <p>Hours: Monday-Friday, 9:00 AM - 6:00 PM</p>
        </div>
    </div>
    
</body>
</html>
