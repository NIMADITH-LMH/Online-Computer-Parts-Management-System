<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Categories - Online Computer Parts Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }
        
        h1 {
            text-align: center;
            color: #2c3e50;
            margin: 30px 0;
        }
        
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }
        
        .category-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            text-align: center;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        
        .category-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        
        .category-image {
            height: 150px;
            background-color: #2c3e50;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.5rem;
            position: relative;
            overflow: hidden;
        }
        
        .category-image::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0) 100%);
            z-index: 1;
        }
          .category-image.processors {
            background: linear-gradient(135deg, #3498db, #2c3e50);
        }
        
        .category-image.motherboards {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
        }
        
        .category-image.graphics {
            background: linear-gradient(135deg, #f1c40f, #f39c12);
        }
        
        .category-image.memory {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
        }
        
        .category-image.storage {
            background: linear-gradient(135deg, #1abc9c, #16a085);
        }
        
        .category-image.peripherals {
            background: linear-gradient(135deg, #34495e, #2c3e50);
        }
        
        .category-icon {
            position: relative;
            z-index: 2;
            font-size: 3rem;
        }
        
        .category-name {
            padding: 15px;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .category-description {
            padding: 0 15px 15px;
            flex-grow: 1;
        }
        
        .view-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin: 15px;
            font-weight: 500;
            transition: background-color 0.3s;
        }
        
        .view-btn:hover {
            background-color: #c0392b;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 14px;
            margin-top: 40px;
            background-color: #2c3e50;
            color: white;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <h1>Browse Categories</h1>
          <div class="categories-grid">
            <div class="category-card">
                <div class="category-image processors">
                    <div class="category-icon">🖥️</div>
                </div>
                <div class="category-name">Processors</div>
                <div class="category-description">High-performance CPUs from leading brands including Intel and AMD for all computing needs.</div>
                <a href="productDetails?id=Processor"><button class="view-btn">View Products</button></a>
            </div>
            
            <div class="category-card">
                <div class="category-image motherboards">
                    <div class="category-icon">🔌</div>
                </div>
                <div class="category-name">Motherboards</div>
                <div class="category-description">Quality motherboards with various chipsets and features for your perfect PC build.</div>
                <a href="productDetails?id=Motherboard"><button class="view-btn">View Products</button></a>
            </div>
            
            <div class="category-card">
                <div class="category-image graphics">
                    <div class="category-icon">🎮</div>
                </div>
                <div class="category-name">Graphics Cards</div>
                <div class="category-description">Powerful graphics solutions for gaming, content creation, and professional applications.</div>
                <a href="productDetails?id=Graphic Card"><button class="view-btn">View Products</button></a>
            </div>
            
            <div class="category-card">
                <div class="category-image memory">
                    <div class="category-icon">💾</div>
                </div>
                <div class="category-name">Memory</div>
                <div class="category-description">RAM modules with various capacities and speeds to enhance your system performance.</div>
                <a href="productDetails?id=Memory"><button class="view-btn">View Products</button></a>
            </div>
              <div class="category-card">
                <div class="category-image storage">
                    <div class="category-icon">💽</div>
                </div>
                <div class="category-name">Storage Solutions</div>
                <div class="category-description">SSDs, HDDs, and external storage options for all your data storage needs.</div>
                <a href="productDetails?id=Casing"><button class="view-btn">View Products</button></a>
            </div>
              <div class="category-card">
                <div class="category-image peripherals">
                    <div class="category-icon">⌨️</div>
                </div>
                <div class="category-name">Peripherals</div>
                <div class="category-description">Keyboards, mice, monitors, and other essential computer peripherals and accessories.</div>
                <a href="productDetails?id=Keyboard"><button class="view-btn">View Products</button></a>
            </div>
        </div>
    </div>    <footer>
        <p>&copy; <%= Calendar.getInstance().get(Calendar.YEAR) %> Online Computer Parts Store. All rights reserved.</p>
    </footer>
</body>
</html> 